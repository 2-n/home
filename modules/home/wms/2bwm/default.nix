{ config, lib, pkgs, ... }:

{
    config = lib.mkIf (config.wm == "2bwm") {
        home.packages = with pkgs; [
            (_2bwm.overrideAttrs (oldAttrs: rec {
                src = fetchFromGitHub {
                    owner = "venam";
                    repo = "2bwm";
                    rev = "3ef4149e60f71c74bae5f6b983dbec2fda7cfbab";
                    sha256 = "04b6q7527amwd8ri8v0ybv7144f9h60rklv89hfygncpglwmkv0c";
                };
                configFile = writeText "config.h" (builtins.readFile ./config.h);
                postPatch = "cp ${configFile} config.h";
            })) 
        ];            
    };
}
