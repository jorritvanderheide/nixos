# Home manager module that configures Firefox
{
  config,
  lib,
  pkgs,
  ...
}: {
  programs = {
    firefox = {
      enable = true;
      languagePacks = ["nl" "en-US"];

      # Set gnome browser connector
      package = pkgs.firefox.override {
        nativeMessagingHosts = [
          pkgs.gnome-browser-connector
        ];
      };

      # https://mozilla.github.io/policy-templates
      policies = {
        # General
        BlockAboutConfig = true;
        BlockAboutProfiles = true;
        BlockAboutSupport = true;
        CaptivePortal = false;
        DisableAppUpdate = true;
        DisableFirefoxAccounts = true;
        DisablePocket = true;
        DisableSetDesktopBackground = true;
        DisplayBookmarksToolbar = "never";
        DisplayMenuBar = "default-off";
        DontCheckDefaultBrowser = true;
        FirefoxHome = {
          Search = true;
          TopSites = false;
          SponsoredTopSites = false;
          Highlights = false;
          Pocket = false;
          SponsoredPocket = false;
          Snippets = false;
          Locked = true;
        };
        FirefoxSuggest = {
          WebSuggestions = false;
          SponsoredSuggestions = false;
          ImproveSuggest = false;
          Locked = true;
        };
        Homepage = {
          Locked = true;
          StartPage = "homepage";
        };
        NewTabPage = true;
        NoDefaultBookmarks = true;
        OverrideFirstRunPage = "";
        OverridePostUpdatePage = "";
        PictureInPicture = false;
        SearchBar = "unified";
        ShowHomeButton = true;
        TranslateEnabled = false;
        UserMessaging = {
          ExtensionRecommendations = false;
          FeatureRecommendations = false;
          UrlbarInterventions = false;
          SkipOnboarding = true;
          MoreFromMozilla = false;
          FirefoxLabs = false;
          Locked = true;
        };

        # Privacy & security
        AutofillAddressEnabled = false;
        AutofillCreditCardEnabled = false;
        Cookies = {
          Behavior = "reject-foreign";
          Locked = true;
        };
        DisableFormHistory = true;
        DisableFirefoxScreenshots = true;
        DisableFirefoxStudies = true;
        DisablePrivateBrowsing = true;
        DisableProfileImport = true;
        DisableSecurityBypass = true;
        DisableTelemetry = true;
        EnableTrackingProtection = true;
        HttpsOnlyMode = "force_enabled";
        PasswordManagerEnabled = false;
        SanitizeOnShutdown = true;
        SearchEngines = {
          Default = "DuckDuckGo";
          PreventInstalls = true;
          Remove = [
            "Bing"
            "Google"
            "Wikipedia"
          ];
        };
        # SearchSuggestEnabled = false;

        # Extensions
        # BlockAboutAddons = false;
        # DisableSystemAddonUpdate = true;
        ExtensionSettings = {
          "*".installation_mode = "blocked";
          # Bitwarden:
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/{446900e4-71c2-419f-a6a7-df9c091e268b}/latest.xpi";
            installation_mode = "force_installed";
          };
          # Clean URLs
          "{74145f27-f039-47ce-a470-a662b129930a}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/{74145f27-f039-47ce-a470-a662b129930a}/latest.xpi";
            installation_mode = "force_installed";
          };
          # I still don't care about cookies
          "idcac-pub@guus.ninja" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/idcac-pub@guus.ninja/latest.xpi";
            installation_mode = "force_installed";
          };
          # Privacy Badger
          "jid1-MnnxcxisBPnSXQ@jetpack" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/jid1-MnnxcxisBPnSXQ@jetpack/latest.xpi";
            installation_mode = "force_installed";
          };
          # Rose Pine Moon
          "{32aac792-0421-4e99-917a-c849311377ce}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/{32aac792-0421-4e99-917a-c849311377ce}/latest.xpi";
            installation_mode = "force_installed";
          };
          # uBlock Origin
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/uBlock0@raymondhill.net/latest.xpi";
            installation_mode = "force_installed";
          };
          # default_area = "menupanel";
          # updates_disabled = true;
        };
        # ExtensionUpdate = false;
        # InstallAddonsPermission = {
        #   Default = false;
        # };

        # Legacy preferences
        # https://mozilla.github.io/policy-templates/#preferences
        # TODO
        # Preferences = {

        # };
      };
    };
  };

  # # Conditionally persist directories
  myHome = lib.mkIf config.myHome.impermanence.enable {
    impermanence.directories = [
      ".mozilla"
    ];
  };
}
