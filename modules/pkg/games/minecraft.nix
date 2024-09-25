{ config, lib, pkgs, ... }:

{
    options = {
        gaming.minecraft = {
            enable = lib.mkEnableOption {
                description = "enable minecraft";
                default = false;
            };
        };
    };

    config = lib.mkIf (config.gaming.minecraft.enable) {
        home-manager.users.eli = {
            home.packages = with pkgs; [ prismlauncher ];
        };
    };
}
