{ config, lib, pkgs, ... }:

{
    config = lib.mkIf (config.gui.enable && config.audio.enable) {
        home-manager.users.eli = {
            home.packages = with pkgs; [ imv mpv cmus ];
        };
    };
}
