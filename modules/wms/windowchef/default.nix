{ config, lib, pkgs, ... }:

{
    config = lib.mkIf (config.gui.enable && config.wm == "windowchef") {
        home-manager.users.eli = { config, pkgs, ... }: {
            home.file.".config/ruler/rulerrc".source = config.lib.file.mkOutOfStoreSymlink /home/eli/nix/cfg/windowchef/rulerrc;
            home.file.".config/sxhkd/sxhkdrc".source = config.lib.file.mkOutOfStoreSymlink /home/eli/nix/cfg/windowchef/sxhkdrc;
            home.file.".config/windowchef/windowchefrc".source = config.lib.file.mkOutOfStoreSymlink /home/eli/nix/cfg/windowchef/windowchefrc;
            home.packages = with pkgs; [
                (windowchef.overrideAttrs (oldAttrs: rec {
                    src = fetchFromGitHub {
                        owner = "tudurom";
                        repo = "windowchef";
                        rev = "0290fc38a00b3def92171000754ea3d7e882f52a";
                        sha256 = "0xis1paw6m0h3cqpld48g3zy65kq5acskc27nxnabh4c7ywd34l5";
                    };
                })) 
                sxhkd wmutils-core (callPackage ./ruler {})
            ];
        };
    };
}
