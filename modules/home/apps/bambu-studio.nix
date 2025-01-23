{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    bambu-studio
  ];

  # Conditionally persist directories
  myHome = lib.mkIf config.myHome.impermanence.enable {
    impermanence.directories = [
      ".config/BambuStudio"
    ];
  };
}
