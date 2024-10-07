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

    windowManager = "cwm";

    theme = {
        colors = (import ../../theme/dark);
        font.name = "Terminus";
        font.size = 12;
    };
    
    programs = {
        micro.enable = true;
        alacritty.enable = true;
        firefox.enable = true;
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

        xclip 
        maim 
        xdotool 
        xorg.xwininfo
        _9menu
        lemonbar-xft
        dzen2
        dmenu
        
        plan9port

        # apps
        imv
        mpv    
        keepassxc
        discord
        qbittorrent
        picard
        gimp
        #pcmanfm
        #xarchiver
        #lxappearance 

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
