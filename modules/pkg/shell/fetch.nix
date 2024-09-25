{ config, lib, pkgs, ... }:
   
{
    options = {
        fetch = {
            enable = lib.mkEnableOption {
                description = "enable fetch";
                default = false;
            };
        };
    };

    config = lib.mkIf (config.fetch.enable) {
        home-manager.users.eli = {
            home.packages = with pkgs; [ pfetch ];
        };
    };
}
