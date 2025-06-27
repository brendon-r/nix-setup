inputs: {
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;

    imports = [./hyprland/configuration.nix];
    # settings = {
    #   "$mod" = "SUPER";
    #   # Your hyprland config
    # };
  };

  # Hyprland-related packages
  home.packages = with pkgs; [
    alacritty
    nautilus
    chromium
    spotify
    _1password-gui
    signal-desktop
    waybar
    rofi-wayland
  ];
}
