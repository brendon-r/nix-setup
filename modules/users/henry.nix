{inputs, ...}: {
  users.users = {
    henry = {
      isNormalUser = true;
      openssh.authorizedKeys.keys = [];
      extraGroups = [
        "audio"
        "input"
        "networkmanager"
        "sound"
        "tty"
        "wheel"
      ];
    };
  };

  home-manager.users.henry = import ../../home/henry;
}
