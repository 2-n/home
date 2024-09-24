{ lib, stdenv, fetchFromGitHub, libXcursor }:

stdenv.mkDerivation rec {
    pname = "xcursor-plan9";
    version = "0.2";
    src = fetchFromGitHub {
        owner = "wintermute-cell";
        repo = pname;
        rev = "v${version}";
        sha256 = "sha256-74ykNDuknGdP6j+cS4ePtGTkGGLqQdpu54TuG7262QI=";
    };

    nativeBuildInputs = [ ];

    buildInputs = [ libXcursor ];

    meta = with lib; {
        description = "Xorg cursor theme based on plan9 cursors";
        platforms = platforms.unix;
        maintainers = with maintainers; [ winterveil ];
        homepage = "https://github.com/wintermute-cell/xcursor-plan9";
    };

    installPhase = ''
        install -dm755 $out/share/icons/plan9
        cp -r cursors cursor.theme index.theme $out/share/icons/plan9/
    '';
}
