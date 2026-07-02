{ lib
, config
, ...
}:

{
  config = lib.mkIf (config.services.gonic.enable) {
    networking.firewall.allowedTCPPorts = [ 4747 ];
    networking.firewall.allowedUDPPorts = [ 4747 ];

    services.tailscale.enable = true;
    services.tailscale.extraSetFlags = [ "--accept-dns=false" ];

    services.gonic.settings = {
      listen-addr = "0.0.0.0:4747";
      scan-at-start-enabled = true;
      scan-watcher-enabled = true;
      music-path = "/mnt/hdd/mus";
      exclude-pattern = "/mnt/hdd/mus/0 - untagged";
      podcast-path = "/mnt/hdd/srv/gonic/podcasts";
      playlists-path = "/mnt/hdd/srv/gonic/playlists";
      multi-value-album-artist = "multi";
      multi-value-artist = "multi";
      multi-value-genre = "multi";
    };
  };
}
