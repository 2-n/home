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

    system.stateVersion = "24.05";

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
        firewall.allowedTCPPorts = [ 4747 7777 39617 57532 ];
        firewall.allowedUDPPorts = [ 4747 7777 39617 57532 ];
    };

    time.timeZone = "America/Chicago";
    time.hardwareClockInLocalTime = true;

    users.users.eli = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
    };

    programs.bash.promptInit = '' PS1='\[\e]0;\w\a\]\[\e[36m\]%\[\e[0m\] ' '';

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

    services.xserver.enable = true;
    services.xserver.displayManager.startx.enable = true;
    services.xserver.windowManager.fvwm3.enable = true;

    programs.thunar = {
        enable = true;
        plugins = with pkgs; [ xarchiver ] ++
                 (with pkgs.xfce; [ thunar-archive-plugin thunar-volman ]);
    };
    services.tumbler.enable = true;
    services.gvfs.enable = true;

    services.libinput.mouse.accelProfile = "flat";
    services.udev.extraRules = ''
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", OWNER="eli"
    ''; # hand over permission of my tablet

    programs.steam.enable = true;
    services.lact.enable = true;
    services.minecraft-servers.enable = false;

    services.tailscale.enable = true;
    services.gonic = {
        enable = true;
        settings = {
            listen-addr = "0.0.0.0:4747";
            scan-at-start-enabled = true;
            scan-watcher-enabled = true;
            music-path = "/mnt/hdd/mus";
            exclude-pattern = "/mnt/hdd/mus/0 - untagged";
            podcast-path = "/mnt/hdd/srv/gonic/podcasts";
            playlists-path = "/mnt/hdd/srv/gonic/playlists";
            multi-value-album-artist = "multi";
            multi-value-artist = "multi";
            multi-value-genre = "multi";
        };
    };

    environment.systemPackages = with pkgs; [
        micro git wget curl
        nixfmt-rfc-style nix-prefetch-scripts
        (writeScriptBin "sudo" ''exec doas "$@"'')
    ];

    fonts.packages = with pkgs; [
        apple-fonts
        dejavu_fonts
        unifont uw-ttyp0
        terminus_font_ttf
    ];
}

