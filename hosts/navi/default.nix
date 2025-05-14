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
        kernelPackages = pkgs.linuxPackages_cachyos;
        loader.systemd-boot.enable = true;
        loader.efi.canTouchEfiVariables = true;
        tmp.cleanOnBoot = true;
    };

    networking = {
        hostName = "navi";
        useDHCP = lib.mkDefault true;
        networkmanager.enable = true;
    };

    time.timeZone = "America/Chicago";
    i18n.defaultLocale = "en_US.UTF-8";

    users.users.eli = {
        isNormalUser = true;
        extraGroups = [ "wheel" "minecraft" ];
        shell = pkgs.mksh;
    };

    # doas
    security.sudo.enable = false;
    security.doas = {
        enable = true;
        extraRules = [{
            groups = [ "wheel" ];
            keepEnv = true;
        }];
    };

    # audio
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        extraConfig.pipewire = {
            "99-no-bell" = {
                "context.properties" = {
                    "module.x11.bell" = false;
                };
            };
        };
    };

    # x
    services.xserver = {
        enable = true;
        autorun = false;
        displayManager.startx.enable = true;
        videoDrivers = [ "amdgpu" ];
        deviceSection = ''Option "TearFree" "true"'';
    };

    # inputs
    hardware.keyboard.qmk.enable = true;
    services.libinput.mouse.accelProfile = "flat";
    services.udev.extraRules = ''
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", OWNER="eli"
        ATTRS{idVendor}=="16d0", ATTRS{idProduct}=="12f7", RUN+="/sbin/modprobe xpad" RUN+="/bin/sh -c 'echo 16d0 12f7 > /sys/bus/usb/drivers/xpad/new_id'"
    '';

    services.lact.enable = true;
    programs.steam.enable = true;
    services.minecraft-servers.enable = true;
    
    environment.systemPackages = with pkgs; [
        micro git wget curl nix-prefetch-scripts
        (writeScriptBin "sudo" ''exec doas "$@"'')
    ];

    fonts.packages = with pkgs; [
        terminus_font
        terminus_font_ttf
        apple-fonts-nerd
        unifont dejavu_fonts
        uw-ttyp0 inconsolata
    ];

    nix.settings.auto-optimise-store = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    system.stateVersion = "24.05";
}

