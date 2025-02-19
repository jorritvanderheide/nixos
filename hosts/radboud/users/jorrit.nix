# User configuration for Jorrit @ Radboud
{...}: {
  imports = [
    ../../../users/jorrit
  ];

  # myHome configuration
  config.myHome = {
    ## Features
    bitwarden.enable = true;
    direnv.enable = true;
    discord.enable = true;
    eduvpn.enable = true;
    firefox.enable = true;
    fish.enable = true;
    impermanence.enable = true;
    matrix.enable = true;
    obsidian.enable = true;
    pinta.enable = true;
    signal.enable = true;
    spotify.enable = true;
    terminal.enable = true;
    theming.enable = true;
    vlc.enable = true;

    ## Gnome
    gnome.performance = true;

    ## VS Code
    vscode = {
      enable = true;
      setEditor = true;
    };
  };
}
