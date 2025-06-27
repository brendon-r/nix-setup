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
  }: let
    lib = nixpkgs.lib;
  in
    lib.makeExtensible (final: {
      # Default configuration
      config = {
        theme = "tokyo-night";
      };
      nixosModules = {
        default = import ./modules/nixos (inputs // {config = final.config;});
        hyprland = import ./modules/nixos/hyprland.nix (inputs // {config = final.config;});
        system = import ./modules/nixos/system.nix;
      };

      homeManagerModules = {
        default = import ./modules/home-manager (inputs // {config = final.config;});
        hyprland = import ./modules/home-manager/hyprland.nix (inputs // {config = final.config;});
        packages = import ./modules/home-manager/packages.nix (inputs // {config = final.config;});
      };

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
    });
}
