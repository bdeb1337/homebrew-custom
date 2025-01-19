class Dsc < Formula
  desc "Microsoft Desired State Configuration v3"
  homepage "https://github.com/PowerShell/DSC/releases"
  version "3.0.0-preview.12"

  livecheck do
    url :homepage
    strategy :page_match
    regex(%r{href=.*?/releases/tag/v?(\d+(?:\.\d+)+-preview\.\d+)}i)
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/PowerShell/DSC/releases/download/v3.0.0-preview.12/DSC-3.0.0-preview.12-x86_64-apple-darwin.tar.gz"
      sha256 "82c1c2f8601837b6f7da552991fb41d500a2b7b163dafd3d7042fe20c433ece9"
    elsif Hardware::CPU.arm?
      url "https://github.com/PowerShell/DSC/releases/download/v3.0.0-preview.12/DSC-3.0.0-preview.12-aarch64-apple-darwin.tar.gz"
      sha256 "ead49905c5b82bd2d859a8363238ce986f7ee0d5454e6013d3a1f50afde4c326"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/PowerShell/DSC/releases/download/v3.0.0-preview.12/DSC-3.0.0-preview.12-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "49a5cd2c5a6fb269f7480b91a2c3ecdbb9ea37a313a7e8adb1d0b2f93bc5fbd1"
    elsif Hardware::CPU.arm?
      url "https://github.com/PowerShell/DSC/releases/download/v3.0.0-preview.12/DSC-3.0.0-preview.12-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f0a66c784530064af0c94e2de5f075fe79e318803909a4f36a57e1997f32dfe6"
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
