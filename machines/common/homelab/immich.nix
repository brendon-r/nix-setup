{ config, pkgs, ... }: {
  containers.immich = {
    autoStart = true;
     
    bindMounts = {
      "/var/lib" = {
        hostPath = "/persistent/immich";
        isReadOnly = false;
      };
      "/mnt/net-photo/immich" = {
        hostPath = "/mnt/net-photo/immich";
        isReadOnly = false;
      };
    };
    
    config = { config, pkgs, ... }: {
      services.immich = {
        enable = true;
        port = 2283;
        mediaLocation = "/mnt/net-photo/immich";
      };
      
      networking.firewall.allowedTCPPorts = [ 2283 ];
      
      system.stateVersion = "25.05";
    };
  };
}