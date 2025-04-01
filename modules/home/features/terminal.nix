# Home manager module that configures Blackbox terminal
{
  config,
  lib,
  pkgs,
  ...
}: {
  dconf.settings = {
    "com/raggesilver/BlackBox" = {
      easy-copy-paste = true;
      font = "MesloLGS NF 12";
      notify-process-completion = false;
      remember-window-size = false;
      show-headerbar = false;
      style-preference = lib.hm.gvariant.mkUint32 2;
      terminal-bell = false;
      terminal-padding = with lib.hm.gvariant;
        mkTuple
        [
          (mkUint32 16)
          (mkUint32 32)
          (mkUint32 16)
          (mkUint32 32)
        ];
      theme-dark = "Rosé Pine Moon";
      use-sixel = true;
      window-height = lib.hm.gvariant.mkUint32 1080;
      window-width = lib.hm.gvariant.mkUint32 360;
      working-directory-mode = 1;
    };
  };

  programs.starship = lib.mkForce {
    enable = true;
    enableFishIntegration = true;
    settings = {
      add_newline = true;
      format = "$hostname$username$directory$git_branch$git_commit$git_status$nix_shell$character";
      line_break = true;

      character = {
        success_symbol = "[❯](bold #c4a7e7)";
        error_symbol = "[✖](bold #eb6f92)";
      };

      directory = {
        read_only = "";
        repo_root_style = "bold blue";
      };

      git_branch = {
        style = "bold #99c23b";
        symbol = "🌱 ";
        truncation_length = 4;
        truncation_symbol = "";
      };

      nix_shell = {
        format = "via [$symbol dev-shell]($style) ";
        style = "bold #e0e0e0";
        symbol = "🐚";
      };
    };
  };

  home = {
    packages = with pkgs; [
      (blackbox-terminal.override {sixelSupport = true;})
    ];

    sessionVariables.STARSHIP_LOG = "error";

    file = {
      ".local/share/blackbox/schemes/rose-pine-moon.json".text = ''
        {
          "name": "Rosé Pine Moon",
          "comment": "Ported for Terminix Colour Scheme",
          "use-theme-colors": false,
          "foreground-color": "#e0def4",
          "background-color": "#232136",
          "palette": [
            "232136",
            "2a273f",
            "393552",
            "6e6a86",
            "908caa",
            "e0def4",
            "e0def4",
            "56526e",
            "eb6f92",
            "f6c177",
            "ea9a97",
            "3e8fb0",
            "9ccfd8",
            "c4a7e7",
            "f6c177",
            "56526e"
          ]
        }
      '';
    };
  };

  # Conditionally persist directories
  myHome = lib.mkIf config.myHome.impermanence.enable {
    impermanence = {
      directories = [
        ".local/share/blackbox/schemes"
      ];
    };
  };
}
