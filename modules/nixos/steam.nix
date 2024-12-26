{ lib
, config
, pkgs
, ...
}:

{
    config = lib.mkIf (config.programs.steam.enable) {
        environment.systemPackages = with pkgs; [
            pkgsi686Linux.gperftools
        ]; 
            
        environment.shellInit = let
            gperfPkg = builtins.toString pkgs.pkgsi686Linux.gperftools;
        in ''
            export GPERF32_PATH="${gperfPkg}"
        ''; # used to fix CS:S gamemoderun LD_PRELOAD=$GPERF32_PATH/lib/libtcmalloc.so %command%
        
        programs.gamemode.enable = true;
        programs.gamescope.enable = true;
        programs.steam.dedicatedServer.openFirewall = true;
    };
}
