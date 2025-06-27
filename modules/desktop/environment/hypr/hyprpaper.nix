{inputs, ...}: {
  flake.modules.homeManager.hyprland = {
    pkgs,
    perSystem,
    ...
  }: let
    wallpaper = "~/Pictures/Wallpapers/mountains.jpg";
  in {
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
