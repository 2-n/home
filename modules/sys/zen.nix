{ config, lib, pkgs, ... }:

{
    options = {
        zen.kernel = {
            enable = lib.mkEnableOption {
                description = "enable zen kernel";
                default = false;
            };
        };
    };

    config = lib.mkIf (config.zen.kernel.enable){
        boot.kernelPackages = pkgs.linuxPackages_zen;
    };
}
