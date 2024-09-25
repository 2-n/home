{ config, lib, pkgs, ... }:
   
{
    options = {
        bc = {
            enable = lib.mkEnableOption {
                description = "enable bc";
                default = false;
            };
        };
    };

    config = lib.mkIf (config.bc.enable) {
        home-manager.users.eli = {
            home.packages = with pkgs; [ gavin-bc ];
        };
    };
}
