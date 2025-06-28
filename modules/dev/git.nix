{...}: {
  flake.modules.homeManager.dev = {pkgs, ...}: {
    programs.git = {
      enable = true;
      extraConfig = {
        credential.helper = "store";
      };
      # userName = "Henry Sipp";
      # userEmail = "hesipp@gmail.com";
    };
    programs.gh = {
      enable = true;
      gitCredentialHelper = {
        enable = true;
      };
    };
  };
}
