{ config, lib, pkgs, ... }:
   
{
    options = {
        xutils = {
            enable = lib.mkEnableOption {
                description = "enable x utilities";
                default = false;
            };
        };
    };

    config = lib.mkIf (config.gui.enable && config.xutils.enable) {
        home-manager.users.eli = {
            home.packages = with pkgs; [ xclip maim xdotool xorg.xwininfo ];
        };
    };
}
