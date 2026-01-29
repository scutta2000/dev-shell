{
  keymaps = [
    {
      mode = "n";
      key = "<Esc>";
      action = "<cmd>nohlsearch<CR>";
    }
    {
      mode = "n";
      key = "<leader>q";
      action.__raw = "vim.diagnostic.setloclist";
      options.desc = "Open diagnostic [Q]uickfix list";
    }
    {
      mode = "t";
      key = "<Esc><Esc>";
      action = "<C-\><C-n>";
      options.desc = "Exit terminal mode";
    }
    {
      mode = "n";
      key = "<C-h>";
      action = "<C-w><C-h>";
      options.desc = "Move focus to the left window";
    }
    {
      mode = "n";
      key = "<C-l>";
      action = "<C-w><C-l>";
      options.desc = "Move focus to the right window";
    }
    {
      mode = "n";
      key = "<C-j>";
      action = "<C-w><C-j>";
      options.desc = "Move focus to the lower window";
    }
    {
      mode = "n";
      key = "<C-k>";
      action = "<C-w><C-k>";
      options.desc = "Move focus to the upper window";
    }
          {
            mode = "v";
            key = "p";
            action = "\"_dP";
            options.desc = "Paste without yanking";
          }
          {
            mode = "n";
            key = "<leader>a";
            action.__raw = "function() require('harpoon'):list():add() end";
            options.desc = "Add to harpoon";
          }
          {
            mode = "n";
            key = "<C-e>";
            action.__raw = "function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) end";
            options.desc = "Open harpoon window";
          }
          {
            mode = "n";
            key = "<M-u>";
            action.__raw = "function() require('harpoon'):list():select(1) end";
          }
          {
            mode = "n";
            key = "<M-i>";
            action.__raw = "function() require('harpoon'):list():select(2) end";
          }
          {
            mode = "n";
            key = "<M-o>";
            action.__raw = "function() require('harpoon'):list():select(3) end";
          }
          {
            mode = "n";
            key = "<M-p>";
            action.__raw = "function() require('harpoon'):list():select(4) end";
          }
        ];
    }
    