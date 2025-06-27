{...}: {
  flake.modules.nixos.dev = {
    networking.firewall.enable = true;
    networking.firewall.allowedTCPPorts = [3000 8081];
  };
}
