{ lib
, config
,  ... 
}:

{
    config = lib.mkIf (config.programs.foot.enable) {
        programs.foot = {
            settings = {
                main = {
                    font = "${config.theme.font.name}:style=regular:size=${toString config.theme.font.size}";
                    font-bold = "${config.theme.font.name}:style=regular:size=${toString config.theme.font.size}";
                    font-italic = "${config.theme.font.name}:style=regular:size=${toString config.theme.font.size}";
                    font-bold-italic = "${config.theme.font.name}:style=regular:size=${toString config.theme.font.size}";
                    font-size-adjustment = 0.5;
                    resize-by-cells = "no";
                    pad = "${toString config.theme.font.size}x${toString config.theme.font.size}";
                    initial-window-size-pixels = "900x700";
                    #initial-window-size-chars = "75x30";
                };
                cursor = {
                    style = "Underline";
                    color = "${config.theme.colors.termfg} ${config.theme.colors.cursor}";
                };
                colors = {
                    alpha = 1.0;
                    background = config.theme.colors.termbg;
                    foreground = config.theme.colors.termfg; 

                    regular0   = config.theme.colors.base00;
                    regular1   = config.theme.colors.base01;
                    regular2   = config.theme.colors.base02;
                    regular3   = config.theme.colors.base03;
                    regular4   = config.theme.colors.base04;
                    regular5   = config.theme.colors.base05;
                    regular6   = config.theme.colors.base06;
                    regular7   = config.theme.colors.base07;

                    bright0    = config.theme.colors.base08;
                    bright1    = config.theme.colors.base09;
                    bright2    = config.theme.colors.base10;
                    bright3    = config.theme.colors.base11;
                    bright4    = config.theme.colors.base12;
                    bright5    = config.theme.colors.base13;
                    bright6    = config.theme.colors.base14;
                    bright7    = config.theme.colors.base15;
                };
            };
        };            
    };
}
