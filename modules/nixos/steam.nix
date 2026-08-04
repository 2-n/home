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
          gpu_device = 1;
        };
      };
    };

    programs.gamescope = {
      enable = true;
      #"--backend sdl"
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

    environment.systemPackages = with pkgs; [
      (writeScriptBin "fixcss.sh" ''
        # https://github.com/ValveSoftware/Source-1-Games/issues/6868
        # use when on main menu, may show error in terminal disregard that, and textures should load
        path=$HOME/nix/cfg
        css=$(pidof cstrike_linux64)
        doas ${pkgs.gdb}/bin/gdb -n -q -batch-silent \
          -ex "attach $css" \
          -ex "set \$dlopen = (void*(*)(char*, int)) dlopen" \
          -ex "call \$dlopen(\"$path/css_fix_linux_textures.so\", 1)" \
          -ex "detach" \
          -ex "quit"
      '')
    ];
  };
}

