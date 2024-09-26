{ config, lib, pkgs, ... }:

{
    options = {
        _9menu = {
            enable = lib.mkEnableOption {
                description = "enable 9menu";
                default = false;
            };
        };
    };

    config = lib.mkIf (config.gui.enable && config._9menu.enable) {
        home-manager.users.eli = {
            home.packages = with pkgs; [ _9menu ];
        };
    };
}
