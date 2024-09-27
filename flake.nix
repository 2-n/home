{
    description = "my nix system";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager/release-24.05";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = { ... }@inputs: 

    rec {
        nixosConfigurations = {
            box = import ./hosts/box { inherit inputs; };
        };
        
        homeConfigurations = {
            box = nixosConfigurations.box.config.home-manager.users.eli.home;
        };
    };
}
