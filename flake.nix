{
    description = "my system";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
        chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
        home-manager.url = "github:nix-community/home-manager/release-24.11";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = inputs@{ 
        nixpkgs, 
        nixpkgs-unstable, 
        chaotic,
        home-manager, 
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
                    inherit inputs chaotic system pkgs-unstable; 
                };
                modules = [
                    ./hosts/navi
                    chaotic.nixosModules.nyx-cache
                    chaotic.nixosModules.nyx-overlay
                    chaotic.nixosModules.nyx-registry
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
