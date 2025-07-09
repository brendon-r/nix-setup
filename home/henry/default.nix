{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    inputs.omarchy.homeManagerModules.default
  ];

  home.username = "henry";
  home.homeDirectory = "/home/henry";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  programs.ssh = {
    enable = true;
    # extraConfig = ''
    #   Host *
    #     IdentityAgent ~/.1password/agent.sock
    # '';
  };

  programs.git = {
    extraConfig = {
      credential.helper = "store";

      # gpg.format = "ssh";
      # gpg."ssh".program = lib.getExe' pkgs._1password-gui "op-ssh-sign";
      # commit.gpgsign = true;
      # user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINjU7xEhfQl6Y2jwuH1po4xK8x6PdXejq60Du4YYJhi5";
      # push.autoSetupRemote = true;
    };
  };

  wayland.windowManager.hyprland.settings = {
    # "$terminal" = "ghostty";
    # "$fileManager" = "nautilus --new-window";
    # "$browser" = "chromium --new-window --ozone-platform=wayland";
    # "$music" = "spotify";
    # "$passwordManager" = "1password";
    # "$messenger" = "telegram-desktop";
    # "$webapp" = "$browser --app";

    input = {
      kb_options = "ctrl:nocaps";
      accel_profile = "flat";
      sensitivity = 0.25;
      touchpad = {
        clickfinger_behavior = 2;
        natural_scroll = true;
        tap-to-click = true;
        drag_lock = true;
        disable_while_typing = true;
        middle_button_emulation = false;
      };
    };
    gestures = {
      workspace_swipe = true;
    };
    bind = [
      ",mouse:274, exec,"
    ];
  };
}
