{ lib
, stdenv
, fetchFromCodeberg, fetchpatch
, meson, ninja, pkg-config, bison, flex
, cairo, libbsd, libevent, libxkbcommon, libxml2, ncurses
, pango, pixman, lowdown, python3, tcl, tk, tclPackages
, wayland, wayland-protocols, wayland-scanner, xwayland
}:

# create option sets for nixos and home-manager
# figure out how to incorporate into cow's flake
# make a pull request

stdenv.mkDerivation rec {
  pname = "cow-wm";
  version = "git";

  src = fetchFromCodeberg {
    owner = "cow-wm";
    repo = "cow";
    rev = "main";
    hash = "sha256-dQvgWy5UjRZmXBi1tF3oX/0YUwZk2L6yl/TrRO4aLc8=";
  };

  # for testing patches related to issues
  #patches = [
  #  (fetchpatch {
  #    url = "https://codeberg.org/cow-wm/cow/commit/*commit*.diff";
  #    hash = lib.fakeHash;
  #  })
  #];

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    bison
    flex
  ];

  buildInputs = [
    cairo
    libbsd
    libevent
    libxkbcommon
    libxml2
    ncurses
    pango
    pixman
    lowdown
    python3
    tcl
    tk
    tclPackages.tcllib
    wayland
    wayland-protocols
    wayland-scanner
    xwayland
  ];

  TCLLIBPATH = "${tclPackages.tcllib}/lib";
  hardeningDisable = [ "fortify" ];

  meta = with lib; {
    description = "Compositor on Wayland -- a stacking window manager using river as the compositor. CoW aims to behave like fvwm and mwm from X11.";
    homepage = "https://codeberg.org/cow-wm/cow";
    license = licenses.isc;
    platforms = platforms.linux;
    maintainers = [ "2-n" ];
  };
}
