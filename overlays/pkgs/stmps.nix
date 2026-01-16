{ lib
, buildGoModule
, fetchFromGitHub
, pkg-config
, mpv-unwrapped
}:

buildGoModule rec {
    pname = "stmps";
    version = "git";

    src = fetchFromGitHub {
        owner = "spezifisch";
        repo  = "stmps";
        rev   = "4a8428bc06cc2490ff1caf7fc53fcacc5fc398c0";
        hash  = "sha256-yR2foOt6sDShaLQ1dB4S9ni5sseItHxKBwTVvE5Em6g=";
    };

    nativeBuildInputs = [ pkg-config ];

    buildInputs = [ mpv-unwrapped ];
    #extraPropagatedBuildInputs = [ mpv-unwrapped ];

    vendorHash = "sha256-nQ+njG45mYJ6lkGPOsEe+ob4EXvIoJ2d+cFXZSM3Lls=";

    meta = with lib; {
        homepage = "https://github.com/spezifisch/stmps";
        description = "stmps (stamps) is a terminal client for *sonic music servers, inspired by ncmpcpp and musickube.";
        maintainers = with maintainers; [ "2-n" ];
        license = licenses.gpl3;
        platforms = platforms.linux;
    }; 
}
