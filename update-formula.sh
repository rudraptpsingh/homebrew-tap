#!/usr/bin/env bash
# Updates the Homebrew formula with SHA256 checksums from a GitHub release.
# Usage: ./update-formula.sh v0.1.0

set -euo pipefail

VERSION="${1:?Usage: $0 <version-tag>}"
FORMULA="Formula/axon.rb"
BASE_URL="https://github.com/rudraptpsingh/axon/releases/download/${VERSION}"
BARE_VERSION="${VERSION#v}"

echo "[info] Downloading checksums for ${VERSION}..."

ARM64_SHA=$(curl -sL "${BASE_URL}/axon-aarch64-apple-darwin.sha256" | awk '{print $1}')
X86_64_SHA=$(curl -sL "${BASE_URL}/axon-x86_64-apple-darwin.sha256" | awk '{print $1}')

if [ -z "$ARM64_SHA" ] || [ -z "$X86_64_SHA" ]; then
  echo "[err] Failed to download checksums. Check that the release exists."
  exit 1
fi

echo "[info] arm64  SHA256: ${ARM64_SHA}"
echo "[info] x86_64 SHA256: ${X86_64_SHA}"

# Generate fresh formula from template
cat > "$FORMULA" << RUBY
class Axon < Formula
  desc "Local hardware intelligence for AI coding agents"
  homepage "https://github.com/rudraptpsingh/axon"
  version "${BARE_VERSION}"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/rudraptpsingh/axon/releases/download/v#{version}/axon-aarch64-apple-darwin"
      sha256 "${ARM64_SHA}"
    else
      url "https://github.com/rudraptpsingh/axon/releases/download/v#{version}/axon-x86_64-apple-darwin"
      sha256 "${X86_64_SHA}"
    end
  end

  def install
    binary = Dir["axon-*"].first
    mv binary, "axon"
    chmod 0755, "axon"
    bin.install "axon"
  end

  def post_install
    ohai "axon installed. Restart your AI agent (Claude Desktop, Cursor, VS Code) to activate."
    ohai "Run 'axon diagnose' to verify."
  end

  test do
    assert_match "axon", shell_output("#{bin}/axon --help")
  end
end
RUBY

echo "[ok] Formula updated for ${VERSION}"
echo ""
echo "Next steps:"
echo "  cd homebrew-axon"
echo "  git add Formula/axon.rb"
echo "  git commit -m \"Update axon to ${BARE_VERSION}\""
echo "  git push"
