#  _
# (_)_ __ ___  _ __   ___ _ __ _ __ ___   __ _ _ __   ___ _ __   ___ ___
# | | '_ ` _ \| '_ \ / _ \ '__| '_ ` _ \ / _` | '_ \ / _ \ '_ \ / __/ _ \
# | | | | | | | |_) |  __/ |  | | | | | | (_| | | | |  __/ | | | (_|  __/
# |_|_| |_| |_| .__/ \___|_|  |_| |_| |_|\__,_|_| |_|\___|_| |_|\___\___|
#             |_|
#
# Home configuration for impermanence.
{
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  home.persistence."/persist/home/jorrit" = {
    allowOther = true;
    directories = [
      ".config/BraveSoftware/Brave-Browser"
      ".config/Code"
      ".config/discord"
      ".config/git"
      ".config/obsidian"
      ".config/Pinta"
      ".config/Postman"
      ".config/Signal"
      ".config/spotify"
      ".config/teams-for-linux"
      ".vscode"

      # User folders
      "Desktop"
      "Documents"
      "Downloads"
      "Git"
      "Music"
      "Pictures"
      "Public"
      "Templates"
      "Videos"

      # Hidden folders
      ".icons"
      ".pub-cache"
      ".ssh"
      ".themes"
    ];
    files = [
      ".config/monitors.xml"
      ".screenrc"
    ];
  };
}
