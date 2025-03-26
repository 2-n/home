{ lib
, config
, pkgs
, ...
}:
   
{
    config = lib.mkIf (config.programs.rofi.enable) {
        programs.rofi = {
            font = "${config.theme.font.name} ${toString (config.theme.font.size + 1.0)}";
            extraConfig = {
                modes = "combi";
                disable-history = true;
                combi-modes = "window,run";
                combi-hide-mode-prefix = true;
                display-combi = "";
            };
        };
    };
}
