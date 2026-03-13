{ lib
, config
,  ...
}:
let
  theme = config.theme;
in
{
  config = lib.mkIf (config.programs.alacritty.enable) {
    programs.alacritty = {
      settings = {
        font = {
          size = theme.font.size + 0.0;
          normal = {
            family = theme.font.name;
            style = "Regular";
          };
          bold = {
            family = theme.font.name;
            style = "Regular";
          };
          italic = {
            family = theme.font.name;
            style = "Regular";
          };
          bold_italic = {
            family = theme.font.name;
            style = "Regular";
          };
        };
        window = {
          resize_increments = true;
          dimensions.columns = 81;
          dimensions.lines = 30;
          padding.x = 0;
          padding.y = 0;
        };
        cursor.style = {
          shape = "Beam";
          blinking = "Never";
        };
        colors = {
          primary = {
            background = "#${theme.colors.termbg}";
            foreground = "#${theme.colors.termfg}";
          };
          selection = {
            text       = "#${theme.colors.selefg}";
            background = "#${theme.colors.selebg}";
          };
          cursor = {
            cursor     = "#${theme.colors.cursor}";
          };
          normal = {
            black      = "#${theme.colors.base00}";
            red        = "#${theme.colors.base01}";
            green      = "#${theme.colors.base02}";
            yellow     = "#${theme.colors.base03}";
            blue       = "#${theme.colors.base04}";
            magenta    = "#${theme.colors.base05}";
            cyan       = "#${theme.colors.base06}";
            white      = "#${theme.colors.base07}";
          };
          bright = {
            black      = "#${theme.colors.base08}";
            red        = "#${theme.colors.base09}";
            green      = "#${theme.colors.base10}";
            yellow     = "#${theme.colors.base11}";
            blue       = "#${theme.colors.base12}";
            magenta    = "#${theme.colors.base13}";
            cyan       = "#${theme.colors.base14}";
            white      = "#${theme.colors.base15}";
          };
        };
        keyboard.bindings = [
          {
            key = "Tab";
            mods = "Control";
            chars = "\\u001b[27;5;9~";
          }
          {
            key = "Tab";
            mods = "Control|Shift";
            chars = "\\u001b[27;6;9~";
          }
        ];
      };
    };
  };
}
