# Home manager module that configures the Hyprland bar
{inputs, ...}: {
  imports = [
    inputs.hyprpanel.homeManagerModules.hyprpanel
  ];

  programs.hyprpanel = {
    enable = true;
    overlay.enable = true;
  };
}
