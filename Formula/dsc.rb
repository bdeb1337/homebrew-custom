class Dsc < Formula
  desc "Microsoft Desired State Configuration v3"
  homepage "https://github.com/PowerShell/DSC/releases"
  #version "3.1.0"

  livecheck do
    url :homepage
    strategy :github_latest
    regex(%r{href=.*?/releases/tag/v?(\d+(?:\.\d+)+)}i)
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/PowerShell/DSC/releases/download/v3.1.0/DSC-3.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "1a1772fde7fee00b12c4879164cdc1df02001db0a8d6d01a1454e888e5bd3a89"
    elsif Hardware::CPU.arm?
      url "https://github.com/PowerShell/DSC/releases/download/v3.1.0/DSC-3.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "a1c5bce4739af27e55811a5aafe75090cd1384b9e7b5054d63eaca37b6d3d691"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/PowerShell/DSC/releases/download/v3.1.0/DSC-3.1.0-x86_64-linux.tar.gz"
      sha256 "7b2fc0d8e50e35dcd8cb45d63e7d461f4a3023becaf493b0d235cce6dd3004dd"
    elsif Hardware::CPU.arm?
      url "https://github.com/PowerShell/DSC/releases/download/v3.1.0/DSC-3.1.0-aarch64-linux.tar.gz"
      sha256 "cd00859739c5b5b9bd3625909014cb23ad13d7536f864c6f3fd9cf6022c6d533"
    end
  end

  def install
    prefix.install Dir["*"]
    # Create a wrapper script
    (bin/"dsc").write <<~EOS
      #!/bin/bash
      cd #{prefix} && ./dsc "$@"
    EOS
    (bin/"dsc").chmod 0755
  end
end
