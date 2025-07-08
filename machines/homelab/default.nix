{
  inputs,
  modulesPath,
  ...
}: {
  imports = [
    # inputs.disko.nixosModules.disko
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./hardware-configuration.nix
    ./disk-config.nix

    ../../modules/users/henry.nix 

    ../common/global.nix
    ../common/homelab.nix

  ];

  networking.hostName = "homelab-1";
  security.polkit.enable = true;
  boot.loader = {
    timeout = 5;
    efi.canTouchEfiVariables = true;
    systemd-boot = {
      enable = true;
    };
  };
  system.stateVersion = "25.05";
}
