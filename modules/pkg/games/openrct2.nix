{ config, lib, pkgs, ... }:

{
    options = {
        gaming.openrct2 = {
            enable = lib.mkEnableOption {
                description = "enable openrct2";
                default = false;
            };
        };
    };

    config = lib.mkIf (config.gaming.openrct2.enable) {
        home-manager.users.eli = {
            home.packages = with pkgs; [ openrct2 ];
        };
    };
}
