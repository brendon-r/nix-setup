{nixpkgs, ...}: {
  flake.modules = {
    nixpkgs.allowedUnfreePackages = ["vscode"];

    nixos.dev = {
    };

    homeManager.dev = {pkgs, ...}: {
      programs.vscode = {
        enable = true;
        # extensions = with pkgs.vscode-extensions; [
        #   vscodevim.vim
        # ];
      };
    };
  };
}
