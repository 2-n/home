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
    ".tmux.conf".source = link /home/eli/nix/cfg/tmux.conf;
    # keep here just incase wayland doesnt work out.
    # ".cwmrc".source = link /home/eli/nix/cfg/cwmrc;
    # ".fvwm" = {
    #   source = link /home/eli/nix/cfg/fvwm;
    #   recursive = true;
    # };
    # ".xinitrc".source = link /home/eli/nix/cfg/xinitrc;
  };

  gtk.enable = true;

  theme = {
    colors = (import ../../theme/acme-wcolors);
    font.name = "Go Mono";
    font.size = 12;
  };

  wayland.windowManager.labwc.enable = true;

  programs = {
    alacritty.enable = false;
    bash.enable = true;
    firefox.enable = true;
    foot.enable = true;
    micro.enable = true;
  };

  home.packages = (with pkgs; [
    # tui
    bc
    btop
    fzf
    gh
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
    stalonetray
    xclip
    xdotool
    # wayland
    wl-clipboard-rs
    wlr-randr
    # applications
    freecad
    gimp
    imv
    keepassxc
    kicad
    libreoffice
    mpv
    pcmanfm
    xarchiver
    zathura
    # etc
    discord
    lxmenu-data
    picard
    prismlauncher
    spek
    vesktop
  ]) ++ (with pkgs-unstable; [
    feishin
    osu-lazer-bin
  ]);

  xdg.userDirs = {
    enable = true;
    setSessionVariables = true;
    desktop = "$HOME/";
    documents = "$HOME/doc";
    download = "$HOME/dwn";
    music = "/mnt/hdd/mus";
    pictures = "$HOME/pix";
    videos = "$HOME/vid";
    publicShare = null;
    templates = null;
  };

  home.stateVersion = "26.05";
}
