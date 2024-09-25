{ config, lib, pkgs, ... }:

{
    options = {
        torrent = {
            enable = lib.mkEnableOption {
                description = "enable torrenting";
                default = false;
            };
        };
    };

    config = lib.mkIf (config.gui.enable && config.torrent.enable) {
        home-manager.users.eli = {
            home.packages = with pkgs; [ qbittorrent picard ];
        };
    };
}
