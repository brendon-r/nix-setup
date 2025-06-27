{inputs, ...}: {
  flake.modules.homeManager.hyprland = {
    pkgs,
    perSystem,
    ...
  }: {
    services.hyprsunset.enable = true;
  };
}
