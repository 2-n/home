{ config, lib, pkgs, ... }:

{
    xsession.windowManager.command = "exec windowchef";

    xsession.initExtra = lib.concatStringsSep "\n" [
        "pkill ruler; ruler &"
        "pkill sxhkd; sxhkd &" 
    ]; 

    home.file.".config/ruler/rulerrc".source = ../../dots/windowchef/rulerrc;
    home.file.".config/sxhkd/sxhkdrc".source = ../../dots/windowchef/sxhkdrc;
    home.file.".config/windowchef/windowchefrc".source = ../../dots/windowchef/windowchefrc;
    home.file.".config/windowchef/windowchefrc".executable = true;  

    home.packages = (with pkgs; [
        (windowchef.overrideAttrs (oldAttrs: rec {
            src = fetchFromGitHub {
                owner = "tudurom";
                repo = "windowchef";
                rev = "0290fc38a00b3def92171000754ea3d7e882f52a";
                sha256 = "0xis1paw6m0h3cqpld48g3zy65kq5acskc27nxnabh4c7ywd34l5";
            };
        })) 
        sxhkd wmutils-core (callPackage ./ruler {})
    ]);
}
