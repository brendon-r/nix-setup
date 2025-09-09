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
  
  omarchy.monitors = [
    "eDP-1, 1920x1080@59.93400, 0x0, 1.25"
  ];
  environment.systemPackages = [pkgs.filezilla];

  # Fan control
  #programs.fw-fanctrl.enable = true;
  programs.regreet.enable = true;

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
