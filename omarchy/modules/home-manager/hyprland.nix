inputs: {
  config,
  pkgs,
  ...
}: {
  imports = [./hyprland/configuration.nix];
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;

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
    # signal-desktop
  ];
}
