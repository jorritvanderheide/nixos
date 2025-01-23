# System module that configures Steam
{...}: {
  programs = {
    gamemode.enable = true;

    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
  };

  # Support for Steam controller
  hardware.steam-hardware.enable = true;
}
