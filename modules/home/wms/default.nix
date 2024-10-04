{ config, lib, pkgs, ... }:
let
    plan9cur = pkgs.callPackage ./xcursor-plan9.nix {};
in
{
    imports = [
        ./2bwm
        ./cwm
        ./windowchef
    ];

    options = {
        wm = lib.mkOption {
            type = lib.types.str;
            description = "set the active installed window manager";
        };
    };

    config = {
        home.pointerCursor.name = "plan9";
        home.pointerCursor.package = plan9cur;
        gtk.cursorTheme.name = "plan9";
        gtk.cursorTheme.package = plan9cur;
    };
}
