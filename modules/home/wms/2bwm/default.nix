{ lib
, config
, pkgs
, ... 
}:

{
    config = lib.mkIf (config.windowManager == "2bwm") {
        withX11 = true;
        home.packages = with pkgs; [
            (_2bwm.overrideAttrs (old: rec {
                # transfer most of this to overlays and add variable
                # to pass config.h so I only need to use 2bwm.override
                configFile = writeText "config.h" (builtins.readFile ./config.h);
                postPatch = "cp ${configFile} config.h";
            })) 
        ];            
    };
}
