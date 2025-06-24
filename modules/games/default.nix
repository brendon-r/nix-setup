{...}: {
  flake.modules = {
    nixos.games = {pkgs, ...}: {
      programs = {
        steam = {
          enable = true;
          remotePlay.openFirewall = true;
          dedicatedServer.openFirewall = false;
          gamescopeSession.enable = true;
          extraCompatPackages = [pkgs.proton-ge-bin];
          protontricks = {
            enable = true;
          };
          package = pkgs.steam.override {
            extraPkgs = pkgs:
              with pkgs; [
                xorg.libXcursor
                xorg.libXi
                xorg.libXinerama
                xorg.libXScrnSaver
                libpng
                libpulseaudio
                libvorbis
                stdenv.cc.cc.lib
                libkrb5
                keyutils
              ];
          };
        };
      };
    };

    homeManager.games = {};
  };
}
