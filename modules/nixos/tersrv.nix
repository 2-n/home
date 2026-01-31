{ lib
, config
, pkgs
, ...
}:

{
    config = lib.mkIf (config.services.terraria.enable) {
        users.users.eli.extraGroups = [ "terraria" ];

        environment.systemPackages = with pkgs; [
            (writeScriptBin "tersrvcon" 
            ''${pkgs.tmux}/bin/tmux -S /run/terraria/terraria.sock attach'') 
        ];

        services.terraria = {
            openFirewall = true;
            dataDir = "/srv/terraria";
            password = "peenieweenie";
            maxPlayers = 16; 
            worldPath = "/home/eli/Burning_Foothold.wld";
        };
    };
}
