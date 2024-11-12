{ ... }:
{
  plugins.harpoon = {
    enable = true;
  };

  keymaps = [
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>ha";
      options.script = true;
      action = ":lua require('harpoon.mark').add_file()<CR>";
    }
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>hm";
      options.script = true;
      action = ":lua require('harpoon.ui').toggle_quick_menu()<CR>";
    }
  ];

}
