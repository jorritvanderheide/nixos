#
#  _   _ ___  ___ _ __ _ __   __ _ _ __ ___   ___
# | | | / __|/ _ \ '__| '_ \ / _` | '_ ` _ \ / _ \
# | |_| \__ \  __/ |  | | | | (_| | | | | | |  __/
#  \__,_|___/\___|_|  |_| |_|\__,_|_| |_| |_|\___|
#
#
# Home configuration for username.
{pkgs, ...}: let
  imports = [
    ../../modules/impermanence
  ];
in {
  home.username = "username";
  home.homeDirectory = "/home/username";

  # Packages
  home.packages = [
    # Add user Packages
  ];
}
