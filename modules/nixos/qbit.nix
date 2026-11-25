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
      serverConfig = {
        BitTorrent = {
          "Session\\DefaultSavePath" = "/mnt/nvme/tor";
          "Session\\DHTEnabled" = false;
          "Session\\PeXEnabled" = false;
          "Session\\LSDEnabled" = false;
          "Session\\Interface" = "wlp9s0";
          "Session\\InterfaceAddress" = "";
          "Session\\InterfaceName" = "wlp9s0";
          "Session\\QueueingSystemEnabled" = false;
        };
      };
    };
  };
}
