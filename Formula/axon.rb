class Axon < Formula
  desc "Local hardware intelligence for AI coding agents"
  homepage "https://github.com/rudraptpsingh/axon"
  version "0.1.1"
  license "MIT"

  on_arm do
    url "https://github.com/rudraptpsingh/axon/releases/download/v#{version}/axon-aarch64-apple-darwin"
    sha256 "8e6115b7aca8599ae90f0d48303a1883309f4f33b992aae3fc214ea6a0caf4be"
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
