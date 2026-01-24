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

    home.file = {
        "bin"   = { source = config.lib.file.mkOutOfStoreSymlink /home/eli/nix/bin;
                    recursive = true; };
        ".fvwm" = { source = config.lib.file.mkOutOfStoreSymlink /home/eli/nix/cfg/fvwm;
                    recursive = true; };
        ".config/sx/sxrc".source = config.lib.file.mkOutOfStoreSymlink /home/eli/nix/cfg/sxrc;
        #".bg.png".source   = ../../cfg/bg.png;
    };

    theme = {
        colors = (import ../../theme/light);
        font.name = "SFMono";
        font.size = 12;
    };

    gtk.cursorTheme = {
        package = pkgs.vanilla-dmz;
        name = "DMZ-Black";
        size = 16;
    };

    home.pointerCursor = {
        enable = true;
        package = pkgs.vanilla-dmz;
        name = "DMZ-Black";
        size = 16;
    };
    
    programs = {
        bash.enable = true;
        alacritty.enable = true;
        firefox.enable = true;
        micro.enable = true;
        rofi.enable = true;
    };

    services.easyeffects.enable = true;

    home.packages = with pkgs; [
        git gh fzf
        yazi p7zip
        pfetch tmux
        btop pstree tree

        plan9port 
        ad catclock
        
        dmenu xclip scrot
        hsetroot xdotool        

        arc-theme
        lxappearance

        stalonetray 
        networkmanagerapplet

        vesktop discord
        imv mpv gimp
        feishin spek picard  
        qbittorrent nicotine-plus
        keepassxc
        
        protonup-ng
        pkgs-unstable.osu-lazer-bin
        prismlauncher blockbench
    ];

    xdg = {
        userDirs = {
            enable = true;
            desktop = "$HOME/";
            documents = "$HOME/doc";
            download = "$HOME/dwn";
            music = "/mnt/hdd/mus";
            pictures = "$HOME/pix";
            videos = "$HOME/vid";
            publicShare = null;
            templates = null;
        };
        desktopEntries = {
            "gimp" = {
                name = "GNU Image Manipulation Program";
                noDisplay = true;
            };
            "yazi" = {
                name = "Yazi";
                noDisplay = true;
            };
        };
    };

    home.stateVersion = "24.05";
}
