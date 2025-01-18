cask "steamchat" do
  version "0.1.3"
  sha256 "ec20ed2930c9081afce00c4fb7d6707a02acef4c45345d4a7e57631a4548d181"

  url "https://github.com/bdeb1337/steamchat/releases/download/v#{version}/steamchat-#{version}-universal.dmg"
  name "steamchat"
  desc "Electron-based web wrapper for Steam Chat"
  homepage "https://github.com/bdeb1337/steamchat"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "steamchat.app"

  zap trash: "~/Library/Application Support/steamchat"
end
