{inputs, ...}: {
  flake.modules.nixos.plasma = {pkgs, ...}: {
    services = {
      desktopManager.plasma6.enable = true;
      displayManager.sddm.enable = true;
      displayManager.sddm.wayland.enable = true;
    };

    environment.systemPackages = with pkgs; [
      kdePackages.discover # Optional: Install if you use Flatpak or fwupd firmware update sevice
      kdePackages.kcalc # Calculator
      kdePackages.kcharselect # Tool to select and copy special characters from all installed fonts
      kdePackages.kcolorchooser # A small utility to select a color
      kdePackages.kolourpaint # Easy-to-use paint program
      kdePackages.ksystemlog # KDE SystemLog Application
      kdePackages.sddm-kcm # Configuration module for SDDM
      kdiff3 # Compares and merges 2 or 3 files or directories
      kdePackages.isoimagewriter # Optional: Program to write hybrid ISO files onto USB disks
      kdePackages.partitionmanager # Optional Manage the disk devices, partitions and file systems on your computer
      hardinfo2 # System information and benchmarks for Linux systems
      haruna # Open source video player built with Qt/QML and libmpv
      wayland-utils # Wayland utilities
      wl-clipboard # Command-line copy/paste utilities for Wayland
    ];
  };

  flake.modules.homeManager.plasma = {pkgs, ...}: {
    #     imports = [ inputs.plasma-manager.homeManagerModules.plasma-manager ];

    #     progams.plasma = {
    #       enable = true;
    #       shortcuts = {
    #         kwin = {
    #           "Expose" = "Meta";
    #           "Switch to Desktop 2" = "Meta+2";
    # #       Switch to Desktop 3=Meta+3,Meta+3,Switch to Desktop 3
    # #       Switch to Desktop 1=Meta+1,Meta+1,Switch to Desktop 1
    # #       Switch to Desktop 4=Meta+4,Meta+4,Switch to Desktop 4
    # #       Switch to Desktop 5=Meta+5,Meta+5,Switch to Desktop 5
    # #       Window to Desktop 1=Meta+Shift+1,Meta+Shift+1,Window to Desktop 1
    # #       Window to Desktop 2=Meta+Shift+2,Meta+Shift+2,Window to Desktop 2
    # #       Window to Desktop 3=Meta+Shift+3,Meta+Shift+3,Window to Desktop 3
    # #       Window to Desktop 4=Meta+Shift+4,Meta+Shift+4,Window to Desktop 4
    # #       Window to Desktop 5=Meta+Shift+5,Meta+Shift+5,Window to Desktop 5
    #         };
    #       };
    #     };
  };
}
