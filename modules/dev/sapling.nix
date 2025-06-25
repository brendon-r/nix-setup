{...}: {
  flake.modules.nixos.dev = {pkgs, ...}: {
    environment.systemPackages = [
      pkgs.sapling
    ];
  };
  flake.modules.homeManager.dev = {
  };
}
