{ config, lib, pkgs, ... }:

{ 
    imports = [ ./hardware-configuration.nix ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "box";
    networking.networkmanager.enable = true;

    time.timeZone = "America/Chicago";
    i18n.defaultLocale = "en_US.UTF-8";

    users.defaultUserShell = pkgs.mksh;
    users.users.eli.isNormalUser = true;
    users.users.eli.extraGroups = [ "networkmanager" "corectrl" ];

    security.doas.enable = true;
    security.sudo.enable = false;
    security.doas.extraRules = [{
        users = ["eli"];
        keepEnv = true;
    }];

    environment.systemPackages = (with pkgs; [
        micro git 
    ]);

    sound.enable = true;
    security.rtkit.enable = true;
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

    services.xserver.enable = true;
    services.libinput.mouse.accelProfile = "flat";
    services.xserver.displayManager.sx.enable = true;

    services.gvfs.enable = true;
    services.udev.extraRules = '' 
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", OWNER="eli" 
    '';
    
    services.greetd = {
        enable = true;
        settings = {
            default_session = {
                user = "greeter";
                command = lib.concatStringsSep " " [
                    "${pkgs.greetd.tuigreet}/bin/tuigreet"
                    "--time --time-format %I:%M"
                    "--remember --asterisks"
                    "--cmd sx"
                ];
            };
        };
    };

    programs.steam.enable = true;
    programs.gamemode.enable = true;
    programs.corectrl.enable = true;
    programs.corectrl.gpuOverclock.enable = true;
    programs.corectrl.gpuOverclock.ppfeaturemask = "0xffffffff";

    nix.settings.auto-optimise-store = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    system.stateVersion = "24.05";
}
