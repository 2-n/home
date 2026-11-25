{ lib
, stdenv
, fetchurl
, p7zip
}:

# fix install phase, some of these dmgs seem to be formatted differently than
# each other / how they were previously packaged (have to use bsdtar to extract)

stdenv.mkDerivation rec {
  pname = "apple-fonts";
  version = "7.0.5"; # version from aur

  pro = fetchurl {
    url = "https://devimages-cdn.apple.com/design/resources/download/SF-Pro.dmg";
    sha256 = "sha256-sn/mYi8fqWpwfHPcpmZtQ5w1sxLVsdR+DimA5hjrSyg=";
  };

  compact = fetchurl {
    url = "https://devimages-cdn.apple.com/design/resources/download/SF-Compact.dmg";
    sha256 = "sha256-byQRcYdqhBdNS5m69Gm6+z+OJFTOoSPYULM/H7D3D18=";
  };

  mono = fetchurl {
    url = "https://devimages-cdn.apple.com/design/resources/download/SF-Mono.dmg";
    sha256 = "sha256-bUoLeOOqzQb5E/ZCzq0cfbSvNO1IhW1xcaLgtV2aeUU=";
  };

  ny = fetchurl {
    url = "https://devimages-cdn.apple.com/design/resources/download/NY.dmg";
    sha256 = "sha256-HC7ttFJswPMm+Lfql49aQzdWR2osjFYHJTdgjtuI+PQ=";
  };

  nativeBuildInputs = [ p7zip ];

  sourceRoot = ".";

  dontUnpack = true;

  installPhase = ''
    mkdir -p tmp fonts

    for archive in ${pro} ${compact} ${mono} ${ny}; do
      7z e "$archive" -y -otmp
      cd tmp/
      7z x *.pkg -y
      7z x Payload\~ -y
      mv Library/Fonts/* ../fonts
      cd ../
      rm -r tmp/{*,.*}
    done

    mkdir -p $out/usr/share/fonts/OTF $out/usr/share/fonts/TTF
    mv fonts/*.otf $out/usr/share/fonts/OTF/
    mv fonts/*.ttf $out/usr/share/fonts/TTF/
    rm -r tmp fonts
  '';

  meta = with lib; {
    description = "Apple San Francisco and New York fonts";
    homepage = "https://developer.apple.com/fonts/";
    license = licenses.unfree;
    platforms = platforms.linux;
    maintainers = with maintainers; [ "2-n" ];
  };
}
