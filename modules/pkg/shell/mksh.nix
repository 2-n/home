{ config, lib, pkgs, ... }:
   
{
    config = {
        users.users.eli.shell = pkgs.mksh;
        home-manager.users.eli = { config, pkgs, ... }: {
            home.file.".mkshrc" = {
                source = config.lib.file.mkOutOfStoreSymlink /home/eli/nix/cfg/mkshrc;
            };
            home.file."bin" = {
                source = config.lib.file.mkOutOfStoreSymlink /home/eli/nix/bin;
                recursive = true;
            };
        };
    };
}
