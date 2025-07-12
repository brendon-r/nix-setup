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

  # Home Assistant virtual host - simple version
  services.nginx.virtualHosts."home.sipp.family" = {
    forceSSL = true;
    useACMEHost = "sipp.family";
    locations."/" = {
      proxyPass = "http://localhost:8123";
      proxyWebsockets = true;
    };
  };

  # Let Nextcloud manage its own virtualHost
  services.nginx.virtualHosts."cloud.sipp.family" = {
    forceSSL = true;
    useACMEHost = "sipp.family";
  };
}
