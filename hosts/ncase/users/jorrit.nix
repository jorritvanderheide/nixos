# User configuration for Jorrit @ Ncase
{...}: {
  imports = [
    ../../../users/jorrit
  ];

  # myHome configuration
  config.myHome = {
    ## Features
    bambu-studio.enable = true;
    bitwarden.enable = true;
    direnv.enable = true;
    discord.enable = true;
    firefox.enable = true;
    fish.enable = true;
    impermanence.enable = true;
    matrix.enable = true;
    obsidian.enable = true;
    pinta.enable = true;
    signal.enable = true;
    spotify.enable = true;
    steam.enable = true;
    terminal.enable = true;
    theming.enable = true;

    ## VS Code
    vscode = {
      enable = true;
      setEditor = true;
    };
  };
}
