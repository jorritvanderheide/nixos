# Home manager module that configures Fish shell
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.myHome.fish;
in {
  options.myHome.fish = {
    plugins = lib.mkOption {
      type = lib.types.listOf (lib.types.submodule {
        options = {
          name = lib.mkOption {
            type = lib.types.str;
            description = "name of the plugin";
          };
          src = lib.mkOption {
            type = lib.types.package;
            description = "source of the plugin";
          };
        };
      });
      default = [];
      description = "plugins to use";
    };
    shellAliases = lib.mkOption {
      type = lib.types.attrsOf (lib.types.nullOr (lib.types.either lib.types.str lib.types.path));
      default = {};
      description = "shell aliases";
    };
  };

  config = {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set -g fish_greeting
      '';
      plugins =
        [
          {
            name = "hydro";
            src = pkgs.fishPlugins.hydro;
          }
        ]
        ++ cfg.plugins;
      shellAliases =
        {
          # General
          ".." = "cd ..";
          "..." = "cd ../..";

          # Git
          "g" = "git";
          "ga" = "git add";
          "gc" = "git commit";
          "gp" = "git push";
          "gs" = "git status";
          "gd" = "git diff";
          "gco" = "git checkout";
          "gb" = "git branch";

          # Nix
          "nswitch" = "sudo nixos-rebuild switch --flake /etc/nixos#$(hostname)";
          "nboot" = "sudo nixos-rebuild boot --flake /etc/nixos#$(hostname)";
          "nbuild" = "sudo nixos-rebuild build --flake /etc/nixos#$(hostname)";
          "nrollback" = "sudo nixos-rebuild switch --rollback";
          "nclean" = "nix-collect-garbage -d";
          "nupdate" = "nix flake update --flake /etc/nixos";
          "nshell" = "nix-shell -p";
          "ndev" = "nix develop";
          "nedit" = "code /etc/nixos";

          # Utility
          "c" = "clear";
          "mkd" = "mkdir -p";
        }
        // cfg.shellAliases;
    };
  };
}
