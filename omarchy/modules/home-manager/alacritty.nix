{
  config,
  pkgs,
  ...
}: let
  cfg = config.omarchy;
  themes = import ../themes.nix;
  theme = themes.${cfg.theme};
in {
  programs.alacritty = {
    enable = true;
    settings = {
      # Window settings
      window = {
        padding = {
          x = 10;
          y = 10;
        };
        dynamic_padding = true;
        decorations = "none";
        opacity = 0.95;
        blur = true;
        startup_mode = "Windowed";
        title = "Alacritty";
        dynamic_title = true;
      };

      # Scrolling
      scrolling = {
        history = 10000;
        multiplier = 3;
      };

      # Font configuration
      font = {
        normal = {
          family = cfg.primary_font;
          style = "Regular";
        };
        bold = {
          family = cfg.primary_font;
          style = "Bold";
        };
        italic = {
          family = cfg.primary_font;
          style = "Italic";
        };
        bold_italic = {
          family = cfg.primary_font;
          style = "Bold Italic";
        };
        size = 11.0;
      };

      # Colors
      colors = {
        primary.background = theme.background;
        primary.foreground = theme.foreground;

        normal.black = theme.black;
        normal.red = theme.red;
        normal.green = theme.green;
        normal.yellow = theme.yellow;
        normal.blue = theme.blue;
        normal.magenta = theme.magenta;
        normal.cyan = theme.cyan;
        normal.white = theme.white;

        bright.black = theme.bright_black;
        bright.red = theme.bright_red;
        bright.green = theme.bright_green;
        bright.yellow = theme.bright_yellow;
        bright.blue = theme.bright_blue;
        bright.magenta = theme.bright_magenta;
        bright.cyan = theme.bright_cyan;
        bright.white = theme.bright_white;

        selection.background = theme.primary;
      };
      # // (
      #   if theme ? orange
      #   then {
      #     indexed_colors =
      #       [
      #         {
      #           index = 16;
      #           color = theme.orange;
      #         }
      #       ]
      #       ++ (
      #         if theme ? rosewater
      #         then [
      #           {
      #             index = 17;
      #             color = theme.rosewater;
      #           }
      #         ]
      #         else []
      #       )
      #       ++ (
      #         if theme ? peach
      #         then [
      #           {
      #             index = 18;
      #             color = theme.peach;
      #           }
      #         ]
      #         else []
      #       );
      #   }
      #   else {}
      # );

      # Bell
      bell = {
        animation = "EaseOutExpo";
        duration = 0;
        color = theme.warning;
      };

      # Mouse
      mouse = {
        hide_when_typing = true;
        bindings = [
          {
            mouse = "Middle";
            action = "PasteSelection";
          }
        ];
      };

      # Key bindings
      keyboard.bindings = [
        # Copy/Paste
        {
          key = "C";
          mods = "Control|Shift";
          action = "Copy";
        }
        {
          key = "V";
          mods = "Control|Shift";
          action = "Paste";
        }
        # Search
        {
          key = "F";
          mods = "Control|Shift";
          action = "SearchForward";
        }
        {
          key = "B";
          mods = "Control|Shift";
          action = "SearchBackward";
        }
        # Font size
        {
          key = "Plus";
          mods = "Control";
          action = "IncreaseFontSize";
        }
        {
          key = "Minus";
          mods = "Control";
          action = "DecreaseFontSize";
        }
        {
          key = "Key0";
          mods = "Control";
          action = "ResetFontSize";
        }
        # New window
        {
          key = "Return";
          mods = "Control|Shift";
          action = "SpawnNewInstance";
        }
      ];

      # Cursor
      cursor = {
        style = {
          shape = "Block";
          blinking = "Off";
        };
        unfocused_hollow = true;
        thickness = 0.15;
      };

      # Live config reload
      general.live_config_reload = true;

      # Shell
      terminal.shell = {
        program = "${pkgs.zsh}/bin/zsh";
        args = ["--login"];
      };

      # Working directory
      working_directory = "None";

      # Debug
      debug = {
        render_timer = false;
        persistent_logging = false;
        log_level = "Warn";
        print_events = false;
      };
    };
  };
}
