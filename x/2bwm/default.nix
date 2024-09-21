{ config, lib, pkgs, theme, ... }:

with theme;
{
	xsession.windowManager.command = "exec 2bwm";

	xresources.properties = {
		"twobwm.border_width"       = 12;
		"twobwm.outer_border"       = 3;
		"twobwm.focus_color"        = base01;
		"twobwm.unfocus_color"      = base08;
		"twobwm.fixed_color"        = base03;
		"twobwm.unkill_color"       = base04;
		"twobwm.fixed_unkill_color" = base06;
		"twobwm.outer_border_color" = base08;
		"twobwm.inverted_colors"    = true;
	};
	
	home.packages = (with pkgs; [
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
	]);
}
