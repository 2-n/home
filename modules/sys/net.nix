{ config, lib, pkgs, ... }:

{
    options = {
        networking = {
            enable = lib.mkEnableOption {
                description = "enable networking";
                default = false;
            };
        };
    };

    config = lib.mkIf (config.networking.enable) {
        networking.networkmanager.enable = true;
        networking.useDHCP = lib.mkDefault true;
    };
}
