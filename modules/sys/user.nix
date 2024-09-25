{ config, lib, pkgs, ... }:

{
    config = {
        users.users.eli = {
            isNormalUser = true;
            extraGroups = [ "wheel" ];
        };

        home-manager.users.eli = {
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
