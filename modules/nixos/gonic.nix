{ lib
, config
, ...
}:

{
  config = lib.mkIf (config.services.gonic.enable) {
    networking.firewall.allowedTCPPorts = [ 4747 ];
    networking.firewall.allowedUDPPorts = [ 4747 ];

    services.tailscale.enable = true;
    services.tailscale.extraSetFlags = [ "--accept-dns=false" "--accept-routes" ];

    fileSystems."/var/lib/gonic" = {
      device = "/mnt/nvme/srv/gonic/db";
      fsType = "none";
      options = [ "bind" ];
    }; # temp fix, maybe put in an issue to get db-path to work in the official module

    services.gonic.settings = {
      listen-addr = "0.0.0.0:4747";
      scan-at-start-enabled = true;
      scan-watcher-enabled = true;
      #db-path = "/mnt/nvme/srv/gonic/db/gonic.db";
      cache-path = "/mnt/nvme/srv/gonic/cache";
      music-path = "/mnt/nvme/mus";
      exclude-pattern = "/mnt/nvme/mus/0 - untagged";
      podcast-path = "/mnt/nvme/srv/gonic/podcasts";
      playlists-path = "/mnt/nvme/srv/gonic/playlists";
      multi-value-album-artist = "multi";
      multi-value-artist = "multi";
      multi-value-genre = "multi";
    };
  };
}
