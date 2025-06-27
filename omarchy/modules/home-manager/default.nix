inputs: {
  config,
  pkgs,
  ...
}: {
  imports = [
    (import ./hyprland.nix inputs)
    (import ./packages.nix)

    (import ./hyprpaper.nix)
    (import ./waybar.nix)
    (import ./wofi.nix)
  ];
}
