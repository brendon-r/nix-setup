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
    ../common/homelab.nix

  ];

  services.home-assistant = {
    enable = true;

    package = pkgs.unstable.home-assistant;
    # opt-out from declarative configuration management
    config = null;
    lovelaceConfig = null;
    # configure the path to your config directory
    configDir = "/etc/home-assistant";
    # specify list of components required by your configuration
    extraComponents = [
      "backup"
      "default_config"
      # "esphome"
      # "met"
      # "radio_browser"

      "lifx"
      "homekit"
      "homekit_controller"
      "shelly"
      "bluetooth"
    ];
  };
  networking.firewall.allowedTCPPorts = [ 8123 ];

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
