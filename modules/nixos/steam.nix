{ lib
, config
, pkgs
, ...
}:

{
    config = lib.mkIf (config.programs.steam.enable) {
        environment.systemPackages = with pkgs; [
            mangohud
            (lutris.override {
                extraLibraries = pkgs: [ libadwaita gtk4 ];
            }) # add necessary libraries for winetricks to work right
            (writeScriptBin "fixcss.sh" 
            ''
            # use when on main menu, may show error in terminal disregard that, and textures should load
            path=$HOME/nix/cfg
            css=$(pidof cstrike_linux64)
            doas ${pkgs.gdb}/bin/gdb -n -q -batch-silent\
                 -ex "attach $css" \
                 -ex "set \$dlopen = (void*(*)(char*, int)) dlopen" \
                 -ex "call \$dlopen(\"$path/css_fix_linux_textures.so\", 1)" \
                 -ex "detach" \
                 -ex "quit"
            '') # https://github.com/ValveSoftware/Source-1-Games/issues/6868 <- github issue regarding the problem
        ];      # issue described above, dont use on vac servers just in case (this is a fix made by a friend of a friend)

        programs.nix-ld = {
            enable = true;
            libraries = with pkgs; [ libz ];
        }; # for GModCEFCodecFix to patch GMod
      
        programs.gamescope = {
            enable = true;
            args = [
                "-W 2560"
                "-H 1440"
                "-r 144"
                "-f"
                "--force-grab-cursor"
                "--backend sdl"
                "--immediate-flips"
                "--rt"
            ];
        };
        # basic launch options for all games:
        # gamemoderun gamescope -- %command%
        programs.gamemode = {
            enable = true;
            settings = {
                general = {
                    desiredgov = "performance";
                    renice = 10;
                };
                gpu = {
                    apply_gpu_optimisations = "accept-responsibility";
                    gpu_device = 1;
                    amd_performance_level = "high";
                };
            };
        };

        programs.steam = {
            protontricks.enable = true;
            dedicatedServer.openFirewall = true;
        };
    };
}

