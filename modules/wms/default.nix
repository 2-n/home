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

    config = lib.mkIf (config.gui.enable) {
        home-manager.users.eli = {
            home.pointerCursor.name = "plan9";
            home.pointerCursor.package = plan9cur;
            home.pointerCursor.size = 16;
            gtk.cursorTheme.name = "plan9";
            gtk.cursorTheme.package = plan9cur;
            gtk.cursorTheme.size = 16;
        };
    };
}
