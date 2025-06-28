{
  config,
  pkgs,
  ...
}: let
  cfg = config.omarchy;
  themes = import ../themes.nix;
  theme = themes.${cfg.theme};
in {
  services.mako = {
    enable = true;

    # All configuration moved to settings
    settings = {
      # Main appearance settings
      background-color = theme.background;
      text-color = theme.foreground;
      border-color = theme.accent;
      progress-color = theme.primary;

      # Dimensions and positioning
      width = 420;
      height = 110;
      padding = "10";
      margin = "10";
      border-size = 2;
      border-radius = 8;

      # Font
      # font = "Liberation Sans 11";

      # Positioning
      anchor = "top-right";
      layer = "overlay";

      # Behavior
      default-timeout = 5000;
      ignore-timeout = false;
      max-visible = 5;
      sort = "-time";

      # Icons
      # max-icon-size = 32;
      # icon-path = "/usr/share/icons/Papirus-Dark";

      # Grouping
      group-by = "app-name";

      # Actions
      actions = true;

      # Format
      format = "<b>%s</b>\\n%b";
      markup = true;
    };
  };
}
