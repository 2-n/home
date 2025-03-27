{
    description = "my system";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager/release-24.11";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
        chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
        nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    };

    outputs = inputs@{ 
        nixpkgs, 
        nixpkgs-unstable, 
        home-manager, 
        chaotic,
        nix-minecraft,
        ... 
    }: 
    let
        system = "x86_64-linux";
        pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [
                (import ./overlays)
                chaotic.overlays.cache-friendly
                nix-minecraft.overlay
            ];
        };
        pkgs-unstable = import nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
        };
    in  
    {
        nixosConfigurations = {
            navi = nixpkgs.lib.nixosSystem rec {
                specialArgs = { 
                    inherit inputs system chaotic pkgs-unstable; 
                };
                modules = [
                    ./hosts/navi
                    chaotic.nixosModules.nyx-cache
                    chaotic.nixosModules.nyx-overlay
                    chaotic.nixosModules.nyx-registry
                    nix-minecraft.nixosModules.minecraft-servers
                    home-manager.nixosModules.home-manager {
                        nixpkgs.pkgs = pkgs;
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.extraSpecialArgs = specialArgs;
                        home-manager.users.eli = import ./hosts/navi/home.nix;
                    }
                ];
            };
        };
    };
}
