{ config, lib, pkgs, ... }:

{
    options = {
        gaming.lact = {
            enable = lib.mkEnableOption {
                description = "enable lact";
                default = false;
            };
        };
    };

    config = lib.mkIf (config.gaming.lact.enable) {
        environment.systemPackages = with pkgs; [ lact ];
        boot.kernelParams = [ "amdgpu.ppfeaturemask=0xffffffff" ];

        systemd.services.lact = {
            enable = true;
            description = "amdgpu control daemon";
            after = [ "multi-user.target" ];
            wantedBy = [ "multi-user.target" ];
            serviceConfig = {
                ExecStart =  "${pkgs.lact}/bin/lact daemon";
            };
        };

        environment.etc."lact/config.yaml".source = ../../../cfg/lact/config.yaml;
    };
}
