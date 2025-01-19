class Dsc < Formula
  version = "3.0.0-preview.12"

  desc "Microsoft Desired State Configuration v3"
  homepage "https://github.com/PowerShell/DSC"

  if OS.mac?
    if Hardware::CPU.intel?
      arch = "x86_64-apple-darwin"
    elsif Hardware::CPU.arm?
      arch = "aarch64-apple-darwin"
    end
  elsif OS.linux?
    if Hardware::CPU.intel?
      arch = "x86_64-unknown-linux-gnu"
    elsif Hardware::CPU.arm?
      arch = "aarch64-unknown-linux-gnu"
    end
  end

  url "https://github.com/PowerShell/DSC/releases/download/v#{version}/DSC-#{version}-#{arch}.tar.gz"

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