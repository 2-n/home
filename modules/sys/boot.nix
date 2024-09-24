{ config, lib, pkgs, ... }:

{
    config = {
        boot.loader.systemd-boot.enable = true;
        boot.loader.efi.canTouchEfiVariables = true;
        boot.tmp.cleanOnBoot = true;
    };
}
