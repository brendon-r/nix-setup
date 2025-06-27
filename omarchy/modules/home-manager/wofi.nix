{
  config,
  pkgs,
  ...
}: {
  home.file = {
    "~/.config/wofi/" = {
      source = ../../config/wofi;
      recursive = true;
    };
  };
  programs.wofi.enable = true;
}
