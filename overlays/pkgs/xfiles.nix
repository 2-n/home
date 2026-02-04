{ lib
, stdenv
, fetchFromGitHub
, mandoc
, fontconfig
, libpthreadstubs
, libX11
, libXcursor
, libXext
, libXft
, libXpm
, libXrender
}:

stdenv.mkDerivation rec {
    pname = "xfiles";
    version = "latest";

    src = fetchFromGitHub {
        owner = "phillbush";
        repo = "xfiles";
        rev = "c47a0d984caee93311cb081bd51a5a4a027c9f68";
        hash = "sha256-Qf/C4OkhvyGDzvmA/07rZAnK9PIsjBSqXIdJaX2AJFg=";
    };

    nativeBuildInputs = [ mandoc ];

    buildInputs = [
        fontconfig
        libpthreadstubs
        libX11
        libXcursor
        libXext
        libXft
        libXpm
        libXrender
    ];

    installPhase = ''
        install -D xfiles -t $out/bin/
        install -Dm644 xfiles.1 -t $out/share/man/man1/
    '';

    meta = with lib; {
        homepage = "https://github.com/phillbush/xfiles";
        description = "a X11 File Manager";
        maintainers = with maintainers; [ "2-n" ];
        license = licenses.mit;
        platforms = platforms.linux;
    };
}
