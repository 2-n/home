{ config, lib, pkgs, ... }:

{	  
    config = lib.mkIf (config.wm == "cwm") {
        home.file.".cwmrc".source = 
            config.lib.file.mkOutOfStoreSymlink /home/eli/nix/cfg/cwmrc;
        
        home.packages = with pkgs; [
            (cwm.overrideAttrs (oldAttrs: rec {
                patches = [ 
                    ./cwm-center.diff
                    ./cwm-nomwmhints.diff
                ];
            })) 
        ];
    };
}
