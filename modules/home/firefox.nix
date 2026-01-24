{ lib
, config
, inputs
, ... 
}:

{
    imports = [ inputs.betterfox-nix.modules.homeManager.betterfox ];

    config = lib.mkIf (config.programs.firefox.enable) {
        programs.firefox = {
            betterfox = {
                enable = true;
                profiles.eli = {
                    enableAllSections = true;
                    settings.smoothfox.natural-smooth-scrolling-v3.enable = true;
                };
            };
            policies = {
                AutofillAddressEnabled = false;
                AutofillCreditCardEnabled = false;
                Cookies.Behavior = "reject-tracker-and-partition-foreign";
                #DisableBuiltinPDFViewer = true;
                #DisableFirefoxAccounts = true;
                DisableFirefoxStudies = true;
                DisableFormHistory = true;
                DisableMasterPasswordCreation = true;
                DisablePocket = true;
                DisableSetDesktopBackground = true;
                DisableTelemetry = true;
                DisplayBookmarksToolbar = "newtab";
                DisplayMenuBar = "default-off";
                EncryptedMediaExtensions = true;
                #GenerativeAI.Enabled = false;
                HardwareAcceleration = true;
                Homepage.StartPage = "previous-session";
                #HttpsOnlyMode = "enabled";
                NoDefaultBookmarks = true;
                OfferToSaveLogins = false;
                PasswordManagerEnabled = false;
                PictureInPicture.Enabled = true;
                PopupBlocking.Default = true;
                PrimaryPassword = false;
                SearchBar = "unified";
                SearchSuggestEnabled = false;
                ShowHomeButton = false;
                SkipTermsOfUse = true;
                TranslateEnabled = true;
                ExtensionSettings = {
                    "uBlock0@raymondhill.net" = {
                        installation_mode = "force_installed";
                        install_url = "http://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
                        default_area = "menupanel";
                        private_browsing = true;
                    };
                    "sponsorBlocker@ajay.app" = {
                        installation_mode = "force_installed";
                        install_url = "http://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
                        default_area = "menupanel";
                        private_browsing = true;
                    };
                };
                FirefoxHome = {
                    "Highlights" = false;
                    "Pocket" = false;
                    "Search" = false;
                    "Snippets" = false;
                    "SponsoredPocket" = false;
                    "SponsoredTopSites" = false;
                    "TopSites" = false;
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
                    "browser.uidensity" = 0;
                    "browser.uiCustomization.state" = builtins.toJSON {
                        placements = {
                            nav-bar = [
                                "back-button"
                                "forward-button"
                                "stop-reload-button"
                                "urlbar-container"
                                "downloads-button"
                                "unified-extensions-button"
                            ];
                            TabsToolbar = [
                                "tabbrowser-tabs"
                                "new-tab-button"
                            ];
                        };
                        currentVersion = 23;
                    };
                    "extensions.activeThemeID" = "firefox-compact-light@mozilla.org";
                    "general.autoScroll" = true;
                };
                SearchEngines.Default = "DuckDuckGo";
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
                    #{
                    #    Name = "SearXNG";
                    #    Alias = "@sx";
                    #    URLTemplate = "https://searx.party/search?q={searchTerms}";
                    #    IconURL = "https://searx.space/favicon.png";
                    #}
                ];
                SearchEngines.Remove = [
                    "Amazon.com"
                    "Bing"
                    #"DuckDuckGo"
                    "eBay"
                    "Google"
                    "Perplexity"
                    "Wikipedia (en)"
                ];
            };
        };
    };
}
