class Axon < Formula
  desc "Local hardware intelligence for AI coding agents"
  homepage "https://github.com/rudraptpsingh/axon"
  version "0.2.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/rudraptpsingh/axon/releases/download/v#{version}/axon-aarch64-apple-darwin"
      sha256 "4aba10125de006f5a10bcfe75f32a7c5bc05a57bc5ba5f0371c33a240f2391c0"
    else
      url "https://github.com/rudraptpsingh/axon/releases/download/v#{version}/axon-x86_64-apple-darwin"
      sha256 "9c44b9cc4a0eff975308189082202ae060401e851a267134ae1d8932996e26ac"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/rudraptpsingh/axon/releases/download/v#{version}/axon-aarch64-unknown-linux-gnu"
      sha256 "9366768b0322ce51895bb5e5dd2ded1b78453c2ade22df88d790f02412336edc"
    else
      url "https://github.com/rudraptpsingh/axon/releases/download/v#{version}/axon-x86_64-unknown-linux-gnu"
      sha256 "4f41eba9361cdbe7a1862eaba5e24eb74a6ef46984315ff6778f1657ecb276b0"
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
