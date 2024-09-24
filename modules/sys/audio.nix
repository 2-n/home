{ config, lib, pkgs, ... }:

{
    options = {
        audio = {
            enable = lib.mkEnableOption {
                description = "enable audio";
                default = false;
            };
        };
    };
    
    config = lib.mkIf (config.audio.enable) {
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
