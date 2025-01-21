# Home manager module that configures Blackbox terminal
{
  lib,
  pkgs,
  ...
}: {
  dconf.settings = {
    "com/raggesilver/BlackBox" = {
      easy-copy-paste = true;
      font = "MesloLGS NF 12";
      remember-window-size = true;
      show-headerbar = false;
      style-preference = lib.hm.gvariant.mkUint32 2;
      terminal-bell = false;
      terminal-padding = with lib.hm.gvariant;
        mkTuple
        [
          (mkUint32 24)
          (mkUint32 24)
          (mkUint32 24)
          (mkUint32 24)
        ];
      theme-dark = "One Dark";
      working-directory-mode = 1;
    };
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      add_newline = true;
      format = "$hostname$username$directory$git_branch$git_commit$git_status$nix_shell$character";
      line_break = true;

      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[✖](bold red)";
      };

      directory = {
        read_only = "";
        repo_root_style = "(bold blue";
      };

      git_branch = {
        style = "bold green";
        symbol = "🌱 ";
      };

      nix_shell = {
        format = "via [$symbol dev-shell]($style) ";
        style = "bold cyan";
        symbol = "❄️ ";
      };
    };
  };

  home = {
    packages = with pkgs; [
      blackbox-terminal
    ];

    sessionVariables.STARSHIP_LOG = "error";
  };
}
