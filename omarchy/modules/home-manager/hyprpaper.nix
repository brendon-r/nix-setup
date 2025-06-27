{
  config,
  pkgs,
  ...
}: let
  cfg = config.omarchy;
  wallpapers = {
    "tokyo-night" = [
      "1-Pawel-Czerwinski-Abstract-Purple-Blue.jpg"
    ];
    "kanagawa" = [
      "kanagawa-1.png"
    ];
    "everforest" = [
      "1-everforest.jpg"
    ];
  };

  # Safe access with fallback
  selected_wallpaper = builtins.elemAt (wallpapers.${cfg.theme}) 0;
  selected_wallpaper_path = "~/Pictures/Wallpapers/${selected_wallpaper}";
in {
  home.file = {
    "Pictures/Wallpapers" = {
      source = ../../config/themes/${cfg.theme}/wallpapers;
      recursive = true;
    };
  };
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        selected_wallpaper_path
      ];
      wallpaper = [
        "eDP-1,${selected_wallpaper_path}"
      ];
    };
  };
}
