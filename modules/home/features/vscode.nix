# Home manager module that configures Visual Studio Code
# TODO: clean
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.myHomeManager.vscode;
in {
  options.myHomeManager.vscode = {
    extensions = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
      description = "Extensions to intall";
    };
    userSettings = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "User settings";
    };
  };

  config = {
    programs.vscode = {
      enable = true;

      # Extensions
      enableExtensionUpdateCheck = false;
      extensions = with pkgs.vscode-extensions;
        [
          bradlc.vscode-tailwindcss
          eamodio.gitlens
          esbenp.prettier-vscode
          # github.copilot
          # github.copilot-chat
          jnoortheen.nix-ide
          mkhl.direnv
          ms-azuretools.vscode-docker
          mvllow.rose-pine
        ]
        ++ cfg.extensions;

      # Settings
      enableUpdateCheck = false;
      userSettings =
        {
          # General settings
          "editor.formatOnSave" = true;
          "editor.minimap.enabled" = false;
          "git.autofetch" = true;
          "git.confirmSync" = false;
          "git.openRepositoryInParentFolders" = "always";
          "git.suggestSmartCommit" = false;
          "window.menuBarVisibility" = "toggle";
          "window.titleBarStyle" = "custom";
          "workbench.startupEditor" = "none";
          "workbench.colorTheme" = "Rosé Pine";

          # Extensions
          "docker.composeCommand" = "docker compose";
          "prettier.requireConfig" = true;
          "tailwindCSS.rootFontSize" = 10;

          # Nix settings
          "nix.serverPath" = "nixd";
          "nix.enableLanguageServer" = true;
          "nix.hiddenLanguageServerErrors" = [
            "textDocument/definition"
            "textDocument/documentHighlight"
            "textDocument/formatting"
          ];
          "nixpkgs" = {
            "expr" = "import <nixpkgs> { }";
          };
          "nix.serverSettings" = {
            "nixd" = {
              "formatting" = {
                "command" = ["alejandra"];
              };
              "options" = {
                "nixos" = {
                  "expr" = "(builtins.getFlake \"/etc/nixos\").nixosConfigurations.framework.options";
                };
                "home-manager" = {
                  "expr" = "(builtins.getFlake \"/etc/nixos\").homeConfigurations.jorrit.options";
                };
              };
            };
          };
        }
        // cfg.userSettings;
    };

    # Conditionally enable persist
    myHome = lib.mkIf config.myHome.impermanence.enable {
      impermanence.directories = [
        ".config/Code"
        ".vscode"
      ];
    };
  };
}
