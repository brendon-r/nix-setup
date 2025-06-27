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
    # NixOS modules (standard flake output)
    nixosModules = {
      default = import ./modules/nixos inputs;
      hyprland = import ./modules/nixos/hyprland.nix inputs;
      system = import ./modules/nixos/system.nix;
    };

    # Home Manager modules (standard flake output)
    homeManagerModules = {
      default = import ./modules/home-manager inputs;
      hyprland = import ./modules/home-manager/hyprland.nix inputs;
      packages = import ./modules/home-manager/packages.nix;
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
  };
}
