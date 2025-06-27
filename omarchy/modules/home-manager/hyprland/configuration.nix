{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./autostart.nix
    ./bindings.nix
    ./envs.nix
    ./looknfeel.nix
    ./windows.nix
  ];
  wayland.windowManager.hyprland.settings = {
    # Default applications
    "$terminal" = "alacritty";
    "$fileManager" = "nautilus --new-window";
    "$browser" = "chromium --new-window --ozone-platform=wayland";
    "$music" = "spotify";
    "$passwordManager" = "1password";
    "$messenger" = "signal-desktop";
    "$webapp" = "$browser --app";

    # Environment variables
    env = [
      "GDK_SCALE,2" # Change to 1 if on a 1x display
      # Uncomment if running NVIDIA GPU:
      # "NVD_BACKEND,direct"
      # "LIBVA_DRIVER_NAME,nvidia"
      # "__GLX_VENDOR_LIBRARY_NAME,nvidia"
    ];

    # Extra bindings
    bind = [
      "SUPER, A, exec, $webapp=https://chatgpt.com"
      "SUPER SHIFT, A, exec, $webapp=https://grok.com"
      "SUPER, C, exec, $webapp=https://app.hey.com/calendar/weeks/"
      "SUPER, E, exec, $webapp=https://app.hey.com"
      "SUPER, Y, exec, $webapp=https://youtube.com/"
      "SUPER SHIFT, G, exec, $webapp=https://web.whatsapp.com/"
      "SUPER, X, exec, $webapp=https://x.com/"
      "SUPER SHIFT, X, exec, $webapp=https://x.com/compose/post"
    ];
  };
}
