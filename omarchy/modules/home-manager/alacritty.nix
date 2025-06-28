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
          family = "Berkeley Mono";
          style = "Regular";
        };
        bold = {
          family = "Berkeley Mono";
          style = "Bold";
        };
        italic = {
          family = "Berkeley Mono";
          style = "Italic";
        };
        bold_italic = {
          family = "Berkeley Mono";
          style = "Bold Italic";
        };
        size = 11.0;
      };

      # Colors
      colors = {
        primary = {
          background = theme.background;
          foreground = theme.foreground;
          dim_foreground = theme.text_muted;
          bright_foreground = theme.foreground;
        };

        cursor = {
          text = theme.background;
          cursor = theme.accent;
        };

        vi_mode_cursor = {
          text = theme.background;
          cursor = theme.secondary;
        };

        search = {
          matches = {
            foreground = theme.background;
            background = theme.warning;
          };
          focused_match = {
            foreground = theme.background;
            background = theme.success;
          };
        };

        footer_bar = {
          foreground = theme.background;
          background = theme.surface_variant;
        };

        hints = {
          start = {
            foreground = theme.background;
            background = theme.warning;
          };
          end = {
            foreground = theme.background;
            background = theme.surface_variant;
          };
        };

        selection = {
          text = theme.background;
          background = theme.selection;
        };

        normal = {
          black = theme.black;
          red = theme.red;
          green = theme.green;
          yellow = theme.yellow;
          blue = theme.blue;
          magenta = theme.magenta;
          cyan = theme.cyan;
          white = theme.white;
        };

        bright = {
          black = theme.bright_black;
          red = theme.bright_red;
          green = theme.bright_green;
          yellow = theme.bright_yellow;
          blue = theme.bright_blue;
          magenta = theme.bright_magenta;
          cyan = theme.bright_cyan;
          white = theme.bright_white;
        };

        dim = {
          black = theme.black;
          red = theme.red;
          green = theme.green;
          yellow = theme.yellow;
          blue = theme.blue;
          magenta = theme.magenta;
          cyan = theme.cyan;
          white = theme.white;
        };
      } // (if theme ? orange then {
        indexed_colors = [
          { index = 16; color = theme.orange; }
        ] ++ (if theme ? rosewater then [
          { index = 17; color = theme.rosewater; }
        ] else []) ++ (if theme ? peach then [
          { index = 18; color = theme.peach; }
        ] else []);
      } else {});

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
        args = [ "--login" ];
      };

      # Working directory
      working_directory = "None";

      # Alt as Esc
      alt_send_esc = true;

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
