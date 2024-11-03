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
}
