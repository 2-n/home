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
        ".xinitrc".source = config.lib.file.mkOutOfStoreSymlink /home/eli/nix/cfg/xinitrc;
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
        alacritty.enable = true;
        bash.enable = true;
        firefox.enable = true;
        micro.enable = true;
    };

    home.packages = with pkgs; [
        btop pstree tree
        fzf pfetch tmux

        plan9port

        dmenu scrot xclip
        hsetroot xdotool

        colloid-gtk-theme
        
        lxappearance lxmenu-data

        gimp imv mpv
        pcmanfm xarchiver

        keepassxc vesktop

        qbittorrent
        feishin picard spek

        protonup-ng
        prismlauncher
        pkgs-unstable.osu-lazer-bin
    ];

    xdg.userDirs = {
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

    home.stateVersion = "24.05";
}
