{
  inputs,
  config,
  ...
}: {
  flake.modules.hosts.guren = {pkgs, ...}: {
    imports = with (config.flake.modules.nixos);
      [
        # inputs.nixos-hardware.nixosModules.framework-13-amd-ai-300-series
        inputs.nixos-hardware.nixosModules.framework-amd-ai-300-series
        inputs.omarchy.nixosModules.default
        base
        desktop
        containers
        # hyprland
        # gnome
        dev
        games
        shell
      ]
      ++ config.flake.modules.nixosUsers.root.imports
      ++ config.flake.modules.nixosUsers.henry.imports
      ++ [
        {
          home-manager.users.henry.nixpkgs.config.allowUnfree = true;
        }
        {
          home-manager.users.henry.imports = with config.flake.modules.homeManager; [
            inputs.omarchy.homeManagerModules.options
            inputs.omarchy.homeManagerModules.default
            base
            desktop
            dev
            games
            nixvim
            shell
          ];
        }
      ];

    hardware.graphics.enable = true;
    services.fwupd.enable = true;
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    services.blueman.enable = true;

    # Use power-profiles-daemon instead of TLP
    services.power-profiles-daemon.enable = true;
    services.tlp.enable = false;

    # systemd.sleep.extraConfig = ''
    #   HibernateDelaySec=2h
    #   SuspendMode=deep
    # '';

    # Systemd services for WiFi suspend workaround
    systemd.services.wifi-suspend-workaround = {
      description = "WiFi suspend workaround";
      before = ["sleep.target" "suspend.target" "hibernate.target" "hybrid-sleep.target"];
      wantedBy = ["sleep.target" "suspend.target" "hibernate.target" "hybrid-sleep.target"];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.kmod}/bin/modprobe -r mt7925e || true";
      };
    };

    systemd.services.wifi-resume-workaround = {
      description = "WiFi resume workaround";
      after = ["suspend.target" "hibernate.target" "hybrid-sleep.target"];
      wantedBy = ["suspend.target" "hibernate.target" "hybrid-sleep.target"];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.bash}/bin/bash -c 'sleep 2 && ${pkgs.kmod}/bin/modprobe mt7925e'";
      };
    };
  };
}
