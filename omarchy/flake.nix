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
  in {
    # NixOS modules with options
    nixosModules = {
      default = import ./modules/nixos inputs;
      hyprland = import ./modules/nixos/hyprland.nix inputs;
      system = import ./modules/nixos/system.nix;

      # Main options module
      options = {
        config,
        lib,
        pkgs,
        ...
      }: {
        options.omarchy = {
          theme = lib.mkOption {
            type = lib.types.enum ["tokyo-night" "kanagawa" "catppuccin"];
            default = "tokyo-night";
            description = "Theme to use for Omarchy configuration";
          };

          enable = lib.mkOption {
            type = lib.types.bool;
            default = true;
            description = "Whether to enable Omarchy configuration";
          };
        };
      };
    };

    # Home Manager modules with options
    homeManagerModules = {
      default = import ./modules/home-manager inputs;
      hyprland = import ./modules/home-manager/hyprland.nix inputs;
      packages = import ./modules/home-manager/packages.nix inputs;

      # Main options module
      options = {
        config,
        lib,
        pkgs,
        ...
      }: {
        options.omarchy = {
          theme = lib.mkOption {
            type = lib.types.enum ["tokyo-night" "kanagawa" "everforest"];
            default = "tokyo-night";
            description = "Theme to use for Omarchy configuration";
          };
        };
      };
    };

    flakeModules = {
      nixos = {
        default = self.nixosModules.default;
        hyprland = self.nixosModules.hyprland;
        system = self.nixosModules.system;
        options = self.nixosModules.options;
      };
      homeManager = {
        default = self.homeManagerModules.default;
        hyprland = self.homeManagerModules.hyprland;
        packages = self.homeManagerModules.packages;
        options = self.homeManagerModules.options;
      };
    };
  };
}
