{ lib
, config
, pkgs
, ...
}:

{
    config = lib.mkIf (config.services.minecraft-servers.enable) {
        services.minecraft-servers = {
            eula = true;
            openFirewall = true;
            servers.fabric = {
                enable = true;
                jvmOpts = "-Xms1G -Xmx8G";
                package = pkgs.fabricServers.fabric-1_21_5.override { loaderVersion = "0.16.10"; };
                
                serverProperties = {
                    difficulty = "hard";
                    level-seed = "-9062437628591105524";
                    spawn-protection = 0;
                    motd = "da minecraft server";
                    white-list = true;
                };
                
                whitelist = {
                    stuffedcat = "a0164952-8e47-4690-856b-9eb0db75b35e";
                    Danpolbar = "b316af9b-60f8-4670-8121-130d7e5ea170";
                    KingsAdamas = "1bd6851a-c3fb-455e-878f-aac7439b48cd";
                    JJu1ce = "9211c306-718c-4eb1-b130-be2e31bee95d";
                    Im_Throwing = "6b0098df-d7df-41a6-aff7-b659da58f98b";
                    TheCarrotMan = "1bbf4e3c-bacd-43f4-b2ce-4ed2fdf67f84";
                };
                
                symlinks = {
                    mods = pkgs.linkFarmFromDrvs "mods" (builtins.attrValues {
                        carpet = pkgs.fetchurl {
                            url = "https://github.com/gnembon/fabric-carpet/releases/download/1.4.169/fabric-carpet-1.21.5-1.4.169+v250325.jar";
                            hash = "sha256-RQYsKAkSvlPjWih0RCRygKfxLkn165uaCPlNPPx8goE=";
                        };
                        lithium = pkgs.fetchurl {
                            url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/nhc57Td2/lithium-fabric-0.16.0%2Bmc1.21.5.jar";
                            hash = "sha256-cdTy8cyb9cYTObk5iXrmHmt0FxgtpedqbkDQ9b9ZnIg=";
                        };
                    });
                };
            };
        };
    };
}
