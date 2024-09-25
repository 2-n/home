{ config, lib, pkgs, ... }:

{
    options = {
        gaming.lutris = {
            enable = lib.mkEnableOption {
                description = "enable lutris";
                default = false;
            };
        };
    };

    config = lib.mkIf (config.gaming.lutris.enable) {
        home-manager.users.eli = {
            home.pkgs = with pkgs; [ lutris ];
        };
    };
}
