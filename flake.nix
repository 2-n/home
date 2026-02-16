{
  description = "my system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    betterfox-nix.url = "github:HeitorAugustoLN/betterfox-nix";
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
      meiframe = nixpkgs.lib.nixosSystem rec {
        specialArgs = { inherit system inputs pkgs-unstable; };
        modules = [
          ./hosts/meiframe
          home-manager.nixosModules.home-manager {
            nixpkgs.pkgs = pkgs;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = specialArgs;
            home-manager.users.eli = import ./hosts/meiframe/home.nix;
          }
        ];
      };
    };
  };
}
