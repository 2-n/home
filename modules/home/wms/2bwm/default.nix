{ lib
, config
, pkgs
, ... 
}:

{
    config = lib.mkIf (config.windowManager == "2bwm") {
        withX11 = true;
        home.packages = with pkgs; [
            (_2bwm.overrideAttrs (oldAttrs: rec {
                configFile = writeText "config.h" (builtins.readFile ./config.h);
                postPatch = "cp ${configFile} config.h";
            })) 
        ];            
    };
}
