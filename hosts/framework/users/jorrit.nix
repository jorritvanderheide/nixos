# User configuration for Jorrit @ Framework
# TODO move to user folder
{...}: {
  imports = [
    ../../../users/jorrit
  ];

  # myHome configuration
  config.myHome = {
    ## Features
    audacity.enable = true;
    bambu-studio.enable = true;
    blackbox.enable = true;
    brave.enable = true;
    direnv.enable = true;
    discord.enable = true;
    fish.enable = true;
    impermanence.enable = true;
    obsidian.enable = true;
    signal.enable = true;
    secrets.enable = true;
    spotify.enable = true;
    theming.enable = true;
    vscode.enable = true;
  };
}
