{ config, lib, pkgs, pkgs-unstable, self, ... }:

{
    imports = [ 
        ../../x
        ../../pkg
    ];
  
    home.stateVersion = "24.05";

    home.username = "eli";
    home.homeDirectory = "/home/eli";
    home.sessionPath = [ "$HOME/bin" ];

    home.file.".mkshrc".source = ../../dots/mkshrc;
    home.file."bin" = {
        source = ../../bin;
        recursive = true;  
    };

    home.packages = (with pkgs; [
        gavin-bc
        git
        zip
        unzip
        btop
        pfetch
        cmus
        xclip
        maim
        
        _9menu
        dzen2
        lemonbar-xft
        xdotool 
            
        plan9port
        
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
           
        prismlauncher
        openrct2
        protonup-ng
        
        unifont
        uw-ttyp0
        dejavu_fonts
        inconsolata
        
        nix-prefetch-scripts
    ]) ++ (with pkgs-unstable; [
        osu-lazer-bin
    ]);
}
