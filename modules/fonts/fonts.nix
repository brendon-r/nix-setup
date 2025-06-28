{...}: {
  flake.modules.nixos.fonts= {pkgs, ...}: {
    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-emoji
      fira-code
      fira-code-symbols
      nerd-fonts.fira-code
      (pkgs.stdenv.mkDerivation {
        name = "berkeley-mono";
        src = ../../../config/fonts/berkeley-mono.zip;

        nativeBuildInputs = [pkgs.unzip];

        unpackPhase = ''
          unzip $src
        '';

        installPhase = ''
          mkdir -p $out/share/fonts/opentype
          # The fonts are extracted to berkeley-mono/ subdirectory
          cp berkeley-mono/*.otf $out/share/fonts/opentype/
        '';

        meta = {
          description = "Berkeley Mono typeface family";
          longDescription = ''
            Berkeley Mono is a monospace typeface family with 20 fonts
            including Thin, ExtraLight, Light, SemiLight, Regular, Medium,
            SemiBold, Bold, ExtraBold, and Black weights, each with oblique variants.
          '';
        };
      })
    ];

    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        serif = ["Noto Serif"];
        sansSerif = ["Noto Sans"];
        monospace = ["FiraCode Nerd Font"];
      };
    };
  };

  flake.modules.homeManager.fonts = {
    fonts.fontconfig.enable = true;
  };
}
