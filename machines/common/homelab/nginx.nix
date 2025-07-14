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

    # If you need the map directive, it goes here at the http level
    appendHttpConfig = ''
      map $http_upgrade $connection_upgrade {
        default upgrade;
        "" close;
      }
    '';
  };

  services.nginx.virtualHosts."default" = {
    default = true;
    forceSSL = true;
    useACMEHost = "sipp.family";
    locations."/" = {
      return = "444"; # Close connection without response
    };
  };

  services.nginx.virtualHosts."sipp.family" = {
    forceSSL = true;
    useACMEHost = "sipp.family";
    locations."/" = {
      proxyPass = "http://localhost:3000";
      proxyWebsockets = true;
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
}
