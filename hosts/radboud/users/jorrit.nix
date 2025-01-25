# User configuration for Jorrit @ Radboud
# TODO move to user folder
{...}: {
  imports = [
    ../../../users/jorrit
  ];

  # myHome configuration
  config.myHome = {
    ## Features
    brave.enable = true;
    direnv.enable = true;
    discord.enable = true;
    fetch.enable = true;
    fish.enable = true;
    impermanence.enable = true;
    obsidian.enable = true;
    pinta.enable = true;
    signal.enable = true;
    spotify.enable = true;
    terminal.enable = true;
    theming.enable = true;

    ## VS Code
    vscode = {
      enable = true;
      setEditor = true;
    };
  };
}
