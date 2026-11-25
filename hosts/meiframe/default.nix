{ lib
, config
, pkgs
, ...
}:

{
  imports = [
    ./hardware.nix
    ../../modules/nixos
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    loader.efi.canTouchEfiVariables = true;
    loader.systemd-boot.enable = true;
    loader.timeout = 0;
    tmp.cleanOnBoot = true;
  };

  time.timeZone = "America/Chicago";
  time.hardwareClockInLocalTime = true;

  networking = {
    hostName = "meiframe";
    networkmanager.enable = true;
  };

  services.tailscale = {
    enable = true;
    extraSetFlags = [ "--accept-dns=false" "--accept-routes" ];
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    extraConfig.pipewire = {
      "99-no-bell"."context.properties"."module.x11.bell" = false;
    };
  };

  security.sudo.enable = false;
  security.doas.enable = true;
  security.doas.extraRules = [{
    groups = [ "wheel" ];
    keepEnv = true;
  }];


  users.users.eli = {
    isNormalUser = true;
    extraGroups = [ "libvirtd" "networkmanager" "wheel" ];
  };

  programs.bash.promptInit = ''
    set_prompt() {
      case $USER in
        root)
          sym="#"
        ;;
        *)
          if [ -z $IN_NIX_SHELL ]; then
            sym="%"
          else
            sym="$"
          fi
        ;;
      esac

      PS1="\[\e[31m\]\w \[\e[32m\]''${sym}\''\[\e[0m\] "
    }

    PROMPT_COMMAND='set_prompt'
  '';

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  services.libinput.mouse.accelProfile = "flat";
  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", OWNER="eli"
    # SUBSYSTEM=="hidraw", ATTRS{idVendor}=="056a", TAG+="uaccess", OWNER="eli"
    # SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTR{idVendor}=="0ac3", ATTR{idProduct}=="ff0f", TAG+="uaccess", OWNER="eli"
  '';

  programs.steam.enable = true;
  services.lact.enable = true;
  services.flatpak.enable = true;
  services.samba.enable = true;
  services.gonic.enable = true;
  services.qbittorrent.enable = true;
  services.minecraft-servers.enable = false;

  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [
    micro
  ];

  fonts.packages = with pkgs; [
    unifont uw-ttyp0
    dejavu_fonts go-font
    noto-fonts noto-fonts-color-emoji
  ];

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  system.stateVersion = "26.05";
}
