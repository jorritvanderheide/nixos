{config, pkgs, ...}: {
  home.packages = with pkgs; [
    brave
  ];

  myHome = lib.mkIf config.myHome.impermanence.enable {
    impermanence.directories = [
      ".config/BraveSoftware/Brave-Browser"
    ];
  };
}
