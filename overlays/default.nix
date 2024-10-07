final: prev: {
    wc-ruler = prev.callPackage ./pkgs/wc-ruler.nix {};
    xcursor-plan9 = prev.callPackage ./pkgs/xcursor-plan9.nix {};

    dmenu = prev.dmenu.overrideAttrs (old: rec {
        src = prev.fetchurl {
            url = "https://dl.suckless.org/tools/dmenu-5.2.tar.gz";
            hash = "sha256-1NTKd7WRQPJyJy21N+BbuRpZFPVoAmUtxX5hp3PUN5I=";
        };
        patches = [ 
            ./patches/dmenu-mega-patch.diff
        ];
    });

    _2bwm = prev._2bwm.overrideAttrs (old: rec {
        src = prev.fetchFromGitHub {
            owner = "venam";
            repo = "2bwm";
            rev = "3ef4149e60f71c74bae5f6b983dbec2fda7cfbab";
            sha256 = "04b6q7527amwd8ri8v0ybv7144f9h60rklv89hfygncpglwmkv0c";
        };
    });

    cwm = prev.cwm.overrideAttrs (old: rec {
        patches = [ 
            ./patches/cwm-center.diff
            ./patches/cwm-nomwmhints.diff
        ];
    });

    windowchef = prev.windowchef.overrideAttrs (old: rec {
        src = prev.fetchFromGitHub {
            owner = "tudurom";
            repo = "windowchef";
            rev = "0290fc38a00b3def92171000754ea3d7e882f52a";
            sha256 = "0xis1paw6m0h3cqpld48g3zy65kq5acskc27nxnabh4c7ywd34l5";
        };
    });
}
