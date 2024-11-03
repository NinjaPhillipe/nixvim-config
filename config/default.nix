{ self, ... }:
{
  # Import all your configuration modules here
  imports = [ ./bufferline.nix ];

  colorschemes.gruvbox.enable = true;

  plugins = {
    lualine.enable = true;
    # parser
    treesitter.enable = true;
  };

  plugins.lsp = {
    enable = true;
    servers = {
      rust_analyzer = {enable = true;
        installCargo = true;
        installRustc = true;
      };
      omnisharp.enable = true; # C# 
      nixd.enable = true; # nix LSP

    };
  };

  opts = {
    number = true;
    relativenumber = true;
    # Tab options
    tabstop = 4; # Number of spaces a <Tab> in the text stands for (local to buffer)
    shiftwidth = 4; # Number of spaces used for each step of (auto)indent (local to buffer)
    expandtab = true; # Expand <Tab> to spaces in Insert mode (local to buffer)
    autoindent = true; # Do clever autoindenting
  };
  
  plugins.telescope = {
    enable = true;
    keymaps = {
      "<leader>fg" = "live_grep";
      "<C-p>" = {
        action = "git_files";
        options = {
          desc = "Telescope Git Files";
        };
      };
    };
    extensions.fzf-native = { enable = true; };
  };
  
}
