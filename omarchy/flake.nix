{
  description = "Omarchy - Base configuration flake";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    hyprland,
    home-manager,
  }: {
    flakeModules = {
      nixos = {
        default = self.nixosModules.default;
        hyprland = self.nixosModules.hyprland;
        system = self.nixosModules.system;
      };
      homeManager = {
        default = self.homeManagerModules.default;
        hyprland = self.homeManagerModules.hyprland;
        packages = self.homeManagerModules.packages;
      };
    };
  };
}