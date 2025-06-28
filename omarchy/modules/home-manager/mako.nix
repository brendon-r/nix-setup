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
      max-icon-size = 32;
      icon-path = "/usr/share/icons/Papirus-Dark";

      # Grouping
      group-by = "app-name";

      # Actions
      actions = true;

      # Format
      format = "<b>%s</b>\\n%b";
      markup = true;

      # Urgency-specific configurations
      "urgency=low" = {
        background-color = theme.surface;
        text-color = theme.text_muted;
        border-color = theme.surface_variant;
        default-timeout = 3000;
      };

      "urgency=normal" = {
        background-color = theme.background;
        text-color = theme.foreground;
        border-color = theme.accent;
        default-timeout = 5000;
      };

      "urgency=high" = {
        background-color = theme.error;
        text-color = theme.background;
        border-color = theme.error;
        default-timeout = 0;
      };

      "category=music" = {
        background-color = theme.secondary;
        text-color = theme.background;
        border-color = theme.secondary;
        default-timeout = 3000;
      };

      "app-name=Spotify" = {
        invisible = 1;
      };

      "app-name=Firefox" = {
        background-color = theme.primary;
        text-color = theme.background;
        border-color = theme.primary;
      };

      "summary~=.*[Bb]attery.*" = {
        background-color = theme.warning;
        text-color = theme.background;
        border-color = theme.warning;
      };

      "summary~=.*[Ee]rror.*" = {
        background-color = theme.error;
        text-color = theme.background;
        border-color = theme.error;
      };

      "summary~=.*[Ss]uccess.*" = {
        background-color = theme.success;
        text-color = theme.background;
        border-color = theme.success;
      };
    };
  };
}
