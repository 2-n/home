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

    boot = {
        kernelPackages = pkgs.linuxPackages_xanmod_latest;
        loader.efi.canTouchEfiVariables = true;
        loader.systemd-boot.enable = true;
        tmp.cleanOnBoot = true;
    };

    networking = {
        hostName = "navi";
        networkmanager.enable = true;
        firewall.allowedTCPPorts = [ 7777 39617 ];
        firewall.allowedUDPPorts = [ 7777 39617 ];
    };

    time.timeZone = "America/Chicago";
    time.hardwareClockInLocalTime = true;

    security.sudo.enable = false;
    security.doas.enable = true;
    security.doas.extraRules = [{ 
        groups = [ "wheel" ]; 
        keepEnv = true; 
    }];

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

    programs.bash.promptInit = '' PS1='\[\e]0;\w\a\]\[\e[36m\]%\[\e[0m\] ' '';

    users.users.eli = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
    };

    services.xserver.enable = true;
    services.xserver.displayManager.startx.enable = true;
    services.xserver.windowManager.fvwm3.enable = true;

    services.libinput.mouse.accelProfile = "flat";
    services.udev.extraRules = ''
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", OWNER="eli"
    ''; # drawing tablet perms

    programs.steam.enable = true;
    services.lact.enable = true;
    services.gonic.enable = true;

    environment.systemPackages = with pkgs; [
        curl gh git micro p7zip wget 
    ];

    fonts.packages = with pkgs; [
        apple-fonts
        dejavu_fonts
        unifont uw-ttyp0
    ];

    system.stateVersion = "24.05";
}

