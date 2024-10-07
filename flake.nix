{
    description = "my system";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager/release-24.05";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = inputs@{ 
        nixpkgs, 
        nixpkgs-unstable, 
        home-manager, 
        ... 
    }: 
    let
        system = "x86_64-linux";
        pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [ (import ./overlays) ];
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
                    inherit inputs pkgs pkgs-unstable system; 
                };
                modules = [
                    ./hosts/navi
                    home-manager.nixosModules.home-manager {
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
