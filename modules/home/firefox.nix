{ lib
, config
, inputs
, ...
}:

{
  imports = [ inputs.betterfox-nix.modules.homeManager.betterfox ];

  config = lib.mkIf (config.programs.firefox.enable) {
    programs.firefox = {
      profiles.eli.userChrome = (builtins.readFile ../../cfg/userChrome.css);
      betterfox = {
        enable = true;
        profiles.eli = {
          enableAllSections = true;
          settings.smoothfox.natural-smooth-scrolling-v3.enable = true;
        };
      };
      policies = {
        # general
        AppAutoUpdate = false;
        AutofillAddressEnabled = false;
        AutofillCreditCardEnabled = false;
        CaptivePortal = false;
        DisableAppUpdate = false;
        DisableFirefoxStudies = true;
        DisableFormHistory = true;
        DisableMasterPasswordCreation = true;
        DisableProfileImport = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        GenerativeAI.Enabled = false;
        HttpsOnlyMode = "enabled";
        OfferToSaveLogins = false;
        OfferToSaveLoginsDefault = false;
        PasswordManagerEnabled = false;
        PopupBlocking.Default = true;
        PrimaryPassword = false;
        SearchSuggestEnabled = false;
        # ui
        DisplayMenuBar = "default-off";
        DisplayBookmarksToolbar = "newtab";
        Homepage.StartPage = "previous-session";
        NoDefaultBookmarks = true;
        SearchBar = "unified";
        # misc
        DisableBuiltinPDFViewer = true;
        DisableSetDesktopBackground = true;
        HardwareAcceleration = true;
        SkipTermsOfUse = true;
        ExtensionSettings = {
          "CanvasBlocker@kkapsner.de" = {
            installation_mode = "force_installed";
            install_url = "http://addons.mozilla.org/firefox/downloads/latest/canvasblocker/latest.xpi";
            default_area = "menupanel";
            private_browsing = true;
          };
          "@testpilot-containers" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/multi-account-containers/latest.xpi";
            default_area = "menupanel";
            private_browsing = true;
          };
          "sponsorBlocker@ajay.app" = {
            installation_mode = "force_installed";
            install_url = "http://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
            default_area = "menupanel";
            private_browsing = true;
          };
          "uBlock0@raymondhill.net" = {
            installation_mode = "force_installed";
            install_url = "http://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            default_area = "menupanel";
            private_browsing = true;
          };
        };
        FirefoxHome = {
          Highlights = false;
          Search = false;
          SponsoredTopSites = false;
          TopSites = false;
        };
        FirefoxSuggest = {
          ImproveSuggest = false;
          SponsoredSuggestions = false;
          WebSuggestions = false;
        };
        Permissions = {
          Autoplay.Default = "block-audio";
          Camera.BlockNewRequests = true;
          Location.BlockNewRequests = true;
          Microphone.BlockNewRequests = true;
          Notifications.BlockNewRequests = true;
          ScreenShare.BlockNewRequests = true;
          VirtualReality.BlockNewRequests = true;
        };
        Preferences = {
          "browser.newtabpage.activity-stream.showWeather" = false;
          "browser.search.separatePrivateDefault" = false;
          "browser.theme.dark-private-windows" = false;
          "browser.uidensity" = 0;
          "extensions.activeThemeID" = "firefox-compact-light@mozilla.org";
          "general.autoScroll" = true;
        };
        SearchEngines.Default = "Startpage";
        SearchEngines.Add = [
          {
            Name = "Arch Wiki";
            Alias = "@aw";
            URLTemplate = "https://wiki.archlinux.org/index.php?search={searchTerms}";
            IconURL = "https://wiki.archlinux.org/favicon.ico";
          }
          {
            Name = "Home Manager";
            Alias = "@hm";
            URLTemplate = "https://home-manager-options.extranix.com/?query={searchTerms}&release=release-25.11";
            IconURL = "https://home-manager-options.extranix.com/images/favicon.png";
          }
          {
            Name = "NixOS Options";
            Alias = "@no";
            URLTemplate = "https://search.nixos.org/options?channel=25.11&query={searchTerms}";
            IconURL = "https://search.nixos.org/favicon.png";
          }
          {
            Name = "NixOS Packages";
            Alias = "@np";
            URLTemplate = "https://search.nixos.org/packages?channel=25.11&query={searchTerms}";
            IconURL = "https://search.nixos.org/favicon.png";
          }
          {
            Name = "NixOS Wiki";
            Alias = "@nw";
            URLTemplate = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
            IconURL = "https://wiki.nixos.org/favicon.ico";
          }
          {
            Name = "ProtonDB";
            Alias = "@pd";
            URLTemplate = "https://www.protondb.com/search?q={searchTerms}";
            IconURL = "https://www.protondb.com/favicon.ico";
          }
          {
            Name = "Startpage";
            Alias = "@sp";
            URLTemplate = "https://www.startpage.com/sp/search?q={searchTerms}";
            IconURL = "https://cdn.startpage.com/sp/cdn/favicons/favicon-16x16-gradient.png";
          }
        ];
        SearchEngines.Remove = [
          "Amazon.com"
          "Bing"
          "Google"
          "Perplexity"
        ];
      };
    };
  };
}
