{ config, lib, pkgs, ... }:

{
    config = lib.mkIf (config.gui.enable && config.wm == "2bwm") {
        home-manager.users.eli = {
            xresources.properties = {
                "twobwm.border_width"       = 12;
                "twobwm.outer_border"       = 6;
                "twobwm.focus_color"        = config.theme.base01;
                "twobwm.unfocus_color"      = config.theme.base08;
                "twobwm.fixed_color"        = config.theme.base03;
                "twobwm.unkill_color"       = config.theme.base04;
                "twobwm.fixed_unkill_color" = config.theme.base06;
                "twobwm.outer_border_color" = config.theme.base08;
                "twobwm.inverted_colors"    = false;
            };
            
            home.packages = with pkgs; [
                (_2bwm.overrideAttrs (oldAttrs: rec {
                    src = fetchFromGitHub {
                        owner = "venam";
                        repo = "2bwm";
                        rev = "3ef4149e60f71c74bae5f6b983dbec2fda7cfbab";
                        sha256 = "04b6q7527amwd8ri8v0ybv7144f9h60rklv89hfygncpglwmkv0c";
                    };
                    patches = [ 
                        ./config.diff 
                    ];
                })) 
            ];            
        };
    };
}
