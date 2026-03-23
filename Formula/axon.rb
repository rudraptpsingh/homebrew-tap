class Axon < Formula
  desc "Local hardware intelligence for AI coding agents"
  homepage "https://github.com/rudraptpsingh/axon"
  version "0.2.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/rudraptpsingh/axon/releases/download/v#{version}/axon-aarch64-apple-darwin"
      sha256 "b047accbdb57c453a99b0a018282d4e0b395730273cad86d6cdfe7cf7ef3e58c"
    else
      url "https://github.com/rudraptpsingh/axon/releases/download/v#{version}/axon-x86_64-apple-darwin"
      sha256 "0fe4d86a18e404d943a772c680957bdaddebb294721ddbbba35baf7cda8d3519"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/rudraptpsingh/axon/releases/download/v#{version}/axon-aarch64-unknown-linux-gnu"
      sha256 "c6a274fe060dc8201ee0f49390ed8fd8055266b9ebd591baba3e283497a91277"
    else
      url "https://github.com/rudraptpsingh/axon/releases/download/v#{version}/axon-x86_64-unknown-linux-gnu"
      sha256 "81fb96ba23b2799b198011bccc4042fdb93d78c0f158b63f1242705a03440af4"
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
