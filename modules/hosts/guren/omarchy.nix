{
  inputs,
  config,
  ...
}: {
  flake.modules.hosts.guren = {pkgs, ...}: {
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
      };
    };
  };

  flake.modules.homeManager.base = {
    omarchy = {
      theme = "tokyo-night";
    };
  };
}
