{ config, lib, pkgs,  ... }:

{
    options = {
        alacritty = {
            enable = lib.mkEnableOption {
                description = "enable alacritty";
                default = false;
            };
        };
    };

    config = lib.mkIf (config.gui.enable && config.alacritty.enable) {
        home-manager.users.eli = {
            programs.alacritty = {
                enable = true;
                settings = {
                    font = {
                        size = 16.0;
                        normal = { 
                            family = "spleen";
                            style = "Regular";
                        };
                        bold = { 
                            family = "spleen";
                            style = "Regular";
                        };
                        italic = { 
                            family = "spleen";
                            style = "Regular";
                        };
                        bold_italic = { 
                            family = "spleen";
                            style = "Regular";
                        };
                    };
                    window = {
                        resize_increments = true;
                        padding = {
                            x = 20;
                            y = 20;  
                        };
                        dimensions = { 
                            columns = 85;
                            lines = 35;
                        };
                    };
                    cursor = {
                        style = "Underline";
                    };
                    colors = {
                        primary = {
                            background = config.theme.base00;
                            foreground = config.theme.base15;
                        };
                        cursor = {
                            text       = config.theme.base15;
                            cursor     = config.theme.base03;
                        };
                        normal = {
                            black      = config.theme.base00;
                            red        = config.theme.base01;
                            green      = config.theme.base02;
                            yellow     = config.theme.base03;
                            blue       = config.theme.base04;
                            magenta    = config.theme.base05;
                            cyan       = config.theme.base06;
                            white      = config.theme.base07;
                        };
                        bright = {
                            black      = config.theme.base08;
                            red        = config.theme.base09;
                            green      = config.theme.base10;
                            yellow     = config.theme.base11;
                            blue       = config.theme.base12;
                            magenta    = config.theme.base13;
                            cyan       = config.theme.base14;
                            white      = config.theme.base15;
                        };
                    };
                };
            };            
        };  
    };
}
