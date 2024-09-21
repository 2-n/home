{ config, lib, pkgs, theme,  ... }:

with theme;
{
    programs.alacritty = {
        enable = true;
        settings = {
            font = {
                size = 12.0;
                normal = { 
                    family = "DejaVu Sans Mono";
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
                    columns = 75;
                    lines = 25;
                };
            };
            cursor = {
                style = "Underline";
            };
            colors = {
                primary = {
                    background = basebg;
                    foreground = basefg;
                };
                cursor = {
                    text       = basefg;
                    cursor     = base03;
                };
                normal = {
                    black      = base00;
                    red        = base01;
                    green      = base02;
                    yellow     = base03;
                    blue       = base04;
                    magenta    = base05;
                    cyan       = base06;
                    white      = base07;
                };
                bright = {
                    black      = base08;
                    red        = base09;
                    green      = base10;
                    yellow     = base11;
                    blue       = base12;
                    magenta    = base13;
                    cyan       = base14;
                    white      = base15;
                };
            };
        };
    };
}
