{ config, lib, pkgs, ... }:
   
{
    options = {
        zip = {
            enable = lib.mkEnableOption {
                description = "enable zip";
                default = false;
            };
        };
    };

    config = lib.mkIf (config.zip.enable) {
        home-manager.users.eli = {
            home.packages = with pkgs; [ zip unzip ];
        };
    };
}
