inputs: {
  config,
  pkgs,
  ...
}: let
  packages = import ../packages.nix {inherit pkgs;};
in {
  imports = [
    (import ./hyprland.nix inputs)
    (import ./hyprpaper.nix)
    # (import ./hyprlock.nix)
    (import ./alacritty.nix)
    (import ./btop.nix)
    (import ./direnv.nix)
    (import ./git.nix)
    (import ./mako.nix)
    (import ./starship.nix)
    (import ./vscode.nix)
    (import ./waybar.nix)
    (import ./wofi.nix)
    (import ./zoxide.nix)
    (import ./zsh.nix)
  ];

  home.packages = packages.homePackages;

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };
}
