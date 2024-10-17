{ lib
, config
, pkgs
, ... 
}:

{	  
    config = lib.mkIf (config.windowManager == "hikari") {
        withWayland = true;
        xdg.configFile."hikari" = {
            source = 
                config.lib.file.mkOutOfStoreSymlink /home/eli/nix/cfg/hikari;
            recursive = true;
        };
        home.packages = with pkgs; [ hikari ];
    };
}
