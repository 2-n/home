{ config, lib, pkgs, ... }:

{
    options = {
        discord = {
            enable = lib.mkEnableOption {
                description = "enable discord";
                default = false;
            };
        };
    };

    config = lib.mkIf (config.gui.enable && config.discord.enable) {
        home-manager.users.eli = {
            home.packages = with pkgs; [ discord ];
        };
    };
}
