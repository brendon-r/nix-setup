{
  config,
  pkgs,
  ...
}: let
  cfg = config.omarchy;
in {
  home.file = {
    ".config/wofi/" = {
      source = ../../config/wofi;
      recursive = true;
    };
    ".config/wofi/wofi.css" = {
      source = ../../config/themes/${cfg.theme}/wofi.css;
    };
  };
  programs.wofi.enable = true;
}
