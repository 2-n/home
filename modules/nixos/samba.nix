{ lib
, config
, ...
}:

{
  config = lib.mkIf (config.services.samba.enable) {
    services.samba = {
      nmbd.enable = false;
      winbindd.enable = false;
      securityType = "user";
      openFirewall = true;
      settings = {
        global = {
          "workgroup" = "WORKGROUP";
          "server string" = "nix samba share";
          "security" = "user";
          "disable netbios" = "yes";
          "smb ports" = "445";
        };
        "shared" = {
          "path" = "/mnt/nvme/srv/samba";
          "browseable" = "yes";
          "read only" = "no";
          "guest ok" = "no";
          "create mask" = "0644";
          "directory mask" = "0755";
          "valid users" = "eli";
        };
      };
    };
  };
}
