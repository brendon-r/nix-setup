{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    git
    vim
    curl
    wget
  ];

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  networking.networkmanager.enable = true;
}
