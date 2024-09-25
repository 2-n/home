{ config, lib, pkgs, ... }:

{
    config = lib.mkIf (config.gui.enable) {
        home-manager.users.eli = {
            home.packages = with pkgs; [ imv mpv cmus ];
        };
    };
}
