{
  pkgs,
  lib,
  inputs,
  outputs,
  ...
}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  time.timeZone = "Australia/Melbourne";
  nixpkgs = {
    overlays = [
      # outputs.overlays.additions
      # outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
    };
  };
  nix.settings.experimental-features = "nix-command flakes";
  services.tailscale.enable = true;

  environment.systemPackages = [pkgs.sops pkgs.btop];

  # sops configuration
  sops.defaultSopsFile = ../../secrets/example.yaml;
  sops.age.keyFile = "/home/brendon/.config/sops/age/keys.txt";
}
