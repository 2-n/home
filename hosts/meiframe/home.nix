{ lib
, config
, pkgs
, pkgs-unstable
, ...
}:
let
  link = config.lib.file.mkOutOfStoreSymlink;
in
{
  imports = [ ../../modules/home ];

  home.username = "eli";
  home.homeDirectory = "/home/eli";

  home.file = {
    "bin"   = {
      source = link /home/eli/nix/bin;
      recursive = true;
    };
    ".cwmrc".source = link /home/eli/nix/cfg/cwmrc;
    ".fvwm" = {
      source = link /home/eli/nix/cfg/fvwm;
      recursive = true;
    };
    ".tmux.conf".source = link /home/eli/nix/cfg/tmux.conf;
    ".xinitrc".source = link /home/eli/nix/cfg/xinitrc;
  };

  gtk.enable = true;

  theme = {
    colors = (import ../../theme/acme-wcolors);
    font.name = "Go Mono";
    font.size = 12;
  };

  programs = {
    alacritty.enable = true;
    bash.enable = true;
    firefox.enable = true;
    micro.enable = true;
  };

  home.packages = (with pkgs; [
    # tui
    bc
    btop
    fzf
    git
    p7zip
    pfetch
    pstree
    tree
    tmux
    wget
    wiremix
    # x11
    dmenu
    hsetroot
    scrot
    xclip
    xdotool
    # applications
    gimp
    imv
    keepassxc
    libreoffice
    mpv
    pcmanfm
    xarchiver
    zathura
    # etc
    discord
    jellyfin-desktop
    picard
    prismlauncher
    spek
  ]) ++ (with pkgs-unstable; [
    feishin
    osu-lazer-bin
  ]);

  xdg.userDirs = {
    enable = true;
    desktop = "$HOME/";
    documents = "$HOME/doc";
    download = "$HOME/dwn";
    music = "/mnt/hdd/mus";
    pictures = "$HOME/pix";
    videos = "$HOME/vid";
    publicShare = null;
    templates = null;
  };

  home.stateVersion = "25.11";
}
