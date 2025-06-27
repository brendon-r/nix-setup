inputs: {
  config,
  pkgs,
  ...
}: {
  imports = [
    (import ./hyprland.nix inputs)
    (import ./packages.nix)
  ];
}
