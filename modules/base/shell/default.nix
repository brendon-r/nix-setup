{...}: {
  flake.modules = {
    nixos.shell = {pkgs, ...}: {
      programs.zsh.enable = true;
      environment.shells = [pkgs.zsh];
      users.defaultUserShell = pkgs.zsh;
    };

    darwin.shell = {pkgs, ...}: {
    };

    homeManager.shell = {pkgs, ...}: {
      programs.direnv.enable = true;
      programs.starship.enable = true;
      programs.zellij.enable = true;
      programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
      };

      programs.zsh = {
        enable = true;
        autosuggestion.enable = true;
        zplug = {
          enable = true;
          plugins = [
            {
              name = "plugins/git";
              tags = [from:oh-my-zsh];
            }
            {
              name = "fdellwing/zsh-bat";
              tags = [as:command];
            }
          ];
        };
        sessionVariables = {
          EDITOR = "nvim";
        };
      };
    };
  };
}
