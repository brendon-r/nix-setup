{inputs, ...}: {
  config,
  pkgs,
  ...
}: let
  cfg = config.omarchy;
  themes = import ../themes.nix;
  theme = themes.${cfg.theme};
  rgba = inputs.nix-colors.lib.hexToRgba "#3c3836";
in {
  programs.hyprlock = {
    enable = true;
    settings = {
      source = "colors.conf";
      general = {
        disable_loading_bar = true;
        no_fade_in = false;
      };
      auth = {
        fingerprint.enabled = true;
      };
      background = {
        monitor = "";
        color = rgba; # You can now use the rgba value here
      };
    };
  };
}
