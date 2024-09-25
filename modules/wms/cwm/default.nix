{ config, lib, pkgs, ... }:

{	  
    config = lib.mkIf (config.gui.enable && config.wm == "cwm") {
        home-manager.users.eli = { config, pkgs, ... }: {
            home.file.".cwmrc".source = config.lib.file.mkOutOfStoreSymlink /home/eli/nix/cfg/cwmrc;
            home.packages = with pkgs; [
                (cwm.overrideAttrs (oldAttrs: rec {
                    patches = [ 
                        ./cwm-center.diff
                        ./cwm-nomwmhints.diff
                    ];
                })) 
            ];
        };
    };
}
