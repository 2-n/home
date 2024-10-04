{ config, lib, pkgs, ... }:

{
    options = {
        dmenu = {
            enable = lib.mkEnableOption {
                description = "enable dmenu";
                default = false;
            };
        };
    };

    config = lib.mkIf (config.dmenu.enable) {
        home.packages = with pkgs; [
            (dmenu.overrideAttrs (oldAttrs: rec {
                src = builtins.fetchTarball {
                    url = "https://dl.suckless.org/tools/dmenu-5.2.tar.gz";
                    sha256 = "1rxxc3qdb5qvwg284f0hximg9953fnvlymxwmi1zlqkqbs8qbizk";
                };
                patches = [
                    ./mega-patch.diff
                ];
            })) 
        ];
    };
}
