{ self, ... }:
{
  # Import all your configuration modules here
  imports = [
    ./bufferline.nix
    ./lsp/default.nix
  ];

  colorschemes.gruvbox.enable = true;

  plugins = {
    lualine.enable = true;
    # parser
    treesitter.enable = true;
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
    extensions.fzf-native = {
      enable = true;
    };
  };

  globals.mapleader = ",";

  keymaps = [
    {
      mode = [
        "n"
        "v"
      ];
      key = "<C-s>i";
      options.script = true;
      action = ":lua vim.lsp.buf.format()<Enter>";
    }
  ];

}
