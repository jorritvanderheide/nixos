{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.myHomeManager.fish;
in {
  options.myHomeManager.fish = {
    plugins = lib.mkOption {
      default = [];
      description = "List of plugins";
    };
    shellAliases = lib.mkOption {
      default = {};
      description = "Shell aliases";
    };
  };

  config = {
    programs.fish = {
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
      '';
      plugins = with pkgs;
        [
          fishPlugins.hydro
        ]
        ++ cfg.plugins;
      shellAliases = {} // cfg.shellAliases;
    };

    myHomeManager.impermanence.directories = [
      ".local/share/fish"
    ];
  };
}
