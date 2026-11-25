{ lib
, config
, ...
}:
let
  theme = config.theme;
in
{
  config = lib.mkIf (config.programs.tofi.enable) {
    programs.tofi.settings = {
      font = "${config.theme.font.name}";
      font-size = config.theme.font.size;

      anchor = "bottom";
      horizontal = true;
      width = "100%";
      height = "32";

      text-color = "#ffffff";
      background-color = "#000000";
      selection-color = "#000000";
      selection-background = "#ffffff";

      prompt-text = "\"\"";
      prompt-padding = 0;
      text-cursor = true;

      outline-width = 0;
      border-width = 0;

      padding-right = 4;
      padding-left = 4;
      padding-bottom = 0;
      padding-top = 0;

      min-input-width = 120;
      result-spacing = 16;
      selection-background-padding = 4;

      require-match = false;
      history = false;
    };
  };
}
