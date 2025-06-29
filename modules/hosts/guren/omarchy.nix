{
  inputs,
  config,
  ...
}: {
  flake.modules.hosts.guren = {pkgs, ...}: {
    omarchy = {
      full_name = "Henry Sipp";
      email_address = "hesipp@gmail.com";
      theme = "tokyo-night";
      primary_font = "Berkeley Mono";
      vscode_settings = {
        "editor.fontFamily" = "Berkeley Mono";
      };
      quick_app_bindings = [
        "SUPER, A, exec, $webapp=https://claude.ai"
        "SUPER, C, exec, $webapp=https://app.hey.com/calendar/weeks/"
        "SUPER, E, exec, $webapp=https://app.hey.com"
        "SUPER, Y, exec, $webapp=https://youtube.com/"
        "SUPER SHIFT, G, exec, $webapp=https://web.whatsapp.com/"
        "SUPER, X, exec, $webapp=https://x.com/"
        "SUPER SHIFT, X, exec, $webapp=https://x.com/compose/post"

        "SUPER, return, exec, $terminal"
        "SUPER, F, exec, $fileManager"
        "SUPER, B, exec, $browser"
        "SUPER, M, exec, $music"
        "SUPER, N, exec, $terminal -e nvim"
        "SUPER, T, exec, $terminal -e btop"
        "SUPER, D, exec, $terminal -e lazydocker"
        "SUPER, G, exec, $messenger"
        "SUPER, O, exec, obsidian -disable-gpu"
        "SUPER, slash, exec, $passwordManager"
      ];
    };

    home-manager.users.henry = {
      wayland.windowManager.hyprland.settings = {
        "$terminal" = "alacritty";
        "$fileManager" = "nautilus --new-window";
        "$browser" = "chromium --new-window --ozone-platform=wayland";
        "$music" = "spotify";
        "$passwordManager" = "1password";
        "$messenger" = "telegram-desktop";
        "$webapp" = "$browser --app";

        input = {
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
        gestures = {
          workspace_swipe = true;
        };
        bind = [
          ",mouse:274, exec,"
        ];
      };
    };
  };

  flake.modules.homeManager.base = {};
}
