{
  description = "Henry's Nix Config";
  inputs = {
    ags.url = "github:Aylur/ags";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";

    # Fix: Use release-25.05 branch for Home Manager to match Nixpkgs
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    import-tree.url = "github:vic/import-tree";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    nix-webapps.url = "github:TLATER/nix-webapps";

    # Keep using stable 25.05 as your baseyourhostname
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    systems.url = "github:nix-systems/default";

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    omarchy.url = "github:henrysipp/omarchy-nix";
    omarchy.inputs.nixpkgs.follows = "nixpkgs";
    omarchy.inputs.home-manager.follows = "home-manager";
  };
  outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} (inputs.import-tree ./modules);
  nixConfig = {
    experimental-features = ["nix-command" "flakes"];
    allow-unfree = true;
  };
}
