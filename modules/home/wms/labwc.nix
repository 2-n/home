{ lib
, config
, pkgs
, ... 
}:

{	  
    config = lib.mkIf (config.windowManager == "labwc") {
        withWayland = true;
        home.packages = with pkgs; [ labwc ];
    };
}
