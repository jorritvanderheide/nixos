# User configuration for Jorrit @ Framework
# TODO move to user folder
{...}: {
  imports = [
    ../../../users/jorrit
  ];

  # myHome configuration
  config.myHome = {
    ## Apps
    apps = {
      bambu-studio.enable = true;
      brave.enable = true;
      discord.enable = true;
      obsidian.enable = true;
      pinta.enable = true;
      signal.enable = true;
      spotify.enable = true;

      ### VSCode
      vscode = {
        enable = true;
        setEditor = true;
      };
    };

    ## Core
    core = {
      direnv.enable = true;
      impermanence.enable = true;
    };

    ## Terminal
    terminal = {
      blackbox.enable = true;
      fish.enable = true;
      starfish.enable = true;
    };

    ## Theming
    theming = {
      gtk.enable = true;
      stylix.enable = true;
    };

    ## Utilities
    utilities = {
      fastfetch.enable = true;
      vlc.enable = true;
    };
  };
}
