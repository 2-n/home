{ lib
, config
, pkgs
, ...
}:

{
    config = lib.mkIf (config.services.minecraft-servers.enable) {
        users.users.eli.extraGroups = [ "minecraft" ];
    
        environment.systemPackages = with pkgs; [
            (writeScriptBin "mcsrvcon" 
            ''${pkgs.tmux}/bin/tmux -S /run/minecraft/$(ls /run/minecraft | ${pkgs.fzf}/bin/fzf) attach'') 
        ];

        services.minecraft-servers = {
            openFirewall = true;
            eula = true;
            servers.fabric = {
                enable = true;
                jvmOpts = "-Xms1G -Xmx8G";
                package = pkgs.fabricServers.fabric-1_21_5.override { loaderVersion = "0.16.10"; };
                serverProperties = {
                    difficulty = "hard";
                    level-seed = "-9062437628591105524";
                    spawn-protection = 0;
                    motd = "try commands prompted by /coords";
                    white-list = true;
                };
                operators = {
                    stuffedcat = "a0164952-8e47-4690-856b-9eb0db75b35e";
                };
                whitelist = {
                    Blu45 = "6082655f-f9ad-4b05-a0e6-6ba58e34b4f6";
                    Danpolbar = "b316af9b-60f8-4670-8121-130d7e5ea170";
                    Dirt_Snowman = "7a2d816c-e347-4aa6-a6e6-ec91692e6510";
                    Im_Throwing = "6b0098df-d7df-41a6-aff7-b659da58f98b";
                    JJu1ce = "9211c306-718c-4eb1-b130-be2e31bee95d";
                    KingsAdamas = "1bd6851a-c3fb-455e-878f-aac7439b48cd";
                    rowtheatl = "3faf3db9-2be0-4039-9164-325865c0e689";
                    SpicyCactus00 = "a619525a-a7cf-4730-a8e2-3dbb7f1a0a1e";
                    stuffedcat = "a0164952-8e47-4690-856b-9eb0db75b35e";
                    TheCarrotMan = "1bbf4e3c-bacd-43f4-b2ce-4ed2fdf67f84";
                };
                symlinks = {
                    mods = pkgs.linkFarmFromDrvs "mods" (builtins.attrValues {
                        fabricapi = pkgs.fetchurl {
                            url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/FZ4q3wQK/fabric-api-0.119.9%2B1.21.5.jar";
                            hash = "sha256-Bo9zMisO6IKtyXsgzse4sqIvfA595bnxEyLRKJBhIqo=";
                        };
                        clothconfigapi = pkgs.fetchurl {
                            url = "https://cdn.modrinth.com/data/9s6osm5g/versions/qA00xo1O/cloth-config-18.0.145-fabric.jar";
                            hash = "sha256-7GcBJ2Gu6GwUCpEDWMSd28JLhS6YBweUBwVyHhv/Xn8=";
                        };
                        nochatreports = pkgs.fetchurl {
                            url = "https://cdn.modrinth.com/data/qQyHxfxd/versions/CHlHxkvf/NoChatReports-FABRIC-1.21.5-v2.12.0.jar";
                            hash = "sha256-0Pj1Y4URyGX2XfIKAWpPwUmpAjhCy+UO5CIYOvnKVh0=";
                        };
                        dcpacketfix = pkgs.fetchurl {
                            url = "https://cdn.modrinth.com/data/rd9rKuJT/versions/Gv74xveQ/disconnect-packet-fix-fabric-2.0.0.jar";
                            hash = "sha256-KLUW2mtMbyMlv5hNBdIcE57e13kE7FJ1B26lxBUyvIM=";
                        };
                        textilebackup = pkgs.fetchurl {
                            url = "https://cdn.modrinth.com/data/wwcspvkr/versions/C73KkDD6/textile_backup-3.1.3-1.21.jar";
                            hash = "sha256-4i6F8u2bKyzuXZ+UMFbOf7RAhMnqeiUmVI6di68orQ8=";
                        };
                        lithium = pkgs.fetchurl {
                            url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/nhc57Td2/lithium-fabric-0.16.0%2Bmc1.21.5.jar";
                            hash = "sha256-cdTy8cyb9cYTObk5iXrmHmt0FxgtpedqbkDQ9b9ZnIg=";
                        };
                        ferrite = pkgs.fetchurl {
                            url = "https://cdn.modrinth.com/data/uXXizFIs/versions/CtMpt7Jr/ferritecore-8.0.0-fabric.jar";
                            hash = "sha256-K5C/AMKlgIw8U5cSpVaRGR+HFtW/pu76ujXpxMWijuo=";  
                        };
                        krypton = pkgs.fetchurl {
                            url = "https://cdn.modrinth.com/data/fQEb0iXm/versions/neW85eWt/krypton-0.2.9.jar";
                            hash = "sha256-uGYia+H2DPawZQxBuxk77PMKfsN8GEUZo3F1zZ3MY6o=";
                        };
                        c2me = pkgs.fetchurl {
                            url = "https://cdn.modrinth.com/data/VSNURh3q/versions/Wh5CxZTp/c2me-fabric-mc1.21.5-0.3.2%2Bbeta.1.0.jar";
                            hash = "sha256-NyMNlpYgh6hWQfRpD8jUKRgGHQCSAmtnHJoioM9rUjQ=";
                        };
                        carpet = pkgs.fetchurl {
                            url = "https://github.com/gnembon/fabric-carpet/releases/download/1.4.169/fabric-carpet-1.21.5-1.4.169+v250325.jar";
                            hash = "sha256-RQYsKAkSvlPjWih0RCRygKfxLkn165uaCPlNPPx8goE=";
                        };
                        servux = pkgs.fetchurl {
                            url = "https://cdn.modrinth.com/data/zQhsx8KF/versions/GGj3rNei/servux-fabric-1.21.5-0.6.0.jar";
                            hash = "sha256-ua3waMsLFo/VOUksI4GkcgdssxRLPyJg/g5Ib7TdSzU=";
                        };
                        leavesusinpeace = pkgs.fetchurl {
                            url = "https://cdn.modrinth.com/data/IIpWIe1o/versions/Epz8gO6h/leaves-us-in-peace-1.8.0%2BMC1.21.5.jar";
                            hash = "sha256-VkNPEefPR/5SAzC1ff4wxnOGLnXHpvNlrECBhUmHhyA=";
                        };
                        coordfinder = pkgs.fetchurl {
                            url = "https://cdn.modrinth.com/data/kPkTtp4N/versions/geHUXs1Q/coordfinder-fabric-1.21.5-1.1.0.jar";
                            hash = "sha256-YKXE5rheOvUfmBwpZnnrzNpDcLdVXXTj9wV/sceGAgU=";
                        };
                    });
                };
            };
        };
    };
}
