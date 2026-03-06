{options, config, pkgs, lib, ... }:
{
  globals.mapleader = " ";
  imports = [
    /home/istipisti113/.config/home-manager/nixvim/cmp.nix
    #/home/istipisti113/.config/home-manager/nixvim/blink.nix
  ];
  enable = true;
  highlight.ExtraWhitespace.bg = "red";
  defaultEditor = true;
  viAlias = true;
  vimAlias = true;
  opts = {
    cursorline=true;
    cursorcolumn=true;
    number = true;
    relativenumber = true;
    shiftwidth = 2;
    expandtab = true;
    tabstop = 2;
    smartindent = true;
    undofile = true;
    termguicolors = true;
    signcolumn = "yes";
    scrolloff = 8;
  };

  keymaps = [
    {
      key = "{";
      action = "}";
    }
    {
      key = "}";
      action = "{";
    }
    {
      key = "<leader>d";
      lua = true;
      action = "vim.diagnostic.open_float";
      mode = "n";
    }
  ];
  colorschemes.tokyonight.enable = true;
  colorschemes.catppuccin.enable = false;

  plugins = {
    autoclose.enable = true;
    flutter-tools.enable = false;
    fugitive.enable = true;
    web-devicons.enable = true;
    #conform-nvim = {
    #  enable = true;
    #  settings.formatters_by_ft = {
    #    html = [["emmet-ls"]];
    #    css = [["emmet-ls"]];
    #  };
    #};

    telescope = {
      enable = true;
      keymaps = {
        "<leader>tf" = {
          action = "find_files";
          options.desc = "find files";
        };
        "<leader>tF" = {
          action = "find_files";
          options.desc = "find hidden files";
        };
        "<leader>to" = {
          action = "oldfiles";
          options.desc = "find hidden files";
        };
      };
    };

    treesitter = {
      enable = true;
      settings.indent.enable = true;
      settings.highlight.enable = true;
    };
    cmp.enable = true;
    lualine.enable = true;
    lsp.enable = true;

    lsp.servers = {
      emmet_ls = {
        enable = true;
      };
      html.enable = true;
      csharp_ls.enable = true;
      #omnisharp = {enable = true;cmd = [ "OmniSharp" "--languageserver" ];};
      rust_analyzer = {
        enable = true;
        autostart = true;
        installCargo = true;
        installRustc = true;
        settings.checkOnSave = true;
      };
      lua_ls.enable = true;
      lua_ls.autostart = true;
      nixd.enable = true;
      nixd.autostart = true;
    };
    lint = {
      enable = true;
      lintersByFt = {
        lua = ["luacheck"];
        nix = ["nix"];
        #rust = ["rust-analyzer"];
        #dart = ["flutter-tools"];
      };
    };
  };

  extraPlugins = with pkgs.vimPlugins; [
    nvim-lspconfig
    #flutter-tools-nvim
  ];
  extraPackages = with pkgs; [
    #typescript-language-server
  ];
  extraConfigLua = ''

  vim.keymap.set("n", "<esc>", ":noh<CR>")
  local function set_cmn_lsp_keybinds()
    local lsp_keybinds = {
      {
        key = "K",
        action = vim.lsp.buf.hover,
        options = {
          buffer = 0,
          desc = "hover [K]noledge with LSP",
        },
      },
      {
        key = "gd",
        action = vim.lsp.buf.definition,
        options = {
          buffer = 0,
          desc = "[g]o to [d]efinition with LSP",
        },
      },
      {
        key = "gy",
        action = vim.lsp.buf.type_definition,
        options = {
          buffer = 0,
          desc = "[g]o to t[y]pe definition with LSP",
        },
      },
      {
        key = "gi",
        action = vim.lsp.buf.implementation,
        options = {
          buffer = 0,
          desc = "[g]o to [i]mplementation with LSP",
        },
      },
      {
        key = "<leader>dj",
        action = vim.diagnostic.goto_next,
        options = {
          buffer = 0,
          desc = "Go to next [d]iagnostic with LSP",
        },
      },
      {
        key = "<leader>dk",
        action = vim.diagnostic.goto_prev,
        options = {
          buffer = 0,
          desc = "Go to previous [d]iagnostic with LSP",
        },
      },
      {
        key = "<leader>r",
        action = vim.lsp.buf.rename,
        options = {
          buffer = 0,
          desc = "[r]ename variable with LSP",
        },
      },
    }
    for _, bind in ipairs(lsp_keybinds) do
      vim.keymap.set("n", bind.key, bind.action, bind.options)
    end
  end

  vim.lsp.config("rust-analyzer", {
    cmd = {"rust-analyzer"},
    root_markers = {"Cargo.toml"},
    filetypes = {"rust"},
    settings = {
      diagnostics = {
        disabled = { "unresolved-proc-macro", "unresolved-macro-call" },
      },
      cargo = {
        allFeatures = true,
      },
    }
  })


  -- Rust LSP
--;  require("lspconfig").rust_analyzer.setup({
--;    root_dir = function(fname)
--;      return vim.loop.cwd()
--;    end,
--;    settings = {
--;      ['rust-analyzer'] = {
--;        diagnostics = {
--;          disabled = { "unresolved-proc-macro", "unresolved-macro-call" },
--;        },
--;        cargo = {
--;          allFeatures = true,
--;        },
--;      },
--;    },
--;    on_attach = function()
--;      set_cmn_lsp_keybinds()
--;    end,
--;  })
  --require("lspconfig").ts_ls.setup{
  --on_attach = function(client, bufnr)
  --  -- optional: keymaps, etc.
  --end,
  --flags = { debounce_text_changes = 150 },
  --}


  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  vim.lsp.config("cssls", {
    cmd = { "vscode-css-language-server", "--stdio" },
    filetypes = { "css", "scss", "less" },
    settings = {
      css = { validate = true },
      less = { validate = true },
      scss = { validate = true },
    },
  })
  vim.lsp.enable("cssls")
  '';
}
