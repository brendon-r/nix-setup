{pkgs, ...}: {

  nix.settings.trusted-users = [ "henry" "wheel" ];
  environment.systemPackages = with pkgs; [
    git vim curl wget htop docker-compose
  ];

  services.openssh.enable = true;
  virtualisation.docker.enable = true;
  # firewall, auth
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];
}
