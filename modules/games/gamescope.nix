{...}: {
  flake.modules = {
    nixos.games = {pkgs, ...}:
    #     let
    #         WIDTH = 3840;
    #         HEIGHT = 2160;
    #         REFRESH_RATE = 240;
    #         VRR = false;
    #         HDR = false;
    #
    #         gamescope-env = ''
    #         set -x CAP_SYS_NICE eip
    #         set -x DXVK_HDR 1
    #         set -x ENABLE_GAMESCOPE_WSI 1
    #         set -x ENABLE_HDR_WSI 1
    #         set -x AMD_VULKAN_ICD RADV
    #         set -x RADV_PERFTEST aco
    #         set -x SDL_VIDEODRIVER wayland
    #         set -x STEAM_FORCE_DESKTOPUI_SCALING 1
    #         set -x STEAM_GAMEPADUI 1
    #         set -x STEAM_GAMESCOPE_CLIENT 1
    #         '';
    {
      programs = {
        gamemode.enable = true;
        #         gamescope = {
        #           enable = true;
        #           capSysNice = true;
        #           args = [
        #             "--rt"
        #             "--expose-wayland"
        #             "--backend"
        #             "sdl"
        #             "--immediate-flips"
        #           ];
        #         };
      };
    };

    #     homeManager.games = {pkgs, ...}: {
    #         home.packages = with pkgs; [
    #             steam-run
    #             gamescope-run
    #             steam-wrapper
    #         ];
    #     };
  };
}
