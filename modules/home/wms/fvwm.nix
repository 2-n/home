{ lib
, config
, pkgs
, ... 
}:

{	  
    config = lib.mkIf (config.windowManager == "fvwm") {
        withX11 = true;
        home.packages = with pkgs; [ fvwm3 ];
    };
}
