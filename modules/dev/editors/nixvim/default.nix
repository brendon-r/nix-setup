{inputs, ...}: {
  flake.modules.homeManager.nixvim = {...}: {
    imports = [
      inputs.nixvim.homeManagerModules.nixvim
    ];
    
    programs.nixvim = {
      enable = true;

      imports = [
        # ./lazygit.nix
      ];

      opts = {
        shiftwidth = 2;
        smartindent = true;
        tabstop = 2;
        number = true;
      };

      colorschemes.everforest.enable = true;

      plugins = {
        web-devicons.enable = true;
        bufferline.enable = true;
        nix.enable = true;
        treesitter.enable = true;
        which-key.enable = true;
        telescope = {
          enable = true;
          keymaps = {
            "<leader>ff" = {
              options.desc = "file finder";
              action = "find_files";
            };
            "<leader>fr" = {
              options.desc = "recent files";
              action = "oldfiles";
            };
            "<leader>fg" = {
              options.desc = "find via grep";
              action = "live_grep";
            };
            "<leader>T" = {
              options.desc = "switch colorscheme";
              action = "colorscheme";
            };
          };
          extensions = {
            file-browser.enable = true;
            ui-select.enable = true;
            frecency.enable = true;
            fzf-native.enable = true;
          };
        };

        lsp = {
          enable = true;
          keymaps = {
            lspBuf = {
              "gd" = "definition";
              "gD" = "references";
              "gt" = "type_definition";
              "gi" = "implementation";
              "K" = "hover";
              "<leader>A" = "code_action";
            };
            diagnostic = {
              "<leader>k" = "goto_prev";
              "<leader>j" = "goto_next";
            };
          };
          servers = {
            ts_ls.enable = true;
            ruby_lsp.enable = true;
            ruby_lsp.package = null;
            # elixirls.enable = true;
            lexical.enable = true;
            eslint.enable = true;
          };
        };
      };

    };
  };
}
