{
  config,
  pkgs,
  ...
}: let
  cfg = config.omarchy;
  themes = import ../themes.nix;
  theme = themes.${cfg.theme};
in {
  programs.vscode = {
    enable = true;
    profiles.default = {
      userSettings =
        {
          "workbench.colorTheme" = theme.vscode_theme;
          # "workbench.colorTheme" = "Everforest Dark";
          "vim.useCtrlKeys" = false;
          "editor.minimap.enabled" = false;
        }
        // cfg.vscode_settings;

      extensions = with pkgs.vscode-extensions;
        [
          bbenoist.nix
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
          {
            name = "kanagawa";
            publisher = "qufiwefefwoyn";
            version = "1.5.1";
            sha256 = "sha256-AGGioXcK/fjPaFaWk2jqLxovUNR59gwpotcSpGNbj1c=";
          }
        ];
    };
  };
}
