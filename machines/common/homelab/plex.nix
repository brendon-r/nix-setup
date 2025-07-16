{...}: {
  # Holy crap this one was a pain to set up
  # All good?
  networking.nat = {
    enable = true;
    internalInterfaces = ["ve-plex"];
    externalInterface = "eno1"; # your LAN interface
    forwardPorts = [
      {
        sourcePort = 32400;
        proto = "tcp";
        destination = "10.50.0.3:32400";
      }
    ];
  };
  containers.plex = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "10.50.0.1";
    localAddress = "10.50.0.3";
    forwardPorts = [
      {
        containerPort = 32400;
        hostPort = 32400;
      }
    ];
    bindMounts = {
      "/var/lib/plex" = {
        hostPath = "/persistent/plex";
        isReadOnly = false;
      };
      "/media" = {
        hostPath = "/mnt/net-video";
        isReadOnly = true;
      };
    };
    config = {pkgs, ...}: {
      nixpkgs.config.allowUnfree = true;
      networking.firewall = {
        enable = true;
        allowedTCPPorts = [32400];
        allowedUDPPorts = [1900 5353 32410 32412 32413 32414];
      };
      services.plex = {
        enable = true;
        openFirewall = false;
        dataDir = "/var/lib/plex";
      };
      systemd.tmpfiles.rules = [
        "d /var/lib/plex 0755 plex plex -"
      ];
    };
  };
}
