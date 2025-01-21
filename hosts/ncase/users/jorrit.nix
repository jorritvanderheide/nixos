# User configuration for Jorrit @ Ncase
# TODO move to user folder
{...}: {
  imports = [
    ../../../users/jorrit
  ];

  # myHome configuration
  config.myHome = {
    ## Features
    bambu-studio.enable = true;
    brave.enable = true;
    direnv.enable = true;
    discord.enable = true;
    fish.enable = true;
    impermanence.enable = true;
    obsidian.enable = true;
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
