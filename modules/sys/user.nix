{ config, lib, pkgs, ... }:

{
    config = {
        users.users.eli = {
            isNormalUser = true;
            extraGroups = [ "wheel" ];
        };

        home-manager.users.eli = { config, pkgs, ... }: {
            home.file.".mkshrc".source = config.lib.file.mkOutOfStoreSymlink /home/eli/nix/cfg/mkshrc;
            home.file."bin" = {
                source = config.lib.file.mkOutOfStoreSymlink /home/eli/nix/bin;
                recursive = true;
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
        };
    };
}
