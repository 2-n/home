{ config, lib, pkgs, ... }:

{	
    xsession.windowManager.command = "exec cwm";

    home.file.".cwmrc".source = ../../dots/cwmrc;

    home.packages = (with pkgs; [
        (cwm.overrideAttrs (oldAttrs: rec {
            patches = [ 
                ./cwm-center.diff
                ./cwm-nomwmhints.diff
            ];
        })) 
    ]);
}
