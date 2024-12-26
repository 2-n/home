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

    home.file.".mkshrc" = {
        source =
            config.lib.file.mkOutOfStoreSymlink /home/eli/nix/cfg/mkshrc;
    };
    
    home.file."bin" = {
        source = 
            config.lib.file.mkOutOfStoreSymlink /home/eli/nix/bin;
        recursive = true;
    };

    windowManager = "labwc";

    theme = {
        colors = (import ../../theme/pastelish-dark);
        font.name = "SFMono Nerd Font";
        font.size = 15;
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
        git gh  btop
        yazi   p7zip
        cmus  pfetch
        screen jdk17

        plan9port
        keepassxc
        
        picard gimp
        discord
        vesktop
        imv mpv
        libsForQt5.qt5ct

        protontricks
        prismlauncher
    ] ++ (with pkgs-unstable; [
        qbittorrent
        osu-lazer-bin
    ]) ++ (if config.withX11 then [
        xclip maim
        hsetroot
        xdotool 
        _9menu dmenu
        lemonbar-xft
    ] else
    if config.withWayland then [
        xwayland
        wlr-randr
        wl-clipboard-rs
        grim   slurp
        swaybg wmenu
        tofi
        bemenu  # hikari doesnt have xdg_activation_v1 protocol,
    ] else []); # bemenu works but switch to tofi for labwc and hikari

    xdg = {
        userDirs = {
            enable = true;
            desktop = "$HOME/";
            documents = "$HOME/doc";
            download = "$HOME/dwn";
            music = "/mnt/hdd/mus";
            pictures = "$HOME/pix";
            videos = "$HOME/vid";
        };
        portal = lib.mkIf (config.withWayland) {
            enable = true;
            xdgOpenUsePortal = true;
            extraPortals = with pkgs; [
                xdg-desktop-portal-wlr
                xdg-desktop-portal-gtk
            ];
        };
        desktopEntries."gimp" = {
            name = "GNU Image Manipulation Program";
            noDisplay = true;
        };
    };

    home.stateVersion = "24.05";
}
