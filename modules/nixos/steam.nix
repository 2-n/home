{ lib
, config
, pkgs
, ...
}:

{
  config = lib.mkIf (config.programs.steam.enable) {
    users.users.eli.extraGroups = [ "gamemode" ];

    programs.steam = {
      dedicatedServer.openFirewall = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };

    programs.gamemode = {
      enable = true;
      settings = {
        general = {
          desiredgov = "performance";
          renice = 10;
          softrealtime = "auto";
        };
        gpu = {
          amd_performance_level = "high";
          apply_gpu_optimisations = "accept-responsibility";
          gpu_device = 0;
        };
      };
    };

    programs.gamescope = {
      enable = true;
      args = [
        "--output-width 2560"
        "--output-height 1440"
        "--nested-refresh 200"
        "--fullscreen"
        "--force-grab-cursor"
        "--immediate-flips"
        "--rt"
      ];
    };

    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [ libz ];
    }; # for GModCEFCodecFix to patch GMod
  };
}

