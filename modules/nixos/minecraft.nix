{ lib
, config
, pkgs
, ...
}:

{
  config = lib.mkIf (config.services.minecraft-servers.enable) {
    users.users.eli.extraGroups = [ "minecraft" ];

    services.minecraft-servers = {
      eula = true;
      openFirewall = true;
      dataDir = "/mnt/nvme/srv/minecraft";
      servers.skyblock = {
        enable = false;
        jvmOpts = "-Xms1G -Xmx8G";
        package = pkgs.fabricServers.fabric-26_2.override {
          loaderVersion = "0.19.3";
          jre_headless = pkgs.openjdk25_headless;
        };

        serverProperties = {
          difficulty = "hard";
          spawn-protection = 0;
          motd = "the dudes, skyblock edition. scream if you are chinese!";
          white-list = true;
        };

        operators.stuffedcat = "a0164952-8e47-4690-856b-9eb0db75b35e";

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
          TheMeterStik = "bcf74e87-b48b-4b8c-86a3-3ee9044ec501";
        };

        symlinks = {
          mods = pkgs.linkFarmFromDrvs "mods" (builtins.attrValues {
              fabricapi = pkgs.fetchurl {
                url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/NqwNSxwA/fabric-api-0.158.0%2B26.2.jar";
                sha512 = "4c2c1ebe74ffd54875a01ff371b53ba3d8674ac98d561f7dae02a96d3d37fbdbc5f5abc6e820f73b6154d6f873ddd05a442b0998ed2d456863dc0ad972e040a6";
              };
              skyblock = pkgs.fetchurl {
                url = "https://cdn.modrinth.com/data/bbtyQ1Po/versions/Sq3I2t8o/standard-skyblock-2.1.7.jar";
                sha512 = "92cd422e31099b07e9ef864e3b071c25cd9e42c35c8d021185928a99099f45dedafaf641f03cf2a7369813374f7357b1d57a1d528e848bd2b5574800b3433e9e";
              };
              skyvoidadditions = pkgs.fetchurl {
                url = "https://cdn.modrinth.com/data/HlddKKKU/versions/PiXB2dw8/sky-void-additions-1.6.0.jar";
                sha512 = "067820e061092b5288e3370227d2eb864f999fe698af8a9670aff08205f0ba249a9e6e76b17f5df30fae1bf3c4517b09399db02a672ec934c62b28d1d590f3dd";
              };
              lithium = pkgs.fetchurl {
                url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/f7vZ0VWU/lithium-fabric-0.25.3%2Bmc26.2.jar";
                sha512 = "148b638f3c6229fbaf487120a2344a0af5e411a5aa6533d5db9d75da0a8c0d8304f63eb4cca13f4d03b2c9b4c23d559dd74c1d832422ef8a3087bd005e62a8bd";
              };
              disconnectpacketfix = pkgs.fetchurl {
                url = "https://cdn.modrinth.com/data/rd9rKuJT/versions/8bBHJTea/disconnect-packet-fix-fabric-2.2.0.jar";
                sha512 = "c996bdefa9a91ea7869f39f764012b68232c5717993b776e8feeacb2a4c6930d894ff4dacdf4df3b2d8bd1f50e195eb53d69e8c86d0800a70da5bee9e0163048";
              };
              ferritecore = pkgs.fetchurl {
                url = "https://cdn.modrinth.com/data/uXXizFIs/versions/d5ddUdiB/ferritecore-9.0.0-fabric.jar";
                sha512 = "d81fa97e11784c19d42f89c2f433831d007603dd7193cee45fa177e4a6a9c52b384b198586e04a0f7f63cd996fed713322578bde9a8db57e1188854ae5cbe584";
              };
              servux = pkgs.fetchurl {
                url = "https://cdn.modrinth.com/data/zQhsx8KF/versions/Er2wlain/servux-fabric-26.2-0.11.3.jar";
                sha512 = "42ec8769ba50ecf1ac6b3da4caa554d5dad6e8226ebb4faf0918a483c0a7823e3a1a69ae39c1157029209b4272df6a6fb025c5b797fd0d4402ab9ddcc800ae67";
              };
              carpet = pkgs.fetchurl {
                url = "https://cdn.modrinth.com/data/TQTTVgYE/versions/bGrLxJ8v/fabric-carpet-26.2%2Bv260616.jar";
                sha512 = "8b8fac6979bd3153f5cfb4faa6bab52e1357eab814492a6658f3c0e1ac2856ad37a626c0a03a0839c39abb7bf56661f77b09d05d10ac01173bcdd373a33c6265";
              };
          });
        };
      };
    };
  };
}
