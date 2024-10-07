{ lib
, stdenv
, fetchFromGitHub
, bison
, flex
, libxcb
, xcbutilwm
, xcb-util-cursor
, wmutils-libwm
}:
let
    libwm =
        (wmutils-libwm.overrideAttrs (oldAttrs: rec {
            src = fetchFromGitHub {
                owner = "wmutils";
                repo = "libwm";
                rev = "dfa861903e4f1a045c6aaf4869dd6517941db689";
                sha256 = "14rnz5n1d89gy0dcrd6wnryjxgmcyszs2y1kjahy8fzn67xq1mji";
            };
            buildInputs = oldAttrs.buildInputs ++ [ xcb-util-cursor ];
        }));
in
stdenv.mkDerivation rec {
    pname = "wc-ruler";
    version = "0.1.2";

    src = fetchFromGitHub {
        owner  = "tudurom";
        repo   = "ruler";
        rev    = "v${version}";
        sha256 = "0gb3pz4dav6z9nlqw1z84x1aqibingv7hgqws17fgpw55z05kan3";
    };

    nativeBuildInputs = [ bison flex ];
    
    buildInputs = [ libxcb xcbutilwm xcb-util-cursor libwm ];

    makeFlags = [ "PREFIX=$(out)" ];

    meta = with lib; {
        homepage = "https://github.com/tudurom/ruler";
        description = "ruler is a program used for creating rules like in some window managers.";
        maintainers = with maintainers; [ "2-n" ];
        license = licenses.isc;
        platforms = platforms.linux;
    }; 
}
