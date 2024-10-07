{ lib
, config
, pkgs
,  ... 
}:

{
    config = lib.mkIf (config.programs.alacritty.enable) {
        programs.alacritty = {
            settings = {
                font = {
                    size = config.theme.font.size + 0.0;
                    normal = { 
                        family = config.theme.font.name;
                        style = "Regular";
                    };
                    bold = { 
                        family = config.theme.font.name;
                        style = "Regular";
                    };
                    italic = { 
                        family = config.theme.font.name;
                        style = "Regular";
                    };
                    bold_italic = { 
                        family = config.theme.font.name;
                        style = "Regular";
                    };
                };
                window = {
                    resize_increments = true;
                    padding = {
                        x = 0;
                        y = 0;  
                    };
                    dimensions = { 
                        columns = 85;
                        lines = 40;
                    };
                };
                cursor = {
                    style = "Underline";
                };
                colors = {
                    primary = {
                        background = config.theme.colors.termbg;
                        foreground = config.theme.colors.termfg;
                    };
                    cursor = {
                        cursor     = config.theme.colors.cursor;
                    };
                    normal = {
                        black      = config.theme.colors.base00;
                        red        = config.theme.colors.base01;
                        green      = config.theme.colors.base02;
                        yellow     = config.theme.colors.base03;
                        blue       = config.theme.colors.base04;
                        magenta    = config.theme.colors.base05;
                        cyan       = config.theme.colors.base06;
                        white      = config.theme.colors.base07;
                    };
                    bright = {
                        black      = config.theme.colors.base08;
                        red        = config.theme.colors.base09;
                        green      = config.theme.colors.base10;
                        yellow     = config.theme.colors.base11;
                        blue       = config.theme.colors.base12;
                        magenta    = config.theme.colors.base13;
                        cyan       = config.theme.colors.base14;
                        white      = config.theme.colors.base15;
                    };
                };
            };
        };            
    };
}
