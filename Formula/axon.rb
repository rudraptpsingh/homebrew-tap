class Axon < Formula
  desc "Local hardware intelligence for AI coding agents"
  homepage "https://github.com/rudraptpsingh/axon"
  version "0.1.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/rudraptpsingh/axon/releases/download/v#{version}/axon-aarch64-apple-darwin"
      sha256 "1a774a7e4db24234594ac67878ed0bf0122b071655b00f35ad3d74599df05870"
    else
      url "https://github.com/rudraptpsingh/axon/releases/download/v#{version}/axon-x86_64-apple-darwin"
      sha256 "c87f6282377e8dcdb237adf434c7da46d763140ad20c470740eff3b6f17afb41"
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
