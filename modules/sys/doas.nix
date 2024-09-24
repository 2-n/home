{ config, lib, pkgs, ... }:

{
    config = {
        security = {
            sudo.enable = false;

            doas = {
                enable = true;
                extraRules = [{
                    groups = [ "wheel" ];
                    keepEnv = true;
                }];
            };
        };
       
        environment.systemPackages = [
            (pkgs.writeScriptBin "sudo" ''exec doas "$@"'')
        ];
    };
}
