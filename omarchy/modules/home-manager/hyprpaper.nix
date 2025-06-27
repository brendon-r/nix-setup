{
  config,
  pkgs,
  ...
}: let
  wallpapers = {
    "tokyo-night" = [
      "tokyo-night/1-Pawel-Czerwinski-Abstract-Purple-Blue.jpg"
    ];
  };

  # Safe access with fallback
  theme = config.theme or "tokyo-night";
  themeWallpapers = wallpapers.${theme} or wallpapers."tokyo-night";
  selected_wallpaper = builtins.elemAt themeWallpapers 0;
  selected_wallpaper_path = "~/Pictures/Wallpapers/${theme}/${selected_wallpaper}";
in {

  home.file = {
    "Pictures/Wallpapers" = {
      source = ../../config/wallpaper;
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
