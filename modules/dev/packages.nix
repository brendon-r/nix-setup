{...}: {
  flake.modules.nixos.dev = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      # Code formatting
      alejandra

      # Build tools
      gnumake

      # Text processing
      ripgrep

      # System utilities
      direnv
      curl
      unzip
      wget

      # Editors
      neovim
      vscode
      jetbrains-toolbox
    ];
  };
}
