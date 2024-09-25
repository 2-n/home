{ config, lib, pkgs, ... }:

{
    options = {
        keepass = {
            enable = lib.mkEnableOption {
                description = "enable keepass";
                default = false;
            };
        };
    };

    config = lib.mkIf (config.gui.enable && config.keepass.enable) {
        home-manager.users.eli = {
            home.packages = with pkgs; [ keepassxc ];
        };
    };
}
