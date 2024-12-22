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

  extraConfigLua = ''
    require'lspconfig'.omnisharp.setup {
        cmd = { "dotnet", "/path/to/omnisharp/OmniSharp.dll" },

        settings = {
          FormattingOptions = {
            -- Enables support for reading code style, naming convention and analyzer
            -- settings from .editorconfig.
            EnableEditorConfigSupport = true,
            -- Specifies whether 'using' directives should be grouped and sorted during
            -- document formatting.
            OrganizeImports = nil,
          },
          MsBuild = {
            -- If true, MSBuild project system will only load projects for files that
            -- were opened in the editor. This setting is useful for big C# codebases
            -- and allows for faster initialization of code navigation features only
            -- for projects that are relevant to code that is being edited. With this
            -- setting enabled OmniSharp may load fewer projects and may thus display
            -- incomplete reference lists for symbols.
            LoadProjectsOnDemand = nil,
          },
          RoslynExtensionsOptions = {
            -- Enables support for roslyn analyzers, code fixes and rulesets.
            EnableAnalyzersSupport = nil,
            -- Enables support for showing unimported types and unimported extension
            -- methods in completion lists. When committed, the appropriate using
            -- directive will be added at the top of the current file. This option can
            -- have a negative impact on initial completion responsiveness,
            -- particularly for the first few completion sessions after opening a
            -- solution.
            EnableImportCompletion = nil,
            -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
            -- true
            AnalyzeOpenDocumentsOnly = nil,
          },
          Sdk = {
            -- Specifies whether to include preview versions of the .NET SDK when
            -- determining which version to use for project loading.
            IncludePrereleases = true,
          },
        },
    }
  '';

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
