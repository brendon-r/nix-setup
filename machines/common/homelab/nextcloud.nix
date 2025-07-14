{
  self,
  config,
  lib,
  pkgs,
  ...
}: {
  containers.nextcloud = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "10.50.0.1";
    localAddress = "10.50.0.2";
    bindMounts = {
      "/secrets" = {
        hostPath = "/persistent/nextcloud/secrets";
      };
      "/var/lib/nextcloud/config" = {
        hostPath = "/persistent/nextcloud/config";
        isReadOnly = false;
      };
      "/var/lib/nextcloud/data" = {
        hostPath = "/mnt/box-plain/nextcloud/data";
        isReadOnly = false;
      };
      "/var/lib/postgresql" = {
        hostPath = "/persistent/nextcloud/db";
        isReadOnly = false;
      };
    };
    config = {
      pkgs,
      config,
      lib,
      ...
    }:
      with lib; {
        networking.firewall.enable = false;
        environment.etc."nextcloud-admin-pass".text = "PWD";

        # sops.secrets.nextcloud = {};
        # sops.templates.nextcloud.content = ''
        #   ${config.sops.nextcloud.admin_password}
        # '';
        services.nextcloud = {
          enable = true;
          hostName = "cloud.sipp.family";
          # hostName = "10.50.0.2";
          package = pkgs.nextcloud31;
          https = true;
          database.createLocally = true;
          configureRedis = true;
          config = {
            dbtype = "pgsql";
            adminuser = "henry.sipp@hey.com";
            adminpassFile = "/secrets/pw";
            # adminpassFile = config.sops.templates.secrets.nextcloud.path;
          };
        };
      };
  };

  # Automated backup service
  # systemd.services.nextcloud-backup = {
  #   description = "Backup Nextcloud configuration and database";
  #   startAt = "04:00:00";
  #   path = with pkgs; [
  #     gnutar
  #     gzip
  #     findutils
  #   ];
  #   script = ''
  #     find /mnt/box-plain/nextcloud/backup -name "backup_*.tar.gz" -mtime +14 -delete
  #     nixos-container run nextcloud -- sudo -u postgres pg_dumpall > db_dump.sql
  #     tar -czf "/mnt/box-plain/nextcloud/backup/backup_$(date +\"%Y-%m-%d_%H-%M-%S\").tar.gz" config db_dump.sql
  #   '';
  #   serviceConfig = {
  #     Type = "oneshot";
  #     User = "root"; # Need root to access /persistent
  #     WorkingDirectory = "/persistent/nextcloud";
  #   };
  # };
}
