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
        full_name = lib.mkOption {
          type = lib.types.str;
          description = "Main user's full name";
        };
        email_address = lib.mkOption {
          type = lib.types.str;
          description = "Main user's email address";
        };
        theme = lib.mkOption {
          type = lib.types.enum ["tokyo-night" "kanagawa" "catppuccin"];
          default = "tokyo-night";
          description = "Theme to use for Omarchy configuration";
        };
        primary_font = lib.mkOption {
          type = lib.types.str;
          default = "Liberation Sans 11";
        };
        vscode_settings = lib.mkOption {
          type = lib.types.attrs;
          default = {};
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
      osConfig ? {},
      ...
    }: {
      # Import your other modules at the top level
      imports = [
        (import ./modules/home-manager/default.nix inputs)
      ];

      # Define the same options as the NixOS module
      options.omarchy = {
        full_name = lib.mkOption {
          type = lib.types.str;
          description = "Main user's full name";
        };
        email_address = lib.mkOption {
          type = lib.types.str;
          description = "Main user's email address";
        };
        theme = lib.mkOption {
          type = lib.types.enum ["tokyo-night" "kanagawa" "catppuccin"];
          default = "tokyo-night";
          description = "Theme to use for Omarchy configuration";
        };
        primary_font = lib.mkOption {
          type = lib.types.str;
          default = "Liberation Sans 11";
        };
        vscode_settings = lib.mkOption {
          type = lib.types.attrs;
          default = {};
        };
      };

      # Automatically inherit config from NixOS when available
      config = lib.mkIf (osConfig ? omarchy) {
        omarchy = osConfig.omarchy;
      };
    };
  in {
    flakeModules = {
      modules = omarchyModule;
      home-manager = omarchyHomeModule;
    };
  };
}
