{
    description = "my nix flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager/release-24.05";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = { nixpkgs, nixpkgs-unstable, home-manager, self, ... }@inputs: 
    let
        system = "x86_64-linux";
        pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
        };
        pkgs-unstable = import nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
        };
    in  
    {
        nixosConfigurations = {
            navi = nixpkgs.lib.nixosSystem {
                specialArgs = { inherit inputs pkgs pkgs-unstable system; };
                modules = [ ./hosts/navi inputs.home-manager.nixosModules.home-manager ];
            };
        };
    };
}
