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

        ./labwc.nix
    ];

    options = {
        windowManager = lib.mkOption {
            type = lib.types.str;
            description = "set the active installed window manager";
        };

        withX11 = lib.mkEnableOption {
            description = "windowing system using x11";
            default = false;
        };

        withWayland = lib.mkEnableOption {
            description = "windowing system using wayland";
            default = false;
        };
    };

    config = {
        home.pointerCursor.name = "plan9";
        home.pointerCursor.package = pkgs.xcursor-plan9;
        gtk.cursorTheme.name = "plan9";
        gtk.cursorTheme.package = pkgs.xcursor-plan9;
    };
}
