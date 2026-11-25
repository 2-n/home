{ lib
, config
, inputs
, ...
}:
let
  theme = config.theme;
in
{
  imports = [ inputs.mangowm.hmModules.mango ];

  config = lib.mkIf (config.wayland.windowManager.mango.enable) {
    wayland.windowManager.mango = {
      autostart_sh = "foot -s &";
      settings = {
        env = [
          "NIXOS_OZONE_WL,1"
          "MOZ_ENABLE_WAYLAND,1"
          "_JAVA_AWT_WM_NONREPARENTING,1"
        ];
        border_px = 3;
        border_radius = 0;
        gap = {
          inner_horizontal = 0;
          inner_vertical = 0;
          outer_horizontal = 0;
          outer_vertical = 0;
        };
        root_color = "0x891446ff";
        border_color = "0x404040ff";
        focus_color = "0xdeadcaff";
        urgent_color = "0xd977a3ff";
        maximized_screen_color = "0xdeadcaff";
        scratchpad_color = "0xdeadcaff";
        global_color = "0xdeadcaff";
        overlay_color = "0xdeadcaff";
        split_color = "0xd977a3ff";
        blur = 0;
        shadows = 0;
        animations = 0;
        allow_tearing = 2;
        repeat_rate = 25;
        repeat_delay = 500;
        mouse_accel_profile = 0;
        jump_labels = "ASDFGHJKLQWERTYUIOPZXCVBNM";
        jump_label_decorate = {
          border_width = 3;
          corner_radius = 0;
          padding_x = 3;
          padding_y = 3;
          font_desc = "${config.theme.font.name} ${toString (config.theme.font.size)}";
          fg_color = "0xffffffff";
          bg_color = "0x000000ff";
          focus_fg_color = "0x000000ff";
          focus_bg_color = "0xffffffff";
          border_color = "0xd977a3ff";
        };
        scroller = {
          structs = 0;
          default_proportion = "1.0";
          proportion_preset = "0.5,0.8,1.0";
        };
        monocle_tab_mode = 0;
        tag_rule = [
          "id:1,layout_name:scroller"
          "id:2,layout_name:scroller"
          "id:3,layout_name:scroller"
          "id:4,layout_name:scroller"
          "id:5,layout_name:monocle"
        ];
        window_rule = [
          "app_id:firefox,tags:1"
          "app_id:feishin,tags:2"
          "app_id:discord|vesktop,tags:3"
          "app_id:steam,tags:4"
          "app_id:steam,title:Steam,scroller_proportion:0.8"
          "app_id:steam,title:Friends List,scroller_proportion:0.2"
          "app_id:steam,title:^(?!(Steam|Friends List)$).*,is_floating:1,width:800,height:600"
          "app_id:keepassxc,is_floating:1,width:800,height:600"
          "app_id:pcmanfm,title:.*(Confirm|Properties|Progress|Copying|Moving|File Operation|Preferences|Error|Warning).*,is_floating:1,width:500,height:300"
        ];
        mousebind = [
          "super,btn_left,moveresize,curmove"
          "super,btn_middle,toggleoverlay"
          "super,btn_right,moveresize,curresize"
        ];
        bind = [
          "super,Escape,reload_config"
          "super+shift,Escape,quit"

          "super+shift,q,killclient"
          "super,space,togglefloating"
          "super,f,togglemaximizescreen"
          "super+shift,f,togglefullscreen"

          "alt,Tab,togglejump,1"
          "super,Tab,focusstack,next"
          "super+shift,Tab,focusstack,prev"

          "super,d,spawn_shell,tofi-run | bash"
          "super,Return,spawn,footclient"
          "super+shift,s,toggle_named_scratchpad,foot-scratchpad,foot-scratchpad,footclient --app-id=foot-scratchpad --title=foot-scratchpad tmux new-session -A -s scratchpad"
          "none,Print,spawn_shell,wshot"
          "super,Print,spawn_shell,wshot s"

          "super,h,focusdir,left"
          "super,j,focusdir,down"
          "super,k,focusdir,up"
          "super,l,focusdir,right"

          "super+shift,h,exchange_client,left"
          "super+shift,j,exchange_client,down"
          "super+shift,k,exchange_client,up"
          "super+shift,l,exchange_client,right"

          "super,comma,switch_proportion_preset"

          "super,1,view,1,0"
          "super,2,view,2,0"
          "super,3,view,3,0"
          "super,4,view,4,0"
          "super,5,view,5,0"

          "super+ctrl,1,toggleview,1"
          "super+ctrl,2,toggleview,2"
          "super+ctrl,3,toggleview,3"
          "super+ctrl,4,toggleview,4"
          "super+ctrl,5,toggleview,5"

          "super+shift,1,tag,1,0"
          "super+shift,2,tag,2,0"
          "super+shift,3,tag,3,0"
          "super+shift,4,tag,4,0"
          "super+shift,5,tag,5,0"

          "super+ctrl+shift,1,toggletag,1"
          "super+ctrl+shift,2,toggletag,2"
          "super+ctrl+shift,3,toggletag,3"
          "super+ctrl+shift,4,toggletag,4"
          "super+ctrl+shift,5,toggletag,5"
        ];
      };
    };
  };
}
