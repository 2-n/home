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
    kernelPackages = pkgs.linuxPackages_latest;
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
    firewall.allowedTCPPorts = [ 25565 28000 28001 28002 ];
    firewall.allowedUDPPorts = [ 25565 28000 28001 28002 ];
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
    extraGroups = [ "networkmanager" "wheel" ];
  };

  programs.bash.promptInit = ''
    set_prompt() {
      case $USER in
        eli)
          if [ -z $IN_NIX_SHELL ]; then
            sym="%"
          else
            sym="$"
          fi
          ;;
        root)
          sym="#"
          ;;
      esac

      PS1="\[\e[31m\]\w \[\e[32m\]''${sym}\''\[\e[0m\] "
    }

    PROMPT_COMMAND='set_prompt'
  '';

  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
    windowManager.cwm.enable = true;
    windowManager.fvwm3.enable = true;
  };

  services.libinput.mouse.accelProfile = "flat";
  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", OWNER="eli"
  '';

  programs.steam.enable = true;
  services.lact.enable = true;
  services.gonic.enable = true;
  services.qbittorrent.enable = true;

  #services.flatpak.enable = true;
  #xdg.portal.enable = true;
  #xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  fonts.packages = with pkgs; [
    unifont uw-ttyp0
    apple-fonts dejavu_fonts go-font
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

  system.stateVersion = "25.11";
}

