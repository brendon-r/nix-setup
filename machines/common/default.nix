{pkgs, ...}: {
  services.tailscale.enable = true;

  environment.systemPackages = [
    pkgs.unstable.claude-code
    pkgs.discord
    pkgs.obs-studio
    pkgs.tdesktop
  ];

  programs.obs-studio = {
    enable = true;
    enableVirtualCamera = true;

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi #optional AMD hardware acceleration
      obs-gstreamer
      obs-vkcapture
    ];
  };

  # virtualisation.virtualbox.host.enable = true;
  # users.extraGroups.vboxusers.members = [ "henry" ];

  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["henry"];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
}
