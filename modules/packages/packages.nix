{inputs, ...}: {
  flake.modules.nixos.packages = {pkgs, ...}: {
    programs = {
      _1password.enable = true;
      _1password-gui.enable = true;

      # TODO: Dynamically get user names
      _1password-gui.polkitPolicyOwners = ["henry"];

      dconf.enable = true; # Enabled by default in gnome, needed for hyprland
    };

    services.flatpak.enable = true;
    services.upower.enable = true;

    environment.systemPackages = with pkgs; [
      brightnessctl
      btop
      powertop
      cifs-utils
      ffmpeg
      htop
      killall
      neofetch
      pavucontrol

      slurp
      grim

      slack
    ];
  };
}
