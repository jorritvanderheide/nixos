# Home manager module that configures Obsidian
{
  config,
  lib,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      obsidian
      ollama
      open-webui
    ];
    sessionVariables = {
      OLLAMA_ORIGINS = "*";
    };
  };

  # Conditionally persist directories
  myHome = lib.mkIf config.myHome.impermanence.enable {
    impermanence.directories = [
      ".config/obsidian"
      ".ollama"
    ];
  };
}
