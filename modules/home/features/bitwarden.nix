# Home manager module that configures Bitwarden
{
  config,
  lib,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      bitwarden-desktop
    ];
    sessionVariables = {
      SSH_AUTH_SOCK = "~/.bitwarden-ssh-agent.sock";
    };
  };

  # Conditionally persist directories
  myHome = lib.mkIf config.myHome.impermanence.enable {
    impermanence = {
      directories = [
        ".config/Bitwarden"
      ];
      files = [
        ".bitwarden-ssh-agent.sock"
      ];
    };
  };
}
