{
  config,
  lib,
  pkgs,
  ...
}: {
  options.plex = {
    enable = lib.mkEnableOption "Plex media server";

    subDomainName = lib.mkOption {
      type = lib.types.str;
      default = "plex";
      description = "Subdomain for Plex service";
    };

    baseDomainName = lib.mkOption {
      type = lib.types.str;
      default = "sipp.family";
      description = "Base domain name for Plex service";
    };
  };

  config = lib.mkIf config.plex.enable {
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
        {
          containerPort = 1900;
          hostPort = 1900;
          protocol = "udp";
        }
        {
          containerPort = 5353;
          hostPort = 5353;
          protocol = "udp";
        }
        {
          containerPort = 32410;
          hostPort = 32410;
          protocol = "udp";
        }
        {
          containerPort = 32412;
          hostPort = 32412;
          protocol = "udp";
        }
        {
          containerPort = 32413;
          hostPort = 32413;
          protocol = "udp";
        }
        {
          containerPort = 32414;
          hostPort = 32414;
          protocol = "udp";
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
          openFirewall = true;
          dataDir = "/var/lib/plex";
        };
        systemd.tmpfiles.rules = [
          "d /var/lib/plex 0755 plex plex -"
        ];
      };
    };

    services.nginx.virtualHosts."${config.plex.subDomainName}.${config.plex.baseDomainName}" = {
      serverName = "${config.plex.subDomainName}.${config.plex.baseDomainName}";
      forceSSL = true;
      useACMEHost = config.plex.baseDomainName;
      locations."/" = {
        proxyPass = "http://10.50.0.3:32400";
        proxyWebsockets = true;
        extraConfig = ''
          # Plex specific headers
          proxy_set_header X-Plex-Client-Identifier $http_x_plex_client_identifier;
          proxy_set_header X-Plex-Device $http_x_plex_device;
          proxy_set_header X-Plex-Device-Name $http_x_plex_device_name;
          proxy_set_header X-Plex-Platform $http_x_plex_platform;
          proxy_set_header X-Plex-Platform-Version $http_x_plex_platform_version;
          proxy_set_header X-Plex-Product $http_x_plex_product;
          proxy_set_header X-Plex-Token $http_x_plex_token;
          proxy_set_header X-Plex-Version $http_x_plex_version;
          proxy_set_header X-Plex-Nocache $http_x_plex_nocache;
          proxy_set_header X-Plex-Provides $http_x_plex_provides;
          proxy_set_header X-Plex-Device-Vendor $http_x_plex_device_vendor;
          proxy_set_header X-Plex-Model $http_x_plex_model;
          proxy_set_header Host $server_addr;
          proxy_set_header Referer $server_addr;
          proxy_set_header Origin $server_addr;

          # Disable buffering
          proxy_buffering off;
        '';
      };
    };
  };
}
