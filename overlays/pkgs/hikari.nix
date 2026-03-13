{ lib, pkgs, stdenv, fetchzip
, pkg-config, bmake
, cairo, glib, libdrm, libevdev, libinput, libxkbcommon, linux-pam, pango, pixman
, libucl, wayland, wayland-scanner, wayland-protocols, wlroots_0_18, mesa, pandoc, xorg
, features ? {
    gammacontrol = true;
    layershell   = true;
    screencopy   = true;
    xwayland     = true;
  }
}:

# this derivation doesnt work anymore
# just keeping incase i wanna figure it out

stdenv.mkDerivation rec {
  pname = "hikari";
  version = "2.3.9";

  src = fetchzip {
    url = "https://hub.darcs.net/hiroo/hikari/dist/hikari.zip";
    hash = "sha256-8oS7lOjsMZzJVoB911FUIcttL+o3cAqZTvCOJIuJk1w=";
  };

  nativeBuildInputs = [ pkg-config bmake ];

  buildInputs = [
    cairo
    pandoc
    glib
    libdrm
    libevdev
    libinput
    libxkbcommon
    linux-pam
    pango
    pixman
    libucl
    mesa # for libEGL
    wayland
    wayland-scanner
    wayland-protocols
    wlroots_0_18
    xorg.xcbutilwm # for xcb/xcb_ewmh.h as its not provided for wlroots xwayland?
  ];

  enableParallelBuilding = true;

  makeFlags = with lib; [ "PREFIX=$(out)" ]
    ++ optional stdenv.isLinux "WITH_POSIX_C_SOURCE=YES"
    ++ mapAttrsToList (feat: enabled:
      optionalString enabled "WITH_${toUpper feat}=YES"
    ) features;

  postPatch = ''
    # Can't suid in nix store
    # Run hikari as root (it will drop privileges as early as possible), or create
    # a systemd unit to give it the necessary permissions/capabilities.
    substituteInPlace Makefile --replace '4555' '555'

    sed -i 's@<drm_fourcc.h>@<libdrm/drm_fourcc.h>@' src/*.c
  '';

  meta = with lib; {
    description = "Stacking Wayland compositor which is actively developed on FreeBSD but also supports Linux";
    homepage    = "https://hikari.acmelabs.space";
    license     = licenses.bsd2;
    platforms   = platforms.linux ++ platforms.freebsd;
    maintainers = with maintainers; [ jpotier "2-n" ];
  };
}
