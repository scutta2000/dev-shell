{ pkgs, ... }: {
  imports = [
    ./options.nix
    ./keymaps.nix
    ./plugins.nix
  ];

  # Highlight when yanking
  autoGroups = {
    kickstart-highlight-yank = {
      clear = true;
    };
  };

  autoCmd = [
    {
      event = [ "TextYankPost" ];
      group = "kickstart-highlight-yank";
      callback = {
        __raw = "function() vim.highlight.on_yank() end";
      };
    }
  ];
}