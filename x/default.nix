{ config, lib, pkgs, ... }:
let
    plan9cur = pkgs.callPackage ./xcursor-plan9.nix {};
in
{
    imports = [
        # wm w/ conf
        #./2bwm
        ./cwm
        #./windowchef
    ];

    xsession = {
        enable = true;
        scriptPath = ".config/sx/sxrc";
        initExtra = lib.concatStringsSep "\n" [
            "xrandr -s 2560x1440 -r 144"
            "[[ -e $HOME/.Xresources ]] && xrdb -merge $HOME/.Xresources"
            "${pkgs.hsetroot}/bin/hsetroot -fill $HOME/.bg.png"
            "xsetroot -cursor_name left_ptr"
            "qbittorrent &"
            "corectrl &"
            "bar &"
        ];
    };

    home.file.".bg.png".source = ../dots/bg.png;

    gtk.cursorTheme.name = "plan9";
    home.pointerCursor.name = "plan9";
    gtk.cursorTheme.package = plan9cur;
    home.pointerCursor.package = plan9cur;

    xdg.userDirs = {
        enable = true;
        desktop = "$HOME/";
        documents = "$HOME/doc";
        download = "$HOME/dwn";
        music = "/mnt/hdd/mus";
        pictures = "$HOME/pix";
        videos = "$HOME/vid";
    };
}
