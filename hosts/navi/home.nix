{ config, lib, pkgs, pkgs-unstable, ... }:

{
    imports = [ ../../modules/home ];

    home.username = "eli";
    home.homeDirectory = "/home/eli";

    home.file.".mkshrc" = {
        source = config.lib.file.mkOutOfStoreSymlink /home/eli/nix/cfg/mkshrc;
    };
    
    home.file."bin" = {
        source = config.lib.file.mkOutOfStoreSymlink /home/eli/nix/bin;
        recursive = true;
    };

    wm = "cwm";
    
    micro.enable = true;
    alacritty.enable = true;
    firefox.enable = true;
    dmenu.enable = true;

    theme = {
        colors = (import ../../theme/dark);
        font.name = "Terminus";
        font.size = 12;
    };

    home.packages = with pkgs; [
        # cli tools
        # vis
        gavin-bc
        git
        gh
        zip
        unzip
        btop
        pfetch
        cmus

        # x tools
        xclip
        maim
        xdotool
        xorg.xwininfo
        
        _9menu
        dzen2
        lemonbar-xft
        plan9port

        # apps
        imv
        mpv    
        keepassxc
        discord
        qbittorrent
        picard
        gimp
        pcmanfm
        xarchiver
        lxappearance 

        # games 
        # lutris
        prismlauncher
        openrct2
        protonup-ng
    ] ++ (with pkgs-unstable; [
        osu-lazer-bin
    ]);

    xdg.userDirs = {
        enable = true;
        desktop = "$HOME/";
        documents = "$HOME/doc";
        download = "$HOME/dwn";
        music = "/mnt/hdd/mus";
        pictures = "$HOME/pix";
        videos = "$HOME/vid";
    };
    
    home.stateVersion = "24.05";
}
