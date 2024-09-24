{ config, lib, pkgs, ... }:

{
    options = {
        gui = {
            enable = lib.mkEnableOption {
                description = "enable graphical environment";
                default = false;
            };
        };
    };

    config = lib.mkIf (config.gui.enable) {
        services.xserver.enable = true;
        services.xserver.displayManager.startx.enable = true;
        services.libinput.mouse.accelProfile = "flat";
    };
}
