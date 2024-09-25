{ config, lib, pkgs, pkgs-unstable, ... }:

{
    options = {
        gaming.osu = {
            enable = lib.mkEnableOption {
                description = "enable osu";
                default = false;
            };
        };
    };

    config = lib.mkIf (config.gaming.osu.enable) {
        services.udev.extraRules = ''
            KERNEL=="hidraw*", SUBSYSTEM=="hidraw", OWNER="eli"
        '';
        
        home-manager.users.eli = {
            home.packages = with pkgs-unstable; [ osu-lazer-bin ];
        };
    };
}
