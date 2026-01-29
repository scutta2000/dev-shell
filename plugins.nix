{ pkgs, ... }: {
  colorschemes.catppuccin.enable = true;
  # colorschemes.ayu-light.enable = true;

  plugins = {
    # Lazydev
    lazydev.enable = true;

    # Luasnip
    luasnip.enable = true;

    # Git signs
    gitsigns = {
      enable = true;
      settings.on_attach = ''
        function(bufnr)
          local gitsigns = require 'gitsigns'

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then
              vim.cmd.normal { ']c', bang = true }
            else
              gitsigns.nav_hunk 'next'
            end
          end, { desc = 'Jump to next git [c]hange' })

          map('n', '[c', function()
            if vim.wo.diff then
              vim.cmd.normal { '[c', bang = true }
            else
              gitsigns.nav_hunk 'prev'
            end
          end, { desc = 'Jump to previous git [c]hange' })

          -- Actions
          map('v', '<leader>hs', function()
            gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
          end, { desc = 'stage git hunk' })
          map('v', '<leader>hr', function()
            gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
          end, { desc = 'reset git hunk' })
          map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
          map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
          map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
          map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
          map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
          map('n', '<leader>hb', gitsigns.blame_line, { desc = 'git [b]lame line' })
          map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
          map('n', '<leader>hD', function()
            gitsigns.diffthis '@'
          end, { desc = 'git [D]iff against last commit' })
          map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
        end
      '';
    };

    # Which-key
    which-key = {
      enable = true;
      settings = {
        icons.mappings = true;
        spec = [
          { __unkeyed-1 = "<leader>c"; group = "[C]ode"; mode = [ "n" "x" ]; }
          { __unkeyed-1 = "<leader>d"; group = "[D]ocument"; }
          { __unkeyed-1 = "<leader>r"; group = "[R]ename"; }
          { __unkeyed-1 = "<leader>s"; group = "[S]earch"; }
          { __unkeyed-1 = "<leader>w"; group = "[W]orkspace"; }
          { __unkeyed-1 = "<leader>t"; group = "[T]oggle"; }
          { __unkeyed-1 = "<leader>h"; group = "Git [H]unk"; mode = [ "n" "v" ]; }
        ];
      };
    };

    # Snacks
    snacks = {
      enable = true;
      settings = {
        picker = { };
        explorer = { };
      };
    };

    # Rust
    rustaceanvim.enable = true;

    # LSP
    lsp = {
      enable = true;
      servers = {
        gleam.enable = true;
        rust_analyzer = {
          enable = false;
          installCargo = false;
          installRustc = false;
        };
        ts_ls = {
          enable = true;
          extraOptions = {
            capabilities = {
              formatting = false;
              rangeFormatting = false;
            };
          };
        };
        lua_ls = {
          enable = true;
          settings.Lua.completion.callSnippet = "Replace";
        };
        bashls.enable = true;
        gopls.enable = true;
        angularls.enable = true;
      };
      keymaps = {
        lspBuf = {
          "<leader>rn" = { action = "rename"; desc = "[R]e[n]ame"; };
          "<leader>ca" = { action = "code_action"; desc = "[C]ode [a]ction"; };
        };
        diagnostic = {
          "gl" = { action = "open_float"; desc = "Open diagnostic"; };
        };
      };
    };

    # Conform (Autoformat)
    conform-nvim = {
      enable = true;
      settings = {
        notify_on_error = true;
        format_on_save = {
          timeout_ms = 500;
          lsp_format = "fallback";
        };
        formatters_by_ft = {
          lua = [ "stylua" ];
          go = [ "golangci-lint" ];
          python = [ "gplint" ];
          typescript = [ "eslint_d" ];
          javascript = [ "eslint_d" ];
          typescriptreact = [ "eslint_d" ];
        };
      };
    };

    # Blink.cmp (Autocompletion)
    blink-cmp = {
      enable = true;
      settings = {
        keymap.preset = "default";
        appearance.nerd_font_variant = "mono";
        sources = {
          default = [ "lsp" "path" "snippets" "lazydev" ];
          providers.lazydev = {
            module = "lazydev.integrations.blink";
            score_offset = 100;
          };
        };
        snippets.preset = "luasnip";
        fuzzy.implementation = "prefer_rust_with_warning";
        signature.enabled = true;
      };
    };

    # Treesitter
    treesitter = {
      enable = true;
      settings = {
        ensure_installed = [ "bash" "c" "diff" "html" "lua" "luadoc" "markdown" "markdown_inline" "query" "vim" "vimdoc" ];
        auto_install = true;
        highlight = {
          enable = true;
          additional_vim_regex_highlighting = [ "ruby" ];
        };
        indent = {
          enable = true;
          disable = [ "ruby" ];
        };
      };
    };

    # Mini
    mini = {
      enable = true;
      modules = {
        ai = { n_lines = 500; };
        surround = { };
        statusline = { use_icons = true; };
      };
    };

      # Neo-tree
      neo-tree = {
        enable = true;
        settings = {
          filesystem = {
            follow_current_file = {
              enabled = false;
            };
            window = {
              mappings = {
                "\\\\" = "close_window";
              };
            };
          };
        };
      };

    # Harpoon
    harpoon = {
      enable = true;
    };

    # Autopairs
    nvim-autopairs.enable = true;

    # DAP
    dap.enable = true;
    dap-ui.enable = true;
    dap-go.enable = true;
    dap-python.enable = true;

    # Indent Blankline
    indent-blankline.enable = true;

    # Lint
    lint = {
      enable = true;
      lintersByFt = {
        markdown = [ "markdownlint" ];
      };
    };

    # Todo-comments
    todo-comments.enable = true;

    # Tmux navigator
    tmux-navigator.enable = true;

    # TS Autotag
    ts-autotag.enable = true;

    # Treesitter context
    treesitter-context = {
      enable = true;
      settings.max_lines = 8;
    };

    # Neogit
    neogit.enable = true;
  };

  # Snacks keymaps (since they use Lua functions)
  extraConfigLua = ''
    local snacks = require("snacks")
    vim.keymap.set("n", "<leader>sf", function() snacks.picker.smart() end, { desc = "Smart Find Files" })
    vim.keymap.set("n", "<leader>sg", function() snacks.picker.grep() end, { desc = "Grep" })
    vim.keymap.set("n", "<leader>e", function() snacks.explorer() end, { desc = "File Explorer" })
    vim.keymap.set({ "n", "x" }, "<leader>sw", function() snacks.picker.grep_word() end, { desc = "Visual selection or word" })
    vim.keymap.set("n", "gd", function() snacks.picker.lsp_definitions() end, { desc = "Goto Definition" })
    vim.keymap.set("n", "gr", function() snacks.picker.lsp_references() end, { desc = "References" })
  '';

  extraPlugins = with pkgs.vimPlugins; [
    sleuth
  ];
}

