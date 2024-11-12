{ ... }:
{
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
      "<C-f>f" = "find_files";
    };
    extensions.fzf-native = {
      enable = true;
    };
  };
}
