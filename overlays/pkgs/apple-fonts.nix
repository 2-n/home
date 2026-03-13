{ lib
, stdenv
, fetchurl
, p7zip
}:

stdenv.mkDerivation rec {
  pname = "apple-fonts";
  version = "7.0.5"; # version from aur

  pro = fetchurl {
    url = "https://devimages-cdn.apple.com/design/resources/download/SF-Pro.dmg";
    sha256 = "sha256-W0sZkipBtrduInk0oocbFAXX1qy0Z+yk2xUyFfDWx4s=";
  };

  compact = fetchurl {
    url = "https://devimages-cdn.apple.com/design/resources/download/SF-Compact.dmg";
    sha256 = "sha256-RWeq4GFt01r8NLrWvvVH5y/R5lhFMFozlzBkUY0dU0g=";
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
