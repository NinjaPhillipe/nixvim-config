{ self, ... }:
{
  plugins.lsp.servers = {
    nixd.enable = true;
  };
}
