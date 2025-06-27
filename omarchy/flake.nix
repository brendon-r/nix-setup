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

  outputs = {
    self,
    nixpkgs,
    home-manager,
    hyprland,
    ...
  } @ inputs: let
    # Your main NixOS configuration module
    omarchyModule = {
      config,
      lib,
      pkgs,
      ...
    }: {
      # Import your other modules at the top level
      imports = [
        (import ./modules/nixos/default.nix inputs)
      ];

      # nixpkgs.overlays = [
      #   nix-vscode-extensions.overlays.default
      # ];

      # Your options
      options.omarchy = {
        theme = lib.mkOption {
          type = lib.types.enum ["tokyo-night" "kanagawa" "catppuccin"];
          default = "tokyo-night";
          description = "Theme to use for Omarchy configuration";
        };
      };

      # Configuration
      config = {
        # Allow unfree packages
        nixpkgs.config.allowUnfree = true;
      };
    };

    # Your main Home Manager configuration module
    omarchyHomeModule = {
      config,
      lib,
      pkgs,
      ...
    }: {
      # Import your other modules at the top level
      imports = [
        (import ./modules/home-manager/default.nix inputs)
      ];

      # Your home manager options
      options.omarchy = {
        theme = lib.mkOption {
          type = lib.types.enum ["tokyo-night" "kanagawa" "everforest"];
          default = "tokyo-night";
          description = "Theme to use for Omarchy configuration";
        };
      };
    };
  in {
    # Export your modules for others to use
    nixosModules = {
      default = omarchyModule;
      omarchy = omarchyModule;
    };

    homeManagerModules = {
      default = omarchyHomeModule;
      omarchy = omarchyHomeModule;
    };
  };
}
