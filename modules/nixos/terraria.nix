{ lib
, config
, ...
}:

{
  config = lib.mkIf (config.services.terraria.enable) {
    users.users.eli.extraGroups = [ "terraria" ];

    services.terraria = {
      dataDir = "/mnt/nvme/srv/terraria";
      worldPath = "/mnt/nvme/srv/terraria/The_Abusive_Tunnel.wld";
      openFirewall = true;
      autoCreatedWorldSize = "large"; # set to size of generated world
      maxPlayers = 16;
      password = "poop";
    };
  };
}
