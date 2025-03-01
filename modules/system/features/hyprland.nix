# System module that configures a standard Hyprland setup
{
  inputs,
  pkgs,
  ...
}: {
  # Enable Hyprland
  programs.hyprland = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    hyprnome
    kitty # Required for the default Hyprland config
    rofi-wayland
    swww
  ];

  # Set the Ozone Wayland environment variable
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
