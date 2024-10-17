#
#   ___ ___  _ __ ___  _ __ ___   ___  _ __
#  / __/ _ \| '_ ` _ \| '_ ` _ \ / _ \| '_ \
# | (_| (_) | | | | | | | | | | | (_) | | | |
#  \___\___/|_| |_| |_|_| |_| |_|\___/|_| |_|
#
#
# Common system configuration for all systems.
{
  config,
  inputs,
  pkgs,
  ...
}: let
  imports = [
    inputs.agenix.nixosModules.age

    ../../modules/impermanence
  ];
in {
  # Nix
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = ["flakes" "nix-command"];
  };

  # Timezone
  time.timeZone = "Europe/Amsterdam";

  # Setup networking
  networking.networkmanager.enable = true;

  # System packages
  environment.systemPackages = with pkgs; [
    agenix
    alejandra
    displaylink
    git
  ];

  # End of config
  system.stateVersion = "24.05"; # Do not change or remove
}
