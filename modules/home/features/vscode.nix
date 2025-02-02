# Home manager module that configures Visual Studio Code
# TODO: clean
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.myHome.vscode;
in {
  options.myHome.vscode = {
    extensions = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
      description = "Extensions to intall";
    };
    setEditor = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "set as $EDITOR";
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
          b4dm4n.vscode-nixpkgs-fmt
          bradlc.vscode-tailwindcss
          eamodio.gitlens
          esbenp.prettier-vscode
          # github.copilot
          # github.copilot-chat
          jnoortheen.nix-ide
          mkhl.direnv
          ms-azuretools.vscode-docker
        ]
        ++ cfg.extensions;

      # Settings
      enableUpdateCheck = false;
      userSettings =
        lib.mkForce
        {
          ## Editor settings
          "editor.fontFamily" = "'Cascadia Code', Consolas, 'Courier New', monospace";
          "editor.fontLigatures" = false;
          "editor.formatOnSave" = false;
          "editor.minimap.enabled" = false;
          "editor.tokenColorCustomizations" = {
            "textMateRules" = [
              {
                "scope" = [
                  "comment"
                  "entity.name.type.class"
                  "entity.other.attribute-name"
                  "keyword"
                  "constant"
                  "storage.modifier"
                  "storage.type.class.js"
                ];
                "settings" = {
                  "fontStyle" = "italic";
                };
              }
            ];
          };

          ## Extensions settings
          "extensions.ignoreRecommendations" = true;
          "docker.composeCommand" = "docker compose";
          "prettier.requireConfig" = true;
          "tailwindCSS.rootFontSize" = 10;

          ## Git settings
          "git.autofetch" = true;
          "git.confirmSync" = false;
          "git.openRepositoryInParentFolders" = "always";
          "git.suggestSmartCommit" = false;

          ## Other settings
          "terminal.integrated.fontLigatures" = true;
          "window.menuBarVisibility" = "toggle";
          "window.titleBarStyle" = "custom";
          "workbench.colorTheme" = "Stylix";
          "workbench.startupEditor" = "none";

          ## Nix settings
          "[nix]" = {
            "editor.defaultFormatter"= "jnoortheen.nix-ide";
          };
          "nix.serverPath" = "nixd";
          "nix.editor.defaultFormatter" = "jnoortheen.nix-ide";
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

    # Conditionally set as default editor
    home.sessionVariables.EDITOR = lib.mkIf cfg.setEditor "code --wait";

    # Conditionally enable persist
    myHome = lib.mkIf config.myHome.impermanence.enable {
      impermanence.directories = [
        ".config/Code"
        ".vscode"
      ];
    };
  };
}
