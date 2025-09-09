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

    ../../modules/users/brendon.nix
    ./hardware-configuration.nix

    ../common/global.nix
#    ../common/desktop.nix
    ../common/dev.nix
#    ../common/samba.nix

    ../common/packages.nix

    # ../common/gnome
  ];

  home-manager.users.brendon = {
    imports = [
      ../../home/brendon
      inputs.omarchy.homeManagerModules.default
    ];
  };

  environment.systemPackages = [pkgs.filezilla];
  # Fan control
  #programs.fw-fanctrl.enable = true;
  home-manager.useGlobalPkgs = true;
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
  };
  #services.fwupd.enable = true;
  networking.hostName = "xps";
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
}
