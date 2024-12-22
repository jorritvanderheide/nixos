{...}: {
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    # Enable fish integration
    fish.enable = true;
  };

  # Conditionally persist directories
  myHome = lib.mkIf config.myHome.impermanence.enable {
    impermanence.directories = [
      ".local/share/direnv"
    ];
  };
}