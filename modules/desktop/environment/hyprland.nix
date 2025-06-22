{inputs, ...}: {
  flake.modules.nixos.hyprland = {pkgs, ...}: {
    programs.hyprland.enable = true;
    xdg.portal.enable = true;
    environment.systemPackages = [
      pkgs.quickshell
      # inputs.quickshell.default
    ];
  };

  flake.modules.homeManager.hyprland = {
    pkgs,
    perSystem,
    ...
  }: {
    home.packages = with pkgs; [
      kitty
      wofi
      wl-clipboard
      bibata-cursors
      hyprpaper
    ];
  };
}
