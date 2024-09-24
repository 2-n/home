{ config, lib, pkgs, ... }:

{
    options = {
        firefox = {
            enable = lib.mkEnableOption {
                description = "enable firefox";
                default = false;
            };
        };
    };

    config = lib.mkIf (config.gui.enable && config.firefox.enable) {
        home-manager.users.eli = {
            programs.firefox = {
                enable = true;
                policies = {
                    AutofillCreditCardEnabled = false;
                    DisableFirefoxStudies = true;
                    DisablePocket = true;
                    DisableTelemetry = true;
                    DisplayBookmarksToolbar = "newtab";
                    EncryptedMediaExtensions = true;
                    HardwareAcceleration = true;
                    HttpsOnlyMode = "enabled";
                    NoDefaultBookmarks = true;
                    OfferToSaveLogins = false;
                    PasswordManagerEnabled = false;
                    PrimaryPassword = false;
                    SearchBar = "unified";
                    ShowHomeButton = false;
                    Extensions.Install = [
                        "https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/latest.xpi"
                        "https://addons.mozilla.org/en-US/firefox/addon/sponsorblock/latest.xpi"
                        "https://addons.mozilla.org/en-US/firefox/addon/return-youtube-dislikes/latest.xpi"
                        "https://addons.mozilla.org/en-US/firefox/addon/facebook-container/latest.xpi"
                    ];
                    FirefoxHome = {
                        "Search" = false;
                        "TopSites" = false;
                        "SponsoredTopSights" = false;
                        "Highlights" = false;
                        "Pocket" = false;
                        "SponsoredPocket" = false;
                        "Snippets" = false;
                        "Locked" = false;
                    };
                    Preferences = {
                        "general.autoScroll" = true;
                        "general.smoothScroll" = true;
                    };
                };
                profiles.eli = {
                    search = {
                        force = true;
                        default = "Google";
                        engines = {
                            "Arch Wiki" = {
                                definedAliases = [ "@aw" ];
                                urls = [{ template = "https://wiki.archlinux.org/index.php?search={searchTerms}"; }];
                            };
                            "Home Manager" = {
                                definedAliases = [ "@hm" ];
                                urls = [{ template = "https://home-manager-options.extranix.com/?query={searchTerms}&release=release-24.05"; }];
                            };
                            "NixOS Options" = {
                                definedAliases = [ "@no" ];
                                urls = [{ template = "https://search.nixos.org/options?channel=24.05&query={searchTerms}"; }];
                            };
                            "NixOS Packages" = {
                                definedAliases = [ "@np" ];
                                urls = [{ template = "https://search.nixos.org/packages?channel=24.05&query={searchTerms}"; }];
                            };
                            "NixOS Wiki" = {
                                definedAliases = [ "@nw" ];
                                urls = [{ template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; }];
                            };
                            "YouTube" = {
                                definedAliases = [ "@yt" ];
                                urls = [{ template = "https://www.youtube.com/results?search_query={searchTerms}"; }];
                            };
                            "Amazon".metaData.hidden = true;
                            "Bing".metaData.hidden = true;
                            "DuckDuckGo".metaData.hidden = true;
                            "eBay".metaData.hidden = true;
                            "Wikipedia (en)".metaData.hidden = true;
                        };
                    };
                };
            };
        };
    };
}
