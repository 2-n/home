{ lib
, config
, pkgs
, ...
}:
let
  custom-colloid-theme = pkgs.colloid-gtk-theme.override {
    themeVariants = [ "purple" ];
    colorVariants = [ "light" ];
    sizeVariants = [ "compact" ];
    tweaks = [ "nord" ];
  };
in
{
  config = lib.mkIf (config.gtk.enable) {
    home.packages = [ pkgs.dconf ];

    home.pointerCursor = {
      enable = true;
      gtk.enable = true;
      package = pkgs.vanilla-dmz;
      name = "DMZ-Black";
      size = 16;
    };

    gtk = {
      font = {
        # SF Compact Display Medium
        name = "Go Regular";
        size = 12;
      };
      iconTheme = {
        package = pkgs.haiku-icon-theme;
        name = "Haiku";
      };
      theme = {
        package = custom-colloid-theme;
        name = "Colloid-Purple-Light-Compact-Nord";
      };
      gtk4.theme = config.gtk.theme;
      gtk3.bookmarks = [
        "file:///home/eli/doc"
        "file:///home/eli/dwn"
        "file:///mnt/nvme/mus"
        "file:///home/eli/pix"
        "file:///home/eli/vid"
        "file:///mnt/nvme/"
        "file:///mnt/nvme/srv/samba"
      ];
    };
  };
}
