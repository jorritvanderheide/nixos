# User configuration for Jorrit @ Ncase
# TODO move to user folder
{...}: {
  imports = [
    ../../../users/jorrit
  ];

  # myHome configuration
  config.myHome = {
    ## Features
    blackbox.enable = true;
    brave.enable = true;
    direnv.enable = true;
    discord.enable = true;
    fish.enable = true;
    impermanence.enable = true;
    obsidian.enable = true;
    # secrets.enable = true; # TODO fix
    spotify.enable = true;
    steam.enable = true;
    theming.enable = true;
    vscode.enable = true;
  };
}
