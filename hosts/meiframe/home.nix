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
    ".xinitrc".source = link /home/eli/nix/cfg/xinitrc;
  };

  gtk.enable = true;

  theme = {
    colors = (import ../../theme/acme-wcolors);
    font.name = "SFMono";
    font.size = 12;
  };

  programs = {
    alacritty.enable = true;
    bash.enable = true;
    firefox.enable = true;
    micro.enable = true;
  };

  home.packages = (with pkgs; [
    btop pstree tree
    fzf pfetch tmux

    #plan9port

    dmenu scrot xclip
    hsetroot xdotool

    pcmanfm xarchiver lxmenu-data

    gimp imv mpv
    keepassxc discord
    picard spek
    prismlauncher
  ]) ++ (with pkgs-unstable; [
    feishin osu-lazer-bin
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
