{ lib
, config
, pkgs
, ... 
}:

{	  
    config = lib.mkIf (config.windowManager == "labwc") {
        withWayland = true;
        xdg.configFile."labwc" = {
            source = 
                config.lib.file.mkOutOfStoreSymlink /home/eli/nix/cfg/labwc;
            recursive = true;
        };
        home.packages = with pkgs; [ labwc ];
    };
}
