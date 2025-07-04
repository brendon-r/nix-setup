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

    ../../modules/users/henry.nix # Includes home-manager config
    ./hardware-configuration.nix
  ];

  environment.systemPackages = [
    pkgs.unstable.claude-code 
    pkgs.discord
  ];

  time.timeZone = "America/Chicago";
  home-manager.useGlobalPkgs = true;
  home-manager.extraSpecialArgs = { inherit inputs outputs; };

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

  nix.settings.experimental-features = "nix-command flakes";

  networking.hostName = "gawain";
  system.stateVersion = "25.05";
}
