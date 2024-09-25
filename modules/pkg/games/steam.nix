{ config, lib, pkgs, ... }:

{
    options = {
        gaming.steam = {
            enable = lib.mkEnableOption {
                description = "enable steam";
                default = false;
            };
        };
    };

    config = lib.mkIf (config.gaming.steam.enable) {
        programs.steam = {
            enable = true;
            gamescopeSession.enable = true;
            dedicatedServer.openFirewall = true;
        };
    };
}
