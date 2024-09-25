{ config, lib, pkgs, ... }:

{
    imports = [
        ./audio.nix
        ./boot.nix
        ./doas.nix
        ./font.nix
        ./gui.nix
        ./locale.nix
        ./net.nix
        ./user.nix
    ];

    config = {
        users.defaultUserShell = pkgs.mksh;

        environment.systemPackages = with pkgs; [
            micro git  wget curl
            nix-prefetch-scripts
        ];

        environment.etc."issue".text = '''';

        nix.settings.auto-optimise-store = true;
        nix.settings.experimental-features = [ "nix-command" "flakes" ];

        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
    
        system.stateVersion = "24.05";
        home-manager.users.eli.home.stateVersion = "24.05";
    };
}
