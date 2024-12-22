{
  config,
  lib,
  ...
}: let
  cfg = config.myHome.git;
in {
  options.myHome.git = {
    userName = lib.mkOption {
      type = lib.types.str;
      default = config.home.username;
      description = "The name to use for commits";
    };
    userEmail = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "The email to use for commits";
    };
    extraConfig = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "Extra configuration options to pass to git";
    };
  };

  config = {
    programs.git = {
      enable = true;
      userName = cfg.userName;
      userEmail = cfg.userEmail;
      extraConfig =
        {
          init.defaultBranch = "main";
          safe.directory = ["/etc/nixos"];
        }
        // cfg.extraConfig;
    };
  };
}