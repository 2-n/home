{ lib
, config
, pkgs
, pkgs-unstable
, ...
}:
let
  theme = config.theme;
in
{
  options.cow.enable = lib.mkEnableOption "Compositor on Wayland";

  config = lib.mkIf (config.cow.enable) {
    home.packages = [ pkgs.cow-wm ];

    # TODO:
    # kanshi & channel ?

    wayland.windowManager.river = {
      enable = true;
      package = pkgs-unstable.river;
      #systemd.enable = false;
      extraSessionVariables = {
        NIXOS_OZONE_WL = 1;
        MOZ_ENABLE_WAYLAND = 1;
        _JAVA_AWT_WM_NONREPARENTING = 1;
        XDG_CURRENT_DESKTOP = "river";
      };
      extraConfig = ''
        ${pkgs.wl-clip-persist}/bin/wl-clip-persist -c regular &
        foot -s &
        cow -n &
      '';
    };

    gtk = { # remove GTK decor and fix pointer shape issues (from River & CoW wikis)
      gtk3 = {
        extraCss = ''
          headerbar.default-decoration {
            /* tweak values based on GTK theme
            defaults here seem to work for mine (Colloid) */
            margin-bottom: 50px;
            margin-top: -100px;
          }

          window.csd,
          window.csd decoration {
            box-shadow: none;
            margin: 0;
            padding: 0;
            border: none;
            min-width: 0;
            min-height: 0;
          }
        '';
        extraConfig = { gtk-dialogs-use-header = false; };
      };
      gtk4 = {
        extraCss = config.gtk.gtk3.extraCss;
        extraConfig = config.gtk.gtk3.extraConfig;
      };
    };
  };
}
