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
            description = "Name of the plugin";
          };
          src = lib.mkOption {
            type = lib.types.package;
            description = "Source of the plugin";
          };
        };
      });
      default = [];
      description = "The plugins to source in 'conf.d/99plugins.fish'";
    };
    shellAliases = lib.mkOption {
      type = lib.types.attrsOf (lib.types.nullOr (lib.types.either lib.types.str lib.types.path));
      default = {};
      description = "Set of aliases for fish shell, which overwrites 'environment.shellAliases'. See 'environment.shellAliases' for an option format description";
    };
  };

  config = {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set -g fish_greeting
        direnv hook fish | source
      '';
      plugins =
        [
          {
            name = "autopair";
            src = pkgs.fishPlugins.autopair;
          }
          {
            name = "done";
            src = pkgs.fishPlugins.done;
          }
          {
            name = "hydro";
            src = pkgs.fishPlugins.hydro;
          }
          {
            name = "sponge";
            src = pkgs.fishPlugins.sponge;
          }
        ]
        ++ cfg.plugins;
      shellAliases =
        {
          # Nix
          "ncommit" = "sh /etc/nixos/nixos-rebuild.sh $(hostname)";
          "nswitch" = "sudo nixos-rebuild switch --flake /etc/nixos#$(hostname)";
          "nboot" = "sudo nixos-rebuild boot --flake /etc/nixos#$(hostname)";
          "nrollback" = "sudo nixos-rebuild switch --rollback";
          "nclean" = "nix-collect-garbage -d";
          "nupdate" = "nix flake update --flake /etc/nixos";
          "nshell" = "nix-shell -p";
          "ndev" = "nix develop";
          "nedit" = "code /etc/nixos";

          # General
          ".." = "z ..";
          "..." = "z ../..";

          # Utility
          "c" = "clear";
          "mkd" = "mkdir -p";

          # Git
          "g" = "git";
          "ga" = "git add";
          "gc" = "git commit";
          "gp" = "git push";
          "gs" = "git status";
          "gd" = "git diff";
          "gco" = "git checkout";
          "gb" = "git branch";

          # Overwrites
          "ls" = "lsd";
          "cd" = "z";
        }
        // cfg.shellAliases;
    };
  };
}