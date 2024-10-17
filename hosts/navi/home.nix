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
        git gh btop
        yazi  p7zip
        cmus pfetch

        plan9port
        keepassxc
        
        qbittorrent
        picard gimp
        discord
        imv mpv

        protonup-ng
        prismlauncher
    ] ++ (with pkgs-unstable; [
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
        bemenu  # hikari doesnt have   
    ] else []); # xdg_activation_v1 protocol switch to tofi

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
    };

    home.stateVersion = "24.05";
}
