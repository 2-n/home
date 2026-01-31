{ lib
, config
, ...
}:

{
    config = lib.mkIf (config.services.lact.enable) {
        services.lact.settings = {
            version = 5;
            daemon = {
                log_level = "info";
                admin_group = "wheel";
                disable_clocks_cleanup = false;
            };
            apply_settings_timer = 5;
            gpus."1002:73BF-1002:0E3A-0000:2c:00.0" = {
                fan_control_enabled = true;
                fan_control_settings = {
                    mode = "curve";
                    static_speed = 0.5;
                    temperature_key = "edge";
                    interval_ms = 500;
                    curve = {
                       "30" = 0.25;
                       "45" = 0.40;
                       "55" = 0.50;
                       "75" = 0.75;
                       "80" = 1.0;
                       "85" = 1.0;
                    };
                    spindown_delay_ms = 0;
                    change_threshold = 0;
                };
                power_cap = 293.0;
                performance_level = "manual";
                voltage_offset = -150;
                power_profile_mode_index = 4;
                power_states = {
                    memory_clock = [ 0 1 2 3 ];
                    core_clock = [ 0 1 2 ];
                };
            };
            current_profile = null;
            auto_switch_profiles = false;
        };
    };
}
