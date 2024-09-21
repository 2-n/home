{ config, lib, pkgs, ... }:

{
    home.packages = (with pkgs; [
        (dmenu.overrideAttrs (oldAttrs: rec {
            src = builtins.fetchTarball {
                url = "https://dl.suckless.org/tools/dmenu-5.2.tar.gz";
                sha256 = "1rxxc3qdb5qvwg284f0hximg9953fnvlymxwmi1zlqkqbs8qbizk";
            };
            patches = [
                ./mega-patch.diff
            ];
        })) 
    ]);
}
