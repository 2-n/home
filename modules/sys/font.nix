{ config, lib, pkgs, ... }:

{
    config = lib.mkIf (config.gui.enable) {
        fonts.packages = with pkgs; [
                   spleen
            unifont dejavu_fonts
            uw-ttyp0 inconsolata
        ];
    };
}
