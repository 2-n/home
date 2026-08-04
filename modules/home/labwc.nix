{ lib
, config
, inputs
, ...
}:
let
  theme = config.theme;
in
{
  imports = [ inputs.noctalia.homeModules.default ];

  config = lib.mkIf (config.wayland.windowManager.labwc.enable) {
    programs.noctalia = {
      enable = true;
    };

    wayland.windowManager.labwc = {
      environment = [
        "NIXOS_OZONE_WL=1"
        "MOZ_ENABLE_WAYLAND=1"
        "_JAVA_AWT_WM_NONREPARENTING=1"
      ];

      autostart = [
        "wlr-randr --output DP-2 --mode 2560x1440@200Hz &"
        "noctalia &"
        "foot -s &"
      ];

      rc = {
        theme = {
          name = "theme";
          font = {
            "@name" = "${config.theme.font.name}";
            "@size" = config.theme.font.size;
          };
          cornerRadius = 0;
        };

        core = {
          allowTearing = "yes";
        };

        windowRules = {
          windowRule = [
            {
              "@identifier" = "firefox";
              "@matchOnce" = true;
              action = { "@name" = "SendToDesktop"; "@to" = 1; "@follow" = "no"; };
            }
            {
              "@identifier" = "feishin";
              action = { "@name" = "SendToDesktop"; "@to" = 2; "@follow" = "no"; };
            }
            {
              "@identifier" = "discord";
              action = { "@name" = "SendToDesktop"; "@to" = 3; "@follow" = "no"; };
            }
            {
              "@identifier" = "steam*";
              action = { "@name" = "SendToDesktop"; "@to" = 4; "@follow" = "no"; };
            }
          ];
        };

        focus = {
          followMouse = "yes";
          followMouseRequiresMovement = "yes";
          raiseOnFocus = "no";
        };

        resistance = {
          screenEdgeStrength = 50;
          windowEdgeStrength = 50;
          unSnapThreshold = 50;
        };

        placement = {
          policy = "cursor";
        };

        snapping = {
          overlay = {
            "@enabled" = true;
            delay = {
              "@inner" = 250;
              "@outer" = 250;
            };
          };
        };

        desktops = {
          "@number" = 5;
          "@popupTime" = 0;
        };

        windowSwitcher = {
          "@preview" = "no";
          "@outlines" = "yes";
          osd = {
            "@style" = "thumbnail";
          };
        };

        keyboard = {
          keybind = [
            {
              "@key" = "W-Esc";
              action = { "@name" = "Reconfigure"; };
            }
            {
              "@key" = "W-C-S-Esc";
              action = { "@name" = "Exit"; };
            }
            {
              "@key" = "W-Return";
              action = { "@name" = "Execute"; "@command" = "footclient"; };
            }
            {
              "@key" = "W-d";
              action = { "@name" = "Execute"; "@command" = "noctalia msg panel-toggle launcher"; };
            }
            {
              "@key" = "Print";
              action = { "@name" = "Execute"; "@command" = "noctalia msg screenshot-fullscreen"; };
            }
            {
              "@key" = "W-Print";
              action = { "@name" = "Execute"; "@command" = "noctalia msg screenshot-region"; };
            }
            {
              "@key" = "W-q";
              action = { "@name" = "Iconify"; };
            }
            {
              "@key" = "W-S-q";
              action = { "@name" = "Close"; };
            }
            {
              "@key" = "W-r";
              action = { "@name" = "Raise"; };
            }
            {
              "@key" = "W-S-r";
              action = { "@name" = "Lower"; };
            }
            {
              "@key" = "W-Tab";
              action = { "@name" = "NextWindow"; };
            }
            {
              "@key" = "W-S-Tab";
              action = { "@name" = "PreviousWindow"; };
            }
            {
              "@key" = "W-f";
              action = { "@name" = "ToggleMaximize"; };
            }
            {
              "@key" = "W-S-f";
              action = { "@name" = "ToggleFullscreen"; };
            }
            {
              "@key" = "W-v";
              action = { "@name" = "ToggleMaximize"; "@direction" = "vertical"; };
            }
            {
              "@key" = "W-S-v";
              action = { "@name" = "ToggleMaximize"; "@direction" = "horizontal"; };
            }
            {
              "@key" = "W-g";
              action = { "@name" = "SnapToRegion"; "@region" = "center"; };
            }
            {
              "@key" = "W-y";
              action = [
                { "@name" = "MoveToEdge"; "@direction" = "up"; "@snapWindows" = "no"; }
                { "@name" = "MoveToEdge"; "@direction" = "left"; "@snapWindows" = "no"; }
              ];
            }
            {
              "@key" = "W-u";
              action = [
                { "@name" = "MoveToEdge"; "@direction" = "up"; "@snapWindows" = "no"; }
                { "@name" = "MoveToEdge"; "@direction" = "right"; "@snapWindows" = "no"; }
              ];
            }
            {
              "@key" = "W-b";
              action = [
                { "@name" = "MoveToEdge"; "@direction" = "down"; "@snapWindows" = "no"; }
                { "@name" = "MoveToEdge"; "@direction" = "left"; "@snapWindows" = "no"; }
              ];
            }
            {
              "@key" = "W-n";
              action = [
                { "@name" = "MoveToEdge"; "@direction" = "down"; "@snapWindows" = "no"; }
                { "@name" = "MoveToEdge"; "@direction" = "right"; "@snapWindows" = "no"; }
              ];
            }
            {
              "@key" = "W-h";
              action = { "@name" = "MoveRelative"; "@x" = "-100"; };
            }
            {
              "@key" = "W-j";
              action = { "@name" = "MoveRelative"; "@y" = "100"; };
            }
            {
              "@key" = "W-k";
              action = { "@name" = "MoveRelative"; "@y" = "-100"; };
            }
            {
              "@key" = "W-l";
              action = { "@name" = "MoveRelative"; "@x" = "100"; };
            }
            {
              "@key" = "W-S-h";
              action = { "@name" = "ResizeRelative"; "@right" = "-100"; };
            }
            {
              "@key" = "W-S-j";
              action = { "@name" = "ResizeRelative"; "@bottom" = "100"; };
            }
            {
              "@key" = "W-S-k";
              action = { "@name" = "ResizeRelative"; "@bottom" = "-100"; };
            }
            {
              "@key" = "W-S-l";
              action = { "@name" = "ResizeRelative"; "@right" = "100"; };
            }
            {
              "@key" = "W-1";
              action = { "@name" = "GoToDesktop"; "@to" = "1"; };
            }
            {
              "@key" = "W-2";
              action = { "@name" = "GoToDesktop"; "@to" = "2"; };
            }
            {
              "@key" = "W-3";
              action = { "@name" = "GoToDesktop"; "@to" = "3"; };
            }
            {
              "@key" = "W-4";
              action = { "@name" = "GoToDesktop"; "@to" = "4"; };
            }
            {
              "@key" = "W-5";
              action = { "@name" = "GoToDesktop"; "@to" = "5"; };
            }
            {
              "@key" = "W-S-1";
              action = { "@name" = "SendToDesktop"; "@to" = "1"; "@follow" = "no"; };
            }
            {
              "@key" = "W-S-2";
              action = { "@name" = "SendToDesktop"; "@to" = "2"; "@follow" = "no"; };
            }
            {
              "@key" = "W-S-3";
              action = { "@name" = "SendToDesktop"; "@to" = "3"; "@follow" = "no"; };
            }
            {
              "@key" = "W-S-4";
              action = { "@name" = "SendToDesktop"; "@to" = "4"; "@follow" = "no"; };
            }
            {
              "@key" = "W-S-5";
              action = { "@name" = "SendToDesktop"; "@to" = "5"; "@follow" = "no"; };
            }
          ];
        };

        libinput = {
          device = {
            "@category" = "default";
            accelProfile = "flat";
            pointerSpeed = 0;
          };
        };

        mouse = {
          context = [
            {
              "@name" = "Frame";
              mousebind = [
                {
                  "@button" = "W-Left";
                  "@action" = "Drag";
                  action = [
                    { "@name" = "Raise"; }
                    { "@name" = "Move"; }
                  ];
                }
                {
                  "@button" = "W-Middle";
                  "@action" = "Click";
                  action = { "@name" = "Iconify"; };
                }
                {
                  "@button" = "W-Right";
                  "@action" = "Drag";
                  action = [
                    { "@name" = "Raise"; }
                    { "@name" = "Resize"; }
                  ];
                }
              ];
            }
            {
              "@name" = "Border";
              mousebind = [
                {
                  "@button" = "Left";
                  "@action" = "Drag";
                  action = [
                    { "@name" = "Raise"; }
                    { "@name" = "Resize"; }
                  ];
                }
                {
                  "@button" = "Right";
                  "@action" = "Drag";
                  action = [
                    { "@name" = "Raise"; }
                    { "@name" = "Move"; }
                  ];
                }
              ];
            }
            {
              "@name" = "TitleBar";
              mousebind = [
                {
                  "@button" = "Left";
                  "@action" = "Drag";
                  action = [
                    { "@name" = "Raise"; }
                    { "@name" = "Move"; }
                  ];
                }
                {
                  "@button" = "Left";
                  "@action" = "DoubleClick";
                  action = { "@name" = "ToggleMaximize"; };
                }
              ];
            }
            {
              "@name" = "Iconify";
              mousebind = [
                {
                  "@button" = "Left";
                  "@action" = "Click";
                  action = { "@name" = "Lower"; };
                }
                {
                  "@button" = "Middle";
                  "@action" = "Click";
                  action = { "@name" = "Iconify"; };
                }
              ];
            }
            {
              "@name" = "Maximize";
              mousebind = [
                {
                  "@button" = "Left";
                  "@action" = "Click";
                  action = { "@name" = "ToggleMaximize"; };
                }
                {
                  "@button" = "Middle";
                  "@action" = "Click";
                  action = { "@name" = "ToggleMaximize"; "@direction" = "vertical"; };
                }
              ];
            }
            {
              "@name" = "Close";
              mousebind = [
                {
                  "@button" = "Left";
                  "@action" = "Click";
                  action = { "@name" = "Close"; };
                }
              ];
            }
          ];
        };
      };
    };
  };
}
