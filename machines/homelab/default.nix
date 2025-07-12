{
  pkgs,
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
    ../common/nginx.nix
    ../common/homelab.nix
    ../common/home-assistant.nix
    ../common/samba.nix
    ../common/nextcloud.nix
  ];

  networking.firewall.allowedTCPPorts = [8123];

  services.plex = {
    enable = true;
    openFirewall = true;
  };

  services.roon-server = {
    enable = true;
    openFirewall = true;
  };

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
