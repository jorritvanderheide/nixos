# Home manager module that configures Blackbox terminal
{
  lib,
  pkgs,
  ...
}: {
  dconf.settings = {
    "com/raggesilver/BlackBox" = {
      easy-copy-paste = true;
      remember-window-size = true;
      show-headerbar = false;
      style-preference = lib.hm.gvariant.mkUint32 2;
      terminal-bell = false;
      terminal-padding = with lib.hm.gvariant;
        mkTuple
        [
          (mkUint32 24)
          (mkUint32 24)
          (mkUint32 24)
          (mkUint32 24)
        ];
      theme-dark = "One Dark";
      working-directory-mode = 1;
    };
  };

  home.packages = with pkgs; [
    blackbox-terminal
  ];
}
