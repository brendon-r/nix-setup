{inputs, ...}: {
  flake.modules.homeManager.hyprland = {
    pkgs,
    perSystem,
    ...
  }: {
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
          "~/Pictures/Wallpapers/regolith_2.jpg"
        ];
        wallpaper = [
          "eDP-1,~/Pictures/Wallpapers/regolith_2.jpg"
        ];
      };
    };
  };
}
