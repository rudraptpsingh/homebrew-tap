class Axon < Formula
  desc "Local hardware intelligence for AI coding agents"
  homepage "https://github.com/rudraptpsingh/axon"
  version "0.2.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/rudraptpsingh/axon/releases/download/v#{version}/axon-aarch64-apple-darwin"
      sha256 "b99a31c489d072fd2bddc20755ec5f4c1d911f7f7fd277f7e04059e24a62a11a"
    else
      url "https://github.com/rudraptpsingh/axon/releases/download/v#{version}/axon-x86_64-apple-darwin"
      sha256 "3e8830ff84c15bbca14ae8e43c58ce7658808418a23135b9d9d2d5be1c77fd69"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/rudraptpsingh/axon/releases/download/v#{version}/axon-aarch64-unknown-linux-gnu"
      sha256 "b67007173b5f99970b0f95327eac237ca03473d3e4f6118e2a5d06f3e74ad7fb"
    else
      url "https://github.com/rudraptpsingh/axon/releases/download/v#{version}/axon-x86_64-unknown-linux-gnu"
      sha256 "044ed79ef1e0e6a2cb33c915c878d02d16cff2119af19f080a906b4860db5346"
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
