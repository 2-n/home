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

    time.timeZone = "America/Chicago";
    time.hardwareClockInLocalTime = true;

    boot = {
        kernelPackages = pkgs.linuxPackages_xanmod_stable;
        loader.efi.canTouchEfiVariables = true;
        loader.systemd-boot.enable = true;
        loader.timeout = 0;
        tmp.cleanOnBoot = true;
    };

    networking = {
        hostName = "meiframe";
        networkmanager.enable = true;
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
        
            PS1="\[\e[32m\]''${sym}\[\e[0m\] "
        }

        PROMPT_COMMAND='set_prompt'
    '';

    users.users.eli = {
        isNormalUser = true;
        extraGroups = [ "networkmanager" "wheel" ];
    };

    security.sudo.enable = false;
    security.doas.enable = true;
    security.doas.extraRules = [{ 
        groups = [ "wheel" ]; 
        keepEnv = true; 
    }];

    services.xserver.enable = true;
    services.xserver.displayManager.startx.enable = true;
    services.xserver.windowManager.cwm.enable = true;
    services.xserver.windowManager.fvwm3.enable = true;

    services.libinput.mouse.accelProfile = "flat";
    services.udev.extraRules = ''
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", OWNER="eli"
    ''; # drawing tablet perms

    programs.steam.enable = true;
    services.lact.enable = true;
    services.gonic.enable = true;
    services.qbittorrent.enable = true;

    environment.systemPackages = with pkgs; [
        git micro p7zip wget 
    ];

    fonts.packages = with pkgs; [
        apple-fonts
        dejavu_fonts
        unifont uw-ttyp0
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

