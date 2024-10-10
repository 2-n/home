{ lib
, config
, pkgs-unstable
, ...
}:

{
    options = {
        services.lact = {
            enable = lib.mkEnableOption {
                description = "enable the lact service";
                default = false;
            };
        };
    };

    config = lib.mkIf (config.services.lact.enable) {
        environment.systemPackages = with pkgs-unstable; [ lact ];
        systemd.services.lact = {
            enable = true;
            description = "amdgpu control daemon";
            after = [ "multi-user.target" ];
            wantedBy = [ "multi-user.target" ];
            serviceConfig = {
                ExecStart =  "${pkgs-unstable.lact}/bin/lact daemon";
            };
        };
    };
}
