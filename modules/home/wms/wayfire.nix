{ lib
, config
, pkgs
, ... 
}:

{	  
    config = lib.mkIf (config.windowManager == "wayfire") {
        withWayland = true;
        home.packages = with pkgs; [ 
            wayfire wayfire-plugins-extra wf-shell
        ];
    };
}
