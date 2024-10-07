{ lib
, config
, pkgs
, ... 
}:

{
    imports = [
        ./2bwm
        ./cwm.nix
        ./windowchef.nix
    ];

    options = {
        windowManager = lib.mkOption {
            type = lib.types.str;
            description = "set the active installed window manager";
        };
    };

    config = {
        home.pointerCursor.name = "plan9";
        home.pointerCursor.package = pkgs.xcursor-plan9;
        gtk.cursorTheme.name = "plan9";
        gtk.cursorTheme.package = pkgs.xcursor-plan9;
    };
}
