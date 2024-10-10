{ lib
, config
, pkgs
, ... 
}:

{	  
    config = lib.mkIf (config.windowManager == "cwm") {
        withX11 = true;
        home.file.".cwmrc".source = 
            config.lib.file.mkOutOfStoreSymlink /home/eli/nix/cfg/cwmrc;
        home.packages = with pkgs; [ cwm ];
    };
}
