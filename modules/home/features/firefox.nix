# Home manager module that configures Firefox
{
  config,
  lib,
  ...
}: {
  programs = {
    firefox = {
      enable = true;
      languagePacks = [ "nl" "en-US" ];

      policies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        EnableTrackingProtection = {
          Value= true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        DisablePocket = true;
        DisableFirefoxAccounts = true;
        DisableAccounts = true;
        DisableFirefoxScreenshots = true;
        OverrideFirstRunPage = "";
        OverridePostUpdatePage = "";
        DontCheckDefaultBrowser = true;
        DisplayBookmarksToolbar = "never"; # alternatives: "always" or "newtab"
        DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
        SearchBar = "unified"; # alternative: "separate"

        # Check about:support for extension/add-on ID strings.
        # Valid strings for installation_mode are "allowed", "blocked",
        # "force_installed" and "normal_installed".
        ExtensionSettings = {
          "*".installation_mode = "blocked"; # blocks all addons except the ones specified below
          # uBlock Origin:
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
          };
          # Privacy Badger:
          "jid1-MnnxcxisBPnSXQ@jetpack" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
            installation_mode = "force_installed";
          };
          # Bitwardenrd:
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
            installation_mode = "force_installed";
          };
        };
  
        # Check about:config for options.
        Preferences = { 
          "browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
          "extensions.pocket.enabled" = "lock-false";
          "extensions.screenshots.disabled" = "lock-true";
          "browser.topsites.contile.enabled" = "lock-false";
          "browser.formfill.enable" = "lock-false";
          "browser.search.suggest.enabled" = "lock-false";
          "browser.search.suggest.enabled.private" = "lock-false";
          "browser.urlbar.suggest.searches" = "lock-false";
          "browser.urlbar.showSearchSuggestionsFirst" = "lock-false";
          "browser.newtabpage.activity-stream.feeds.section.topstories" = "lock-false";
          "browser.newtabpage.activity-stream.feeds.snippets" = "lock-false";
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = "lock-false";
          "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = "lock-false";
          "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = "lock-false";
          "browser.newtabpage.activity-stream.section.highlights.includeVisited" = "lock-false";
          "browser.newtabpage.activity-stream.showSponsored" = "lock-false";
          "browser.newtabpage.activity-stream.system.showSponsored" = "lock-false";
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = "lock-false";
        };
      };
    };
  };

  # Conditionally persist directories
  myHome = lib.mkIf config.myHome.impermanence.enable {
    impermanence.directories = [
      ".mozilla"
    ];
  };
}
