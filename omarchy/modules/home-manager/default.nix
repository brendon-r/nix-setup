inputs: {
  config,
  pkgs,
  ...
}: {
  imports = [
    (import ./hyprland.nix inputs)
    (import ./hyprpaper.nix)
    (import ./waybar.nix)
    (import ./packages.nix)
  ];
}
