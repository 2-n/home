{ lib
, stdenv
, fetchurl
, p7zip 
, nerd-font-patcher
}:

stdenv.mkDerivation rec {
    pname = "apple-fonts-nerd";
    version = "1";

    pro = fetchurl {
        url = "https://devimages-cdn.apple.com/design/resources/download/SF-Pro.dmg";
        sha256 = "sha256-IccB0uWWfPCidHYX6sAusuEZX906dVYo8IaqeX7/O88=";
    };

    compact = fetchurl {
        url = "https://devimages-cdn.apple.com/design/resources/download/SF-Compact.dmg";
        sha256 = "sha256-PlraM6SwH8sTxnVBo6Lqt9B6tAZDC//VCPwr/PNcnlk=";
    };

    mono = fetchurl {
        url = "https://devimages-cdn.apple.com/design/resources/download/SF-Mono.dmg";
        sha256 = "sha256-bUoLeOOqzQb5E/ZCzq0cfbSvNO1IhW1xcaLgtV2aeUU=";
    };

    ny = fetchurl {
        url = "https://devimages-cdn.apple.com/design/resources/download/NY.dmg";
        sha256 = "sha256-HC7ttFJswPMm+Lfql49aQzdWR2osjFYHJTdgjtuI+PQ=";
    };

    nativeBuildInputs = [ p7zip nerd-font-patcher ];

    sourceRoot = ".";

    dontUnpack = true;

    installPhase = ''
        7z x ${pro}
        cd SFProFonts 
        7z x 'SF Pro Fonts.pkg'
        7z x 'Payload~'
        mkdir -p $out/fontfiles
        mv Library/Fonts/* $out/fontfiles
        cd ..
        
        7z x ${mono}
        cd SFMonoFonts
        7z x 'SF Mono Fonts.pkg'
        7z x 'Payload~'
        mv Library/Fonts/* $out/fontfiles
        cd ..
        
        7z x ${compact}
        cd SFCompactFonts
        7z x 'SF Compact Fonts.pkg'
        7z x 'Payload~'
        mv Library/Fonts/* $out/fontfiles
        cd ..
        
        7z x ${ny}
        cd NYFonts
        7z x 'NY Fonts.pkg'
        7z x 'Payload~'
        mv Library/Fonts/* $out/fontfiles
        cd ..

        mkdir -p $out/patched
        
        for fontfile in $out/fontfiles/*
        do
        nerd-font-patcher $fontfile --complete --careful --outputdir $out/patched
        done
        
        mkdir -p $out/usr/share/fonts/OTF $out/usr/share/fonts/TTF
        mv $out/patched/*.otf $out/usr/share/fonts/OTF
        mv $out/patched/*.ttf $out/usr/share/fonts/TTF
        rm -rf $out/fontfiles $out/patched
    '';

    meta = {
        description = "Apple San Francisco, New York fonts, patched with Nerd Fonts";
        homepage = "https://developer.apple.com/fonts/";
        license = lib.licenses.unfree;
    };
}
