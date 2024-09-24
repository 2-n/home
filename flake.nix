{
    description = "nixos config w/ home manager as a module";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager/release-24.05";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, ... }: 
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
            box = nixpkgs.lib.nixosSystem {
                modules = 
                    [ ./hosts/box inputs.home-manager.nixosModules.default ];
                specialArgs = 
                    { inherit inputs pkgs pkgs-unstable system; };
            };
        };
    };
}

#        nixosConfigurations = {
#            box = nixpkgs.lib.nixosSystem rec {
#                specialArgs = { inherit pkgs pkgs-unstable system; };
#                modules = [
#                    ./hosts/box
#                    home-manager.nixosModules.home-manager
#                    {
#                        home-manager.extraSpecialArgs = specialArgs;
#                        home-manager.users.eli = {
#                            imports = [ ./hosts/box/home.nix ];
#                        };
#                    }
#                ];
#            };
#        };
