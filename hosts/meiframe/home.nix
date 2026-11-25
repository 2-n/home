{ lib
, config
, inputs
, pkgs
, pkgs-unstable
, ...
}:
let
  link = config.lib.file.mkOutOfStoreSymlink;
  subtui = inputs.subtui.packages.x86_64-linux.default;
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
  };

  gtk.enable = true;

  theme = {
    colors = (import ../../theme/acme-wcolors);
    font.name = "Go Mono";
    font.size = 12;
  };

  cow.enable = true;

  programs = {
    bash.enable = true;
    firefox.enable = true;
    foot.enable = true;
    micro.enable = true;
    tofi.enable = true;
  };

  # this is how I previously had set up Emacs, plus I set up .xresources via home-manager too
  # i then had configured the rest of emacs from within emacs
  #programs.emacs.enable = true;
  #services.emacs = {
  #  enable = true;
  #  client.enable = true;
  #  defaultEditor = true;
  #  socketActivation.enable = true;
  #};

  home.packages = (with pkgs; [
    # tui
    bc
    btop
    ffmpeg
    fzf
    gh
    git
    p7zip
    pfetch
    pstree
    subtui
    tree
    tmux
    wget
    wiremix
    # wayland util
    grim
    slurp
    wl-clipboard-rs
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
    #discord
    lxmenu-data
    picard
    prismlauncher
    spek
    vesktop
  ]) ++ (with pkgs-unstable; [
    discord
    feishin
    osu-lazer-bin
  ]);

  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = [ "org.pwmt.zathura.desktop" ];
        "application/zip" = [ "xarchiver.desktop" ];
        "image/gif" = [ "imv-dir.desktop" ];
        "image/jpeg" = [ "imv-dir.desktop" ];
        "image/png" = [ "imv-dir.desktop" ];
        "inode/directory" = [ "pcmanfm.desktop" ];
        "x-scheme-handler/http" = [ "firefox.desktop" ];
        "x-scheme-handler/https" = [ "firefox.desktop" ];
      };
    };
    userDirs = {
      enable = true;
      setSessionVariables = true;
      desktop = "$HOME/";
      documents = "$HOME/doc";
      download = "$HOME/dwn";
      music = "/mnt/nvme/mus";
      pictures = "$HOME/pix";
      videos = "$HOME/vid";
      publicShare = null;
      templates = null;
    };
  };

  home.stateVersion = "26.05";
}
