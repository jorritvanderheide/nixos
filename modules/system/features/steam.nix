# System module that configures Steam
{...}: {
  programs = {
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };

    gamemode.enable = true;
  };

  # Support for Steam controller
  hardware.steam-hardware.enable = true;
}
