{ lib
, config
, pkgs
, pkgs-unstable
, ... 
}:

{
    imports = [ ../../modules/home ];

    home.username = "eli";
    home.homeDirectory = "/home/eli";

    home.file.".mkshrc".source = 
        config.lib.file.mkOutOfStoreSymlink /home/eli/nix/cfg/mkshrc;
    
    home.file."bin" = {
        source = 
            config.lib.file.mkOutOfStoreSymlink /home/eli/nix/bin;
        recursive = true;
    };

    windowManager = "labwc";

    theme = {
        colors = (import ../../theme/pastelish-dark);
        font.name = "SFMono Nerd Font";
        font.size = 16;
    };
    
    programs = {
        micro.enable = true;
        firefox.enable = true;
        alacritty.enable = 
            lib.mkIf (config.withX11) true;
        foot.enable = 
            lib.mkIf (config.withWayland) true;
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
        yazi

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

        # gaming 
        # lutris
        prismlauncher
        openrct2
        protonup-ng
    ] ++ (with pkgs-unstable; [
        osu-lazer-bin
    ]) ++ (if config.withX11 then [
        xclip 
        maim
        hsetroot
        xdotool 
        xorg.xwininfo
        _9menu
        lemonbar-xft
        dzen2
        dmenu
    ] else
    if config.withWayland then [
        xwayland
        wl-clipboard-rs
        wlr-randr
        swaybg
        grim
        slurp
        wlrctl
        wmenu
        waybar
    ] else []);

    xdg.portal = lib.mkIf (config.withWayland) {
        enable = true;
        xdgOpenUsePortal = true;
        extraPortals = with pkgs; [
            xdg-desktop-portal-wlr
            xdg-desktop-portal-gtk
        ];
    };

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
