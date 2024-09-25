{ config, lib, pkgs, ... }:

{
    options = {
        pcmanfm = {
            enable = lib.mkEnableOption {
                description = "enable pcmanfm";
                default = false;
            };
        };
    };

    config = lib.mkIf (config.gui.enable && config.pcmanfm.enable) {
        home-manager.users.eli = {
            home.packages = with pkgs; [ pcmanfm xarchiver lxappearance ];
        };
    };
}
