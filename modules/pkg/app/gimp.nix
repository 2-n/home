{ config, lib, pkgs, ... }:

{
    options = {
        gimp = {
            enable = lib.mkEnableOption {
                description = "enable gimp";
                default = false;
            };
        };
    };

    config = lib.mkIf (config.gui.enable && config.gimp.enable) {
        home-manager.users.eli = {
            home.packages = with pkgs; [ gimp ];
        };
    };
}
