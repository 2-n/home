final: prev: {
  apple-fonts = prev.callPackage ./pkgs/apple-fonts.nix {};
  haiku-icon-theme = prev.callPackage ./pkgs/haiku-icon-theme.nix {};
  hikari = prev.callPackage ./pkgs/hikari.nix {};
  stmps = prev.callPackage ./pkgs/stmps.nix {};

  colloid-gtk-theme = prev.colloid-gtk-theme.overrideAttrs (old: rec {
    patches = [ ./patches/colloid-gtk-theme-no-radius.diff ];
  });

  cwm = prev.cwm.overrideAttrs (old: rec {
    patches = [
      ./patches/cwm-center.diff
      ./patches/cwm-nomwmhints.diff
      ./patches/cwm-smooth.diff
    ];
  });

  dmenu = prev.dmenu.overrideAttrs (old: rec {
    patches = [ ./patches/dmenu-patch.diff ];
  });

  plan9port = prev.plan9port.overrideAttrs (old: rec {
    patches = [ ./patches/plan9port-acme-keybinds.diff ];
  });
}
