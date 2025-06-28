{pkgs}: {
  # Regular packages
  systemPackages = with pkgs; [
    # Base system tools
    git
    vim
    libnotify
    pavucontrol
    brightnessctl
    ffmpeg
    alacritty
    nautilus
    hyprshot
    hyprpicker
    alejandra

    # Shell tools
    fzf
    zoxide
    ripgrep
    eza
    fd
    curl
    unzip
    wget
    gnumake

    # TUIs
    lazygit
    lazydocker
    btop
    powertop
    fastfetch

    # GUIs
    chromium
    obsidian
    vlc

    # Can't find this in nixpkgs!
    # Might have to make it ourselves
    # asdcontrol

    # Don't want these right now
    # obs-studio
    # kdePackages.kdenLive
    # pinta
    # libreoffice
    # signal_desktop

    # Commercial GUIs
    typora
    dropbox
    spotify
    # zoom

    # Development tools
    github-desktop
    gh
    podman-tui
    podman-compose
  ];

  homePackages = with pkgs; [
  ];
}
