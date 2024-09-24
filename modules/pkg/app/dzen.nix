{ config, lib, pkgs, ... }:

{
    options = {
        dzen = {
            enable = lib.mkEnableOption {
                description = "enable dzen";
                default = false;
            };
        };
    };

    config = lib.mkIf (config.gui.enable && config.dzen.enable) {
        home-manager.users.eli = {
            home.packages = with pkgs; [ dzen2 ];
        };
    };
}
