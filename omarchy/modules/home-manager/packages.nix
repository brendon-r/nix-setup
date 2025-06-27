{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    firefox
    git
    vim
  ];
  programs.vscode = {
    enable = true;
    userSettings = {
      "workbench.colorTheme" = "Tokyo Night";
      # "workbench.colorTheme" = "Everforest Dark";
    };
    extensions = with pkgs.vscode-extensions;
      [
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "everforest";
          publisher = "sainnhe";
          version = "0.3.0";
          sha256 = "sha256-nZirzVvM160ZTpBLTimL2X35sIGy5j2LQOok7a2Yc7U=";
        }
        {
          name = "tokyo-night";
          publisher = "enkia";
          version = "1.1.2";
          sha256 = "sha256-oW0bkLKimpcjzxTb/yjShagjyVTUFEg198oPbY5J2hM=";
        }
      ];
  };

  # programs.git = {
  #   enable = true;
  #   userName = "Default User";
  #   userEmail = "user@example.com";
  # };
}
