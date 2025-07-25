{
  config,
  lib,
  pkgs,
  ...
}: {
  options.overseerr = {
    enable = lib.mkEnableOption "Overseerr";

    subDomainName = lib.mkOption {
      type = lib.types.str;
      default = "photos";
      description = "Subdomain for Overseerr service";
    };

    baseDomainName = lib.mkOption {
      type = lib.types.str;
      default = "sipp.family";
      description = "Base domain name for Overseerr service";
    };
  };

  config = lib.mkIf config.overseerr.enable {
    containers.overseerr = {
      autoStart = true;
      privateNetwork = true;
      hostAddress = "10.50.0.1";
      localAddress = "10.50.0.6";

      bindMounts = {
        "/var/lib" = {
          hostPath = "/persistent/overseerr";
          isReadOnly = false;
        };
      };

      config = {
        config,
        pkgs,
        ...
      }: {
        networking.firewall = {
          enable = true;
          allowedTCPPorts = [5055];
        };
        systemd.services.overseerr = {
          after = ["docker.service"];
          requires = ["docker.service"];
          wantedBy = ["multi-user.target"];
          script = ''
            ${pkgs.docker} run \
              --rm \
              --name overseerr \
              -e LOG_LEVEL=debug \
              -e TZ=America/Chicago \
              -e PORT=5055 `#optional` \
              -p 5055:5055 \
              -v /path/to/appdata/config:/app/config \
              --restart unless-stopped \
              sctx/overseerr
          '';

          preStop = ''
            ${pkgs.docker}/bin/docker stop overseerr || true
          '';

          serviceConfig = {
            Type = "simple";
            Restart = "always";
            RestartSec = "10s";
          };
        };

        system.stateVersion = "25.05";
      };
    };

    services.nginx.virtualHosts."${config.overseerr.subDomainName}.${config.overseerr.baseDomainName}" = {
      serverName = "${config.overseerr.subDomainName}.${config.overseerr.baseDomainName}";
      forceSSL = true;
      useACMEHost = config.overseerr.baseDomainName;
      locations."/" = {
        proxyPass = "http://10.50.0.6:5055";
        proxyWebsockets = true;
        recommendedProxySettings = true;
      };
    };
  };
}
