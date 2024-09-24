{ config, lib, pkgs, ... }:

{
    imports = [
        ./lact.nix
        ./lutris.nix
        ./minecraft.nix
        ./openrct2.nix
        ./osu.nix
        ./protonup.nix
        ./steam.nix
    ];

    options = {
        gaming = {
            enable = lib.mkEnableOption {
                description = "enable gaming things";
                default = false;
            };
        };
    };

    config = lib.mkIf (config.gaming.enable) {
        hardware.opengl = {
            enable = true;
            driSupport = true;
            driSupport32Bit = true;
        };
        programs.gamemode.enable = true;
    };
}
