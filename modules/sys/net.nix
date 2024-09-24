{ config, lib, pkgs, ... }:

{
    options = {
        net = {
            enable = lib.mkEnableOption {
                description = "enable networking";
                default = false;
            };
        };
    };

    config = lib.mkIf (config.net.enable) {
        networking.networkmanager.enable = true;
        networking.useDHCP = lib.mkDefault true;
    };
}
