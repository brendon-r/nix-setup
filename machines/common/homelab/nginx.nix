{
  config,
  pkgs,
  lib,
  ...
}: {
  sops.secrets.cloudflare_api_token = {};

  # ACME configuration for wildcard certificate
  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "henry.sipp@hey.com";
    };
    certs."sipp.family" = {
      domain = "*.sipp.family";
      extraDomainNames = ["sipp.family"];
      dnsProvider = "cloudflare";
      dnsResolver = "1.1.1.1:53";
      environmentFile = config.sops.secrets.cloudflare_api_token.path;
      group = "nginx";
    };
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    appendHttpConfig = ''
      map $http_upgrade $connection_upgrade {
        default upgrade;
        "" close;
      }

      # Rate limiting
      limit_req_zone $binary_remote_addr zone=login:10m rate=5r/m;
      limit_req_zone $binary_remote_addr zone=api:10m rate=10r/s;
    '';
  };

  # Fail2ban for intrusion prevention
  services.fail2ban = {
    enable = true;
    maxretry = 3;
    bantime = "24h";

    jails = {
      nginx-http-auth = ''
        enabled = true
        filter = nginx-http-auth
        logpath = /var/log/nginx/error.log
        maxretry = 3
        bantime = 24h
      '';

      nginx-limit-req = ''
        enabled = true
        filter = nginx-limit-req
        logpath = /var/log/nginx/error.log
        maxretry = 10
        bantime = 24h
      '';

      nginx-bad-request = ''
        enabled = true
        filter = nginx-bad-request
        logpath = /var/log/nginx/access.log
        maxretry = 5
        bantime = 24h
      '';
    };
  };

  services.nginx.virtualHosts."default" = {
    default = true;
    forceSSL = true;
    useACMEHost = "sipp.family";
    locations."/" = {
      return = "444"; # Close connection without response
    };
  };

  # Home Assistant virtual host - simple version
  services.nginx.virtualHosts."home.sipp.family" = {
    serverName = "home.sipp.family";
    forceSSL = true;
    useACMEHost = "sipp.family";
    locations."/" = {
      proxyPass = "http://localhost:8123";
      proxyWebsockets = true;
    };
  };

  # Let Nextcloud manage its own virtualHost
  services.nginx.virtualHosts."cloud.sipp.family" = {
    serverName = "cloud.sipp.family";
    forceSSL = true;
    useACMEHost = "sipp.family";
    locations."/" = {
      proxyPass = "http://10.50.0.2";
      proxyWebsockets = true;
    };
  };

  services.nginx.virtualHosts."plex.sipp.family" = {
    serverName = "plex.sipp.family";
    forceSSL = true;
    useACMEHost = "sipp.family";
    locations."/" = {
      proxyPass = "http://10.50.0.3:32400";
      proxyWebsockets = true;
    };
  };

  services.nginx.virtualHosts."photos.sipp.family" = {
    serverName = "photos.sipp.family";
    forceSSL = true;
    useACMEHost = "sipp.family";
    locations."/" = {
      proxyPass = "http://[::1]:2283";
      proxyWebsockets = true;
      recommendedProxySettings = true;
      extraConfig = ''
        client_max_body_size 50000M;
        proxy_read_timeout   600s;
        proxy_send_timeout   600s;
        send_timeout         600s;
      '';
    };
  };

  # services.nginx.virtualHosts."sonarr.sipp.family" = {
  #   serverName = "sonarr.sipp.family";
  #   forceSSL = true;
  #   useACMEHost = "sipp.family";
  #   locations."/" = {
  #     proxyPass = "http://10.50.0.5:8989";
  #     proxyWebsockets = true;
  #   };
  # };
}
