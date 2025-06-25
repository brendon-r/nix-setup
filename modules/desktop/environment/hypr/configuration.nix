{inputs, ...}: {
  flake.modules.homeManager.hyprland = {
    pkgs,
    perSystem,
    ...
  }: {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
      package = inputs.hyprland.packages.x86_64-linux.hyprland;
      portalPackage = inputs.hyprland.packages.x86_64-linux.xdg-desktop-portal-hyprland;

      settings = {
        "$terminal" = "ghostty";
        "$mod" = "SUPER";
        "$fileManager" = "dolphin";
        "$menu" = "wofi --show drun";
        "$&" = "override";

        general = {
          gaps_in = 8;
          gaps_out = 16;
          border_size = 3;
          "col.active_border" = "rgba(33ccffee)";
          "col.inactive_border" = "rgb(333333)";
          resize_on_border = true;
          allow_tearing = false;
          layout = "dwindle";
        };

        decoration = {
          rounding = 8;
          rounding_power = 4;
          active_opacity = 1;
          inactive_opacity = 0.7;
          fullscreen_opacity = 1;
          shadow = {
            enabled = false;
            range = 4;
            render_power = 3;
            color = "rgba(1a1a1aee)";
          };

          blur = {
            special = false;
            enabled = true;
            size = 5;
            passes = 2;
            vibrancy = 0.1696;
          };
        };

        env = [
          "NIXOS_OZONE_WL,1"
          "_JAVA_AWT_WM_NONREPARENTING,1"
          "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
          "QT_QPA_PLATFORM,wayland"
          "SDL_VIDEODRIVER,wayland"
          "GDK_BACKEND,wayland"
          "XDG_SESSION_DESKTOP,Hyprland"
          "XDG_CURRENT_DESKTOP,Hyprland"
          "XCURSOR_THEME,Bibata-Modern-Classic"
          "XCURSOR_SIZE,23"
          "HYPRCURSOR_THEME,Bibata-Modern-Classic"
          "HYPRCURSOR_SIZE,23"
        ];

        animations = {
          enabled = true;
          bezier = [
            "easeOutQuint,0.23,1,0.32,1"
            "easeInOutCubic,0.65,0.05,0.36,1"
            "linear,0,0,1,1"
            "almostLinear,0.5,0.5,0.75,1.0"
            "quick,0.15,0,0.1,1"
          ];
          animation = [
            "border, 1, 5.39, easeOutQuint"
            "windows, 1, 4.79, easeOutQuint"
            "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
            "windowsOut, 1, 1.49, linear, popin 87%"
            "fadeIn, 1, 1.73, almostLinear"
            "fadeOut, 1, 1.46, almostLinear"
            "fade, 1, 3.03, quick"
            "layers, 1, 3.81, easeOutQuint"
            "layersIn, 1, 4, easeOutQuint, fade"
            "layersOut, 1, 1.5, linear, fade"
            "fadeLayersIn, 1, 1.79, almostLinear"
            "fadeLayersOut, 1, 1.39, almostLinear"
            "workspaces, 1, 1.94, almostLinear, fade"
            "workspacesIn, 1, 1.21, almostLinear, fade"
            "workspacesOut, 1, 1.94, almostLinear, fade"
          ];
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        master = {
          new_status = "master";
        };

        misc = {
          force_default_wallpaper = -1;
          disable_hyprland_logo = false;
        };

        xwayland = {
          force_zero_scaling = true;
        };

        # Hyprland window rules in NixOS array format
        windowrule = [
          # Fix some dragging issues with XWayland
          "nofocus,class:^$,title:$,xwayland:1,floating:1,fullscreen:0,pinned:0"
        ];

        windowrulev2 = [
          "float, class:^org\.pulseaudio\.pavucontrol$"
          "center, class:^org\.pulseaudio\.pavucontrol$"
          "float, class:^(.*(pwvucontrol).*)$"
          "center, class:^(.*(pwvucontrol).*)$"
          "opacity 1.0 override 1.0 override 1,title:^(.*(Crunchyroll|YouTube|Netflix|Vimeo|Discord).*)$"
          # "opacity 1.0 override 0.90 override 1,class:^([Cc]ode)$"
          "tag +browser, class:^(firefox)$"
          "tag +messaging, class:^(discord)$"
          "tag +messaging, class:^(org.telegram.desktop)$"
          # "tag +games, class:^(steam)$"
          "tag +games, class:^(steam_app_\\d+)$"
          # "workspace 2, class:^(discord)$"
          # "workspace 2, class:^(org.telegram.desktop)$"

          # Game specific rules
          "noblur, tag:games*"
          "fullscreen, tag:games*"
          "workspace special, tag:games*"

          # Float games in special workspace
          "workspace 1, tag:browser*"
          "workspace 2, tag:messaging*"
          "workspace 4, class:^(steam)$"
          "workspace special, tag:games*" # class:^(.*(The Legend of Heroes).*)$

          # Ostensibly this should work but it doesnt seem to
          "pin, stayfocused, 1, class:^(pavucontrol)$"
          "float, class:^(float).*$"
        ];

        layerrule = [
          "blur,wofi"
          "ignorezero,rofi"
          "blur,notifications"
          "ignorezero,notifications"
          "blur,swaync-notification-window"
          "ignorezero,swaync-notification-window"
          "blur,swaync-control-center"
          "ignorezero,swaync-control-center"
          "blur,logout_dialog"
        ];

        gestures = {
          workspace_swipe = true;
        };

        input = {
          kb_layout = "us";
          kb_variant = "";
          kb_model = "";
          kb_rules = "";
          kb_options = "ctrl:nocaps";
          touchpad = {
            clickfinger_behavior = 2;
            natural_scroll = true;
            tap-to-click = true;
            drag_lock = true;
            disable_while_typing = true;
            middle_button_emulation = false;
          };
        };

        bind = [
          ",mouse:274, exec,"
          "$mod, escape, exit"
          "$mod, W, killactive"
          "$mod, Return, exec, $terminal"
          "$mod, E, exec, $fileManager"
          "$mod, V, togglefloating"
          "$mod, P, pseudo"
          "$mod, Slash, togglesplit"
          "$mod, Space, exec, $menu"
          "$mod, Equal, fullscreen"
          "$mod, h, movefocus, l"
          "$mod, j, movefocus, d"
          "$mod, k, movefocus, u"
          "$mod, l, movefocus, r"
          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"
          "$mod SHIFT, h, movewindow, l"
          "$mod SHIFT, j, movewindow, d"
          "$mod SHIFT, k, movewindow, u"
          "$mod SHIFT, l, movewindow, r"
          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"
          "$mod, 6, workspace, 6"
          "$mod, 7, workspace, 7"
          "$mod, 8, workspace, 8"
          "$mod, 9, workspace, 9"
          "$mod, 0, workspace, 10"
          "$mod SHIFT, 1, movetoworkspace, 1"
          "$mod SHIFT, 2, movetoworkspace, 2"
          "$mod SHIFT, 3, movetoworkspace, 3"
          "$mod SHIFT, 4, movetoworkspace, 4"
          "$mod SHIFT, 5, movetoworkspace, 5"
          "$mod SHIFT, 6, movetoworkspace, 6"
          "$mod SHIFT, 7, movetoworkspace, 7"
          "$mod SHIFT, 8, movetoworkspace, 8"
          "$mod SHIFT, 9, movetoworkspace, 9"
          "$mod SHIFT, 0, movetoworkspace, 10"
          "$mod, S, togglespecialworkspace, magic"
          "$mod SHIFT, S, movetoworkspace, special:magic"
          ",Print, exec, grim -g \"$(slurp -w 0)\" - | wl-copy"
        ];

        binde = [
          "$mod, period, resizeactive, 50 0"
          "$mod, comma, resizeactive, -50 0"
          "$mod SHIFT, period, resizeactive, 0 50"
          "$mod SHIFT, comma, resizeactive, 0 -50"
        ];

        bindel = [
          ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
          ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          ",XF86MonBrightnessUp, exec, for i in {1..5}; do brightnessctl -c backlight -q s 1%+; sleep 0.01; done"
          ",XF86MonBrightnessDown, exec, for i in {1..5}; do brightnessctl -c backlight -q s 1%-; sleep 0.01; done"
          ",XF86AudioPlay, exec, playerctl play-pause"
          ",XF86AudioNext, exec, playerctl next"
          ",XF86AudioPrev, exec, playerctl previous"
        ];

        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];
      };
    };
  };
}
