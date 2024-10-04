{ inputs, config, lib, pkgs, pkgs-unstable, ... }:

{ 
    imports = 
        [ ./hardware.nix inputs.home-manager.nixosModules.home-manager ];
    
    boot = {
        loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
        };
        tmp.cleanOnBoot = true;
        kernelPackages = pkgs.linuxPackages_zen;
    };

    networking = {
        hostName = "navi";
        networkmanager.enable = true;
        useDHCP = lib.mkDefault true;
    };

    time.timeZone = "America/Chicago";
    i18n.defaultLocale = "en_US.UTF-8";

    users.users.eli = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        shell = pkgs.mksh;
    };

    home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.eli = import ./home.nix;
        extraSpecialArgs = { inherit inputs pkgs pkgs-unstable; };
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

    sound.enable = true; # <--- amixer for volume ctrl
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        extraConfig.pipewire = {
            "99-no-bell.conf" = { # <- murder the bell
                "context.properties" = {
                    "module.x11.bell" = false;
                };
            };
        };
    };

    # basic video + input config
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

#    xdg.portal = {
#        enable = true;
#        xdgOpenUsePortal = true;
#        extraPortals = with pkgs; [ 
#            xdg-desktop-portal-gtk xdg-desktop-portal-wlr 
#        ];
#    };

    environment.etc."issue".text = '''';

    environment.systemPackages = with pkgs; [
        (writeScriptBin "sudo" ''exec doas "$@"'')
        micro git wget curl lact nix-prefetch-scripts 
    ];

    fonts.packages = with pkgs; [
        terminus_font
        unifont dejavu_fonts
        uw-ttyp0 inconsolata
    ];

    systemd.services.lact = {
        enable = true;
        description = "amdgpu control daemon";
        after = [ "multi-user.target" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
            ExecStart =  "${pkgs.lact}/bin/lact daemon";
        };
    };

    programs.steam = {
        enable = true;
        dedicatedServer.openFirewall = true;
    };
    
    programs.gamemode.enable = true;
    programs.gamescope.enable = true;

    nix.settings.auto-optimise-store = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    system.stateVersion = "24.05";
}

