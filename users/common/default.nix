#
#   ___ ___  _ __ ___  _ __ ___   ___  _ __
#  / __/ _ \| '_ ` _ \| '_ ` _ \ / _ \| '_ \
# | (_| (_) | | | | | | | | | | | (_) | | | |
#  \___\___/|_| |_| |_|_| |_| |_|\___/|_| |_|
#
#
# Common home configuration for all users.
{config, ...}: let
  imports = [
    inputs.home-manager.nixosModules.default

    ../../modules/impermanence
  ];
in {
  # End of config
  home.stateVersion = "24.05"; # Do not change or remove

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
