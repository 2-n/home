{
    description = "my system";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager/release-25.11";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
        nix-minecraft.url = "github:Infinidoge/nix-minecraft";
        betterfox-nix.url = "github:HeitorAugustoLN/betterfox-nix";
    };

    outputs = inputs@{
        nixpkgs, 
        nixpkgs-unstable, 
        home-manager, 
        nix-minecraft,
        ... 
    }: 
    let
        system = "x86_64-linux";
        pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [
                nix-minecraft.overlay
                (import ./overlays)
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
                    inherit inputs system pkgs-unstable; 
                };
                modules = [
                    ./hosts/navi
                    nix-minecraft.nixosModules.minecraft-servers
                    home-manager.nixosModules.home-manager {
                        nixpkgs.pkgs = pkgs;
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.extraSpecialArgs = specialArgs;
                        home-manager.users.eli = import ./hosts/navi/home.nix;
                        home-manager.backupFileExtension = "backup";
                    }
                ];
            };
        };
    };
}
