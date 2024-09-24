{ config, lib, pkgs, ... }:

{
    options = {
        ninemenu = {
            enable = lib.mkEnableOption {
                description = "enable 9menu";
                default = false;
            };
        };
    };

    config = lib.mkIf (config.gui.enable && config.ninemenu.enable) {
        home-manager.users.eli = {
            home.packages = with pkgs; [ _9menu ];
        };
    };
}
