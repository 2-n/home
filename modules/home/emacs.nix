{ lib
, config
,  ... 
}:

{
    config = lib.mkIf (config.programs.emacs.enable) {
        services.emacs = {
            enable = true;
            client.enable = true;
            defaultEditor = true;
            socketActivation.enable = true;
        };

        # provide theme with colors
        # https://github.com/martenlienen/xresources-theme
        xresources.properties = {
            # special
            "emacs*background" = "#${config.theme.colors.termbg}";
            "emacs*foreground" = "#${config.theme.colors.termfg}";

            # black
            "emacs*color0" =  "#${config.theme.colors.base00}";
            "emacs*color8" =  "#${config.theme.colors.base08}";

            # red
            "emacs*color1" =  "#${config.theme.colors.base01}";
            "emacs*color9" =  "#${config.theme.colors.base09}";

            # green
            "emacs*color2" =  "#${config.theme.colors.base02}";
            "emacs*color10" = "#${config.theme.colors.base10}";

            # yellow
            "emacs*color3" =  "#${config.theme.colors.base03}";
            "emacs*color11" = "#${config.theme.colors.base11}";

            # blue
            "emacs*color4" =  "#${config.theme.colors.base04}";
            "emacs*color12" = "#${config.theme.colors.base12}";

            # magenta
            "emacs*color5" =  "#${config.theme.colors.base05}";
            "emacs*color13" = "#${config.theme.colors.base13}";

            # cyan
            "emacs*color6" =  "#${config.theme.colors.base06}";
            "emacs*color14" = "#${config.theme.colors.base14}";

            # white
            "emacs*color7" =  "#${config.theme.colors.base07}";
            "emacs*color15" = "#${config.theme.colors.base15}";
        };          
    };
}
