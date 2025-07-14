{
  pkgs,
  inputs,
  outputs,
  modulesPath,
  ...
}: {
  imports = [
    inputs.sipp-family.nixosModules.default

    # inputs.disko.nixosModules.disko
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./hardware-configuration.nix
    ./disk-config.nix

    ../../modules/users/henry.nix

    ../common/global.nix
    ../common/dev.nix
    ../common/samba.nix

    # Services
    ../common/homelab/nginx.nix
    ../common/homelab/homelab.nix
    ../common/homelab/home-assistant.nix
    ../common/homelab/nextcloud.nix
    ../common/homelab/immich.nix
    ../common/homelab/plex.nix
  ];

  networking.firewall.allowedTCPPorts = [8123 3000];

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

  services.sippFamily = {
    enable = true;
    port = 3000;
  };
}
