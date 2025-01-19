class Dsc < Formula
  version "3.0.0-preview.8"

  desc "Microsoft Desired State Configuration v3"
  homepage "https://github.com/PowerShell/DSC"

on_macos do
  if Hardware::CPU.intel?
    arch = "x86_64-apple-darwin"
    sha256 "FC3AAA3F0A36F48D220726895BBF8A3375C43A926DF3D3C57BE873313846EEEF"
    url "https://github.com/PowerShell/DSC/releases/download/v#{version}/DSC-#{version}-#{arch}.tar.gz"
  elsif Hardware::CPU.arm?
    arch = "aarch64-apple-darwin"
    sha256 "02378B85BDE208238ACC55290EF5B1AA3B5CA884AD514D7A6BC01334C287274C"
    url "https://github.com/PowerShell/DSC/releases/download/v#{version}/DSC-#{version}-#{arch}.tar.gz"
  end
end

on_linux do
  if Hardware::CPU.intel?
    arch = "x86_64-unknown-linux-gnu"
    sha256 "677264514D58B339F75795D2627F8C288642C096DB8C6C544FD673D684044E15"
    url "https://github.com/PowerShell/DSC/releases/download/v#{version}/DSC-#{version}-#{arch}.tar.gz"
  elsif Hardware::CPU.arm?
    arch = "aarch64-unknown-linux-gnu"
    sha256 "668F15F564655145B3C9448C5C4C410521A777FAA09117B36CCCD94E00165F80"
    url "https://github.com/PowerShell/DSC/releases/download/v#{version}/DSC-#{version}-#{arch}.tar.gz"
  end
end

livecheck do
  url "https://github.com/PowerShell/DSC/releases"
  strategy :page_match
  regex(%r{href=.*?/tag/v?(\d+(?:\.\d+)+-preview\.\d+)}i)
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