{ lib
, config
, ...
}:

{
  config = lib.mkIf (config.services.qbittorrent.enable) {
    services.qbittorrent = {
      webuiPort = 4949;
      torrentingPort = 39617;
      openFirewall = true;
    };
  };
}
