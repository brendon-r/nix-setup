{config, ...}: let
  cfg = config.omarchy;
in {
  programs.git = {
    enable = true;
    userName = cfg.full_name;
    userEmail = cfg.email_address;
  };
}
