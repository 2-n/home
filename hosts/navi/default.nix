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
        useDHCP = lib.mkDefault true;
        networkmanager.enable = true;
        networkmanager.wifi.powersave = false;
        firewall.enable = true;
        firewall.allowedTCPPorts = [ 4747 7777 39617 57532 ];
        firewall.allowedUDPPorts = [ 4747 7777 39617 57532 ];
    };

    time.timeZone = "America/Chicago";
    time.hardwareClockInLocalTime = true;
    i18n.defaultLocale = "en_US.UTF-8";

    users.defaultUserShell = pkgs.bash;
    users.users.eli = {
        isNormalUser = true;
        useDefaultShell = true;
        extraGroups = [ 
            "wheel" 
            "minecraft" 
        ];
    };

    # probably turn this into a real proper script that symbolizes
    # when i have changed user to root or into a nix-shell etc.
    # bash prompt
    programs.bash.promptInit =
        ''
        PS1="\[\e[36m\]\h\[\e[33m\]%\[\e[0m\] ";
        '';

    security.sudo.enable = false;
    security.doas = {
        enable = true;
        extraRules = [{
            groups = [ "wheel" ];
            keepEnv = true;
        }];
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
    
    services.xserver = {
        enable = true;
        autorun = false;
        enableCtrlAltBackspace = true;
        displayManager.sx.enable = true;
        windowManager.fvwm3.enable = true;
        videoDrivers = [ "amdgpu" ];
        deviceSection = ''Option "TearFree" "true"'';
    };

    programs.thunar = {
        enable = true;
        plugins = with pkgs; [ xarchiver ] ++ 
                 (with pkgs.xfce; [ thunar-archive-plugin thunar-volman ]);
    };
    services.tumbler.enable = true;
    services.gvfs.enable = true;

    hardware.keyboard.qmk.enable = true;
    services.libinput.mouse.accelProfile = "flat";
    services.udev.extraRules = ''
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", OWNER="eli"
    ''; # hand over permission of my tablet

    programs.steam.enable = true;
    services.lact.enable = true;
    services.minecraft-servers.enable = false;

    services.sunshine = {
        enable = true;
        openFirewall = true;
        autoStart = false;
    };

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

    #services.samba = {
    #    enable = true;
    #    settings = {
    #        "share" = {
    #            "path" = "/mnt/hdd/srv/share";
    #            "valid users" = "eli;"
    #            "force user" = "eli";
    #            "public" = "no";
    #            "writeable" = "yes";
    #        };
    #    };
    #};

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

