{inputs, ...}: {
  flake.modules.homeManager.hyprland = {
    pkgs,
    perSystem,
    ...
  }: let
    wallpaper = "~/Pictures/Wallpapers/mountains.jpg";
  in {
    home.file = {
      "Pictures/Wallpapers" = {
        source = ../../../../config/wallpaper;
        recursive = true;
      };
    };

    services.hyprpaper = {
      enable = true;
      settings = {
        preload = [
          wallpaper
        ];
        wallpaper = [
          "eDP-1,${wallpaper}"
        ];
      };
    };
  };
}
