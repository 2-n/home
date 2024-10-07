{ lib
, config
, pkgs
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
        environment.systemPackages = with pkgs; [ lact ];
        systemd.services.lact = {
            enable = true;
            description = "amdgpu control daemon";
            after = [ "multi-user.target" ];
            wantedBy = [ "multi-user.target" ];
            serviceConfig = {
                ExecStart =  "${pkgs.lact}/bin/lact daemon";
            };
        };
    };
}
