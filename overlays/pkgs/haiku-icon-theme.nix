{ lib
, stdenvNoCC
, fetchFromGitHub
, gtk3
, hicolor-icon-theme
}:

stdenvNoCC.mkDerivation rec {
  pname = "haiku-icon-theme";
  version = "0-unstable-2022-02-23";

  src = fetchFromGitHub {
    owner = "tallero";
    repo = pname;
    rev = "7577be42c717faace2c5a4db5cc92850d76df42b";
    sha256 = "sha256-3CRz0zRwDtZF1MgPG1+xyiimxG4RLZshW92hjk+TjRA=";
  };

  nativeBuildInputs = [ gtk3 ];

  propagatedBuildInputs = [ hicolor-icon-theme ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/icons
    cp -a Haiku $out/share/icons

    for theme in $out/share/icons/*; do
      gtk-update-icon-cache -f $theme
    done

    runHook postInstall
  '';

  meta = with lib; {
    description = "Icons for GTK ported from Haiku OS";
    homepage = "https://www.gnome-look.org/p/1012423/";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = with maintainers; [ "2-n" ];
  };
}
