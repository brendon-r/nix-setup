{pkgs, ...}: {
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
}
