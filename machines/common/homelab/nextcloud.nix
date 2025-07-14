{
  self,
  config,
  lib,
  pkgs,
  ...
}: {
  environment.etc."nextcloud-admin-pass".text = "PWD";
  services.nextcloud = {
    enable = true;
    hostName = "cloud.sipp.family";

    # Need to manually increment with every major upgrade.
    package = pkgs.nextcloud31;

    # Let NixOS install and configure the database automatically.
    database.createLocally = true;

    # Let NixOS install and configure Redis caching automatically.
    configureRedis = true;

    # Increase the maximum file upload size to avoid problems uploading videos.
    maxUploadSize = "16G";
    https = true;

    autoUpdateApps.enable = true;
    extraAppsEnable = true;
    extraApps = with config.services.nextcloud.package.packages.apps; {
      # List of apps we want to install and are already packaged in
      # https://github.com/NixOS/nixpkgs/blob/master/pkgs/servers/nextcloud/packages/nextcloud-apps.json
      # inherit calendar contacts mail notes onlyoffice tasks;

      # Custom app installation example.
      # cookbook = pkgs.fetchNextcloudApp rec {
      #   url =
      #     "https://github.com/nextcloud/cookbook/releases/download/v0.10.2/Cookbook-0.10.2.tar.gz";
      #   sha256 = "sha256-XgBwUr26qW6wvqhrnhhhhcN4wkI+eXDHnNSm1HDbP6M=";
      # };
    };

    config = {
      # overwriteProtocol = "https";
      dbtype = "sqlite";
      adminuser = "admin";
      adminpassFile = "/etc/nextcloud-admin-pass";
    };
  };
}
