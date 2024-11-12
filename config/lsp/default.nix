{ self, ... }:
{
  imports = [
    ./nixd.nix
  ];

  plugins.lsp = {
    enable = true;
    servers = {
      rust_analyzer = {
        enable = true;
        installCargo = true;
        installRustc = true;
      };
      omnisharp.enable = true; # C#
    };
  };

  keymaps = [
    # GO TO 
    {
      # go to definition
      mode = [
        "n"
        "v"
      ];
      key = "<leader>gd";
      options.script = true;
      action = ":lua vim.lsp.buf.definition()<CR>";
    }
    {
      # go to declaration
      mode = [
        "n"
        "v"
      ];
      key = "<leader>gD";
      options.script = true;
      action = ":lua vim.lsp.buf.declaration()<CR>";
    }
    {
      # go to implementation
      mode = [
        "n"
        "v"
      ];
      key = "<leader>gi";
      options.script = true;
      action = ":lua vim.lsp.buf.implementation()<CR>";
    }

    # REFACTO
    {
      # rename symbol
      mode = [
        "n"
        "v"
      ];
      key = "<leader>rn";
      options.script = true;
      action = ":lua vim.lsp.buf.rename()<CR>";
    }
    {
      # reformat according to lsp
      mode = [
        "n"
        "v"
      ];
      key = "<leader>f";
      options.script = true;
      action = ":lua vim.lsp.buf.format{ async = true }<CR>";
    }

    # SHOW
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>md";
      options.script = true;
      action = ":lua vim.lsp.buf.hover()<CR>";
    }
    {
      # show code action
      mode = [
        "n"
        "v"
      ];
      key = "<leader>ca";
      options.script = true;
      action = ":lua vim.lsp.buf.code_action()<CR>";
    }
  ];
}
