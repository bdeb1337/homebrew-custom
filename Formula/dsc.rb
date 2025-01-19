class Dsc < Formula
  desc "Microsoft Desired State Configuration v3"
  homepage "https://github.com/PowerShell/DSC/releases"
  version "3.0.0-preview.8"

  livecheck do
    url :homepage
    strategy :page_match
    regex(%r{href=.*?/releases/tag/v?(\d+(?:\.\d+)+-preview\.\d+)}i)
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/PowerShell/DSC/releases/download/v3.0.0-preview.8/DSC-3.0.0-preview.8-x86_64-apple-darwin.tar.gz"
      sha256 "fc3aaa3f0a36f48d220726895bbf8a3375c43a926df3d3c57be873313846eeef"
    elsif Hardware::CPU.arm?
      url "https://github.com/PowerShell/DSC/releases/download/v3.0.0-preview.8/DSC-3.0.0-preview.8-aarch64-apple-darwin.tar.gz"
      sha256 "02378b85bde208238acc55290ef5b1aa3b5ca884ad514d7a6bc01334c287274c"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/PowerShell/DSC/releases/download/v3.0.0-preview.8/DSC-3.0.0-preview.8-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "677264514d58b339f75795d2627f8c288642c096db8c6c544fd673d684044e15"
    elsif Hardware::CPU.arm?
      url "https://github.com/PowerShell/DSC/releases/download/v3.0.0-preview.8/DSC-3.0.0-preview.8-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "668f15f564655145b3c9448c5c4c410521a777faa09117b36cccd94e00165f80"
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
