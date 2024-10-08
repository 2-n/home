{ lib
, config
, pkgs
, ... 
}:

{
    config = lib.mkIf (config.windowManager == "windowchef") {
        withX11 = true;
        xdg.configFile."windowchef" = {
            source = 
                config.lib.file.mkOutOfStoreSymlink /home/eli/nix/cfg/windowchef;
            recursive = true;
        };
        home.packages = with pkgs; [ windowchef sxhkd wmutils-core wc-ruler ];
    };
}
