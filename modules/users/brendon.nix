{inputs, ...}: {
  users.users = {
    brendon = {
      isNormalUser = true;
      initialPassword = "changeme";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB46zfUxDNvqG7/Twow07+RdSH715arnHYo+qHLnG17H"
      ];

      extraGroups = [
        "audio"
        "input"
        "networkmanager"
        "sound"
        "tty"
        "wheel"
        "docker"
      ];
    };
  };
}
