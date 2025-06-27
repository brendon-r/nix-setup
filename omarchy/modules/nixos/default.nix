inputs: {
  config,
  pkgs,
  ...
}: {
  imports = [
    (import ./hyprland.nix inputs)
    (import ./system.nix)
  ];
}
