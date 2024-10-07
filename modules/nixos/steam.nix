{ lib
, config
, ...
}:

{
    config = lib.mkIf (config.programs.steam.enable) {
        programs.gamemode.enable = true;
        programs.gamescope.enable = true;
        programs.steam.dedicatedServer.openFirewall = true;
    };
}
