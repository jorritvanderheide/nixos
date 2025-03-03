{
  inputs,
  pkgs,
  ...
}: {
  programs.uwsm.enable = true;

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
    withUWSM = true;
  };

  environment.systemPackages = with pkgs; [
    brightnessctl
    cliphist
    dunst
    hyprlock
    hyprnome
    hyprpicker
    hyprpolkitagent
    kitty
    nautilus
    nwg-look
    pipewire
    playerctl
    swww
    udiskie
    wireplumber
    wl-clipboard
    wofi
  ];

  # Optional, hint Electron apps to use Wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Enable cachix for Hyprland
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };
}
