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
    };

    home-manager.users.henry = {
      wayland.windowManager.hyprland.settings = {
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
