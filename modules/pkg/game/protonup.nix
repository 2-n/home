{ config, lib, pkgs, ... }:

{
    options = {
        gaming.protonup = {
            enable = lib.mkEnableOption {
                description = "enable protonup";
                default = false;
            };
        };
    };

    config = lib.mkIf (config.gaming.protonup.enable) {
        home-manager.users.eli = {
            home.packages = with pkgs; [ protonup-ng ];
        };
    };
}
