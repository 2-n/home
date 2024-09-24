{ config, lib, pkgs, ... }:

{
    options = {
        plan9port = {
            enable = lib.mkEnableOption {
                description = "enable plan9port";
                default = false;
            };
        };
    };

    config = lib.mkIf (config.gui.enable && config.plan9port.enable) {
        home-manager.users.eli = {
            home.packages = with pkgs; [ plan9port ];
        };
    };
}
