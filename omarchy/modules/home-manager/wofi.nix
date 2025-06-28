{
  config,
  pkgs,
  ...
}: let
  cfg = config.omarchy;
  themes = import ../themes.nix;
  theme = themes.${cfg.theme};
in {
  home.file = {
    ".config/wofi/style.css" = {
      text = ''
        * {
          font-family: "Liberation Sans", sans-serif;
          font-size: 14px;
        }

        window {
          margin: 0px;
          border: 2px solid ${theme.border};
          background-color: ${theme.background};
          border-radius: 8px;
        }

        #input {
          margin: 5px;
          border: none;
          color: ${theme.foreground};
          background-color: ${theme.surface};
          border-radius: 4px;
          padding: 8px;
        }

        #inner-box {
          margin: 5px;
          border: none;
          background-color: ${theme.background};
        }

        #outer-box {
          margin: 5px;
          border: none;
          background-color: ${theme.background};
        }

        #scroll {
          margin: 0px;
          border: none;
        }

        #text {
          margin: 5px;
          border: none;
          color: ${theme.foreground};
        }

        #entry {
          background-color: ${theme.background};
          border-radius: 4px;
          margin: 2px;
          padding: 8px;
        }

        #entry:selected {
          background-color: ${theme.primary};
          color: ${theme.background};
        }

        #entry:hover {
          background-color: ${theme.surface};
        }
      '';
    };
  };

  programs.wofi = {
    enable = true;
    settings = {
      width = 600;
      height = 350;
      location = "center";
      show = "drun";
      prompt = "Search...";
      filter_rate = 100;
      allow_markup = true;
      no_actions = true;
      halign = "fill";
      orientation = "vertical";
      content_halign = "fill";
      insensitive = true;
      allow_images = true;
      image_size = 40;
      gtk_dark = true;
    };
  };
}
