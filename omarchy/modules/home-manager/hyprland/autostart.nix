{
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "hypridle & mako & waybar & fcitx5"
      # "swaybg -i ~/.config/omarchy/current/background -m fill"
      "systemctl --user start hyprpolkitagent"
      "wl-clip-persist --clipboard regular & clipse -listen"

      # "dropbox-cli start"  # Uncomment to run Dropbox
    ];
  };
}
