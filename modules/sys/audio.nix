{ config, lib, pkgs, ... }:

{
    config = lib.mkIf (config.gui.enable) {
        sound.enable = true;
        security.rtkit.enable = true;
        services.pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
            extraConfig.pipewire = {
                "99-no-bell.conf" = {
                    "context.properties" = {
                        "module.x11.bell" = false;
                    };
                };
            };
        };
    };
}
