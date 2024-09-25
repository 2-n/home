{ config, lib, pkgs, ... }:
   
{
    options = {
        git = {
            enable = lib.mkEnableOption {
                description = "enable git";
                default = false;
            };
        };
    };

    config = lib.mkIf (config.git.enable) {
        home-manager.users.eli = {
            home.packages = with pkgs; [ git gh ];
        };
    };
}
