{ config, lib, pkgs, ... }:

{
    options = {
        lemonbar = {
            enable = lib.mkEnableOption {
                description = "enable lemonbar";
                default = false;
            };
        };
    };

    config = lib.mkIf (config.gui.enable && config.lemonbar.enable) {
        home-manager.users.eli = {
            home.packages = with pkgs; [ lemonbar-xft ];
        };
    };
}
