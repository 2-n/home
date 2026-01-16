{ lib
, config
, pkgs-unstable
, ...
}:

{
    options = {
        services.lactd = {
            enable = lib.mkEnableOption {
                description = "enable the lact service";
                default = false;
            };
        };
    };

    config = lib.mkIf (config.services.lactd.enable) {
        environment.systemPackages = with pkgs-unstable; [ lact ];
        systemd.services.lactd = {
            enable = true;
            after = [ "multi-user.target" ];
            wantedBy = [ "multi-user.target" ];
            serviceConfig = {
                ExecStart =  "${pkgs-unstable.lact}/bin/lact daemon";
            };
        };
    };
}
