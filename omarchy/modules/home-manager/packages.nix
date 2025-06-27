{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    firefox
    git
    vim
  ];

  # programs.git = {
  #   enable = true;
  #   userName = "Default User";
  #   userEmail = "user@example.com";
  # };
}
