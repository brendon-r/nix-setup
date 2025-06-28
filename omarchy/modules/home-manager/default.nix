inputs: {
  config,
  pkgs,
  ...
}: {
  imports = [
    (import ./hyprland.nix inputs)
    (import ./packages.nix)

    (import ./hyprpaper.nix)
    (import ./alacritty.nix)
    (import ./btop.nix)
    (import ./mako.nix)
    (import ./waybar.nix)
    (import ./wofi.nix)
  ];
}
