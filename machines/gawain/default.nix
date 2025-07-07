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
    outputs.nixosModules.berkeley-mono
    outputs.nixosModules.omarchy-config

    ./hardware-configuration.nix
    ../../modules/users/henry.nix # Includes home-manager config
    ../common
    ../common/gaming.nix
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "backup";
  home-manager.extraSpecialArgs = { inherit inputs outputs; };

  boot.loader = {
    timeout = 0;
    efi.canTouchEfiVariables = true;
    systemd-boot = {
      enable = true;
      # configurationLimit = 4;
    };
  };

  omarchy.monitors = [
    "DP-1, 3840x2160@240, 0x0, 1.5" 
  ];

  networking.hostName = "gawain";
  system.stateVersion = "25.05";

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = true;
    nvidiaSettings = true;
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics.enable = true;
  services.samba.enable = true;

}
