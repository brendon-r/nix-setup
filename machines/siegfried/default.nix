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
    inputs.fw-fanctrl.nixosModules.default

    outputs.nixosModules.berkeley-mono
    outputs.nixosModules.omarchy-config

    ./hardware-configuration.nix
    ../common
    ../../modules/users/henry.nix # Includes home-manager config
  ];

  services.fwupd.enable = true;
  time.timeZone = "America/Chicago";

  # Fan control
  programs.fw-fanctrl.enable = true;

  home-manager.useGlobalPkgs = true;
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
  };

  networking.hostName = "siegfried";
  system.stateVersion = "25.05";
  security.polkit.enable = true;
  boot.loader = {
    timeout = 0;
    efi.canTouchEfiVariables = true;
    systemd-boot = {
      enable = true;
      # configurationLimit = 4;
    };
  };

  nixpkgs = {
    overlays = [
      # outputs.overlays.additions
      # outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
    };
  };

}
