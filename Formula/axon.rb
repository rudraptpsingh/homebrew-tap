class Axon < Formula
  desc "Local hardware intelligence for AI coding agents"
  homepage "https://github.com/rudraptpsingh/axon"
  version "0.2.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/rudraptpsingh/axon/releases/download/v#{version}/axon-aarch64-apple-darwin"
      sha256 "44497ced728f9d6f259c6890eea92ed0e7509bba748fdeb7c2e05f0a3e975dc4"
    else
      url "https://github.com/rudraptpsingh/axon/releases/download/v#{version}/axon-x86_64-apple-darwin"
      sha256 "61e6adde6087eebd993850971fc37a4f1924b10c64f5f6a19b57a3fbed01baa3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/rudraptpsingh/axon/releases/download/v#{version}/axon-aarch64-unknown-linux-gnu"
      sha256 "984da9d58171c5635df30b28ae79cb37654f1e7452792bb1889e23798545932b"
    else
      url "https://github.com/rudraptpsingh/axon/releases/download/v#{version}/axon-x86_64-unknown-linux-gnu"
      sha256 "f2a410932f4597b30e5a2e4d1f24bce0f735841d48acacaa37e8760e1b31bc3c"
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
