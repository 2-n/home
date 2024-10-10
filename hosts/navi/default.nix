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
        loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
        };
        tmp.cleanOnBoot = true;
        kernelPackages = pkgs.linuxPackages_latest;
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
        extraGroups = [ "wheel" ];
        shell = pkgs.mksh;
    };

    security = {
        sudo.enable = false;
        doas = {
            enable = true;
            extraRules = [{
                groups = [ "wheel" ];
                keepEnv = true;
            }];
        };
        rtkit.enable = true;
    };

    sound.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        extraConfig.pipewire = {
            "99-no-bell.conf" = {
                "context.properties" = {
                    "module.x11.bell" = false;
                };
            };
        };
    };

    services = {
        xserver = {
            enable = true;
            autorun = false;
            displayManager.startx.enable = true;
            videoDrivers = [ "amdgpu" ];
            deviceSection = ''Option "TearFree" "true"'';
        };
        libinput.mouse.accelProfile = "flat";
        udev.extraRules = ''
            KERNEL=="hidraw*", SUBSYSTEM=="hidraw", OWNER="eli"
        '';
    };

    environment.etc."issue".text = '''';

    services.lact.enable = true;
    programs.steam.enable = true;

    environment.systemPackages = with pkgs; [
        micro git wget curl nix-prefetch-scripts
        (writeScriptBin "sudo" ''exec doas "$@"'')
    ];

    fonts.packages = with pkgs; [
        terminus_font
        apple-fonts-nerd
        unifont dejavu_fonts
        uw-ttyp0 inconsolata
    ];

    nix.settings.auto-optimise-store = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    system.stateVersion = "24.05";
}

