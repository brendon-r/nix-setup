{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.default
    inputs.nixos-hardware.nixosModules.framework-amd-ai-300-series

    outputs.nixosModules.berkeley-mono
    outputs.nixosModules.omarchy-config

    ../../modules/users/henry.nix # Includes home-manager config
    ./hardware-configuration.nix
  ];

  environment.systemPackages = [
    pkgs.unstable.claude-code 
    pkgs.discord
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
  };

  boot.loader = {
    timeout = 0;
    efi.canTouchEfiVariables = true;
    systemd-boot = {
      enable = true;
      # configurationLimit = 4;
    };
  };

  nixpkgs = {
    overlays = [];
    config = {
      allowUnfree = true;
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      experimental-features = "nix-command flakes";
    };
  };

  networking.hostName = "siegfried";
  system.stateVersion = "25.05";
}
