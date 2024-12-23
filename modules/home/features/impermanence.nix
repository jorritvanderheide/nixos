{
  config,
  inputs,
  lib,
  ...
}: let
  cfg = config.myHome.impermanence;
in {
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  options.myHome.impermanence = {
    directories = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Directories to persist";
    };
    files = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Files to persist";
    };
  };

  config = {
    home.persistence."/persist${config.home.homeDirectory}" = {
      allowOther = true;
      directories =
        [
          "Desktop"
          "Documents"
          "Downloads"
          "Music"
          "Pictures"
          "Public"
          "Templates"
          "Videos"
          ".gnupg"
          ".ssh"
          ".local/share/keyrings"
        ]
        ++ cfg.directories;
      files =
        [
          ".screenrc"
        ]
        ++ cfg.files;
    };
  };
}
