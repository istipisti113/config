vim.g.mapleader = " "
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.wo.number = true
vim.wo.relativenumber = true
vim.keymap.set('n', '{', '}', {noremap = true})
vim.keymap.set('n', '}', '{', {noremap = true})
vim.keymap.set('n', 'j', 'gj', {noremap = true})
vim.keymap.set('n', 'k', 'gk', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', {noremap = true, silent=true})
--vim.api.nvim_set_keymap('n', '<leader>dd', '<cmd>Telescope diagnostics<CR>', { noremap = true, silent = true })
require('lspconfig').rust_analyzer.setup{
--capabilities = require('cmp_nvim_lsp').default_capabilities()
      --settings = {
      --  ['rust-analyzer'] = {
      --    diagnostics = {
      --      enable = true;
      --    }
      --  }
      --}
    }
		vim.cmd([[filetype plugin indent on]])
		vim.cmd([[syntax enable]])

     -- 	require('nvim-treesitter.configs').setup {
     --     parser_install_dir = vim.fn.stdpath("data") .. "/treesitterParsers",
     -- 	  ensure_installed = { "c", "lua", "python", "rust"}, -- replace with your languages
     -- 	  highlight = {
     -- 	    enable = true,
     -- 	    additional_vim_regex_highlighting = false,
     -- 	  },
     -- 	}

		require("lazy").setup({
  		{
  		  "nvim-treesitter/nvim-treesitter",
  		  build = ":TSUpdate",
  		  parser_install_dir = "/home/istipisti113/treesitterParsers",
  		  config = function()
  		    require("nvim-treesitter.configs").setup({
  		      parser_install_dir = "/home/istipisti113/treesitterParsers",
  		      ensure_installed = { "lua", "python", "c", "rust", "dart", "nix"},
  		      sync_install = false,
  		      auto_install = true,
  		      highlight = {
  		        enable = true,
  		        additional_vim_regex_highlighting = true,
  		      },
  		    })
  		  end,
  		  lazy = false,  -- load immediately
  		},
			{
				'nvim-flutter/flutter-tools.nvim',
    		lazy = false,
    		dependencies = {
    		    'nvim-lua/plenary.nvim',
    		    'stevearc/dressing.nvim', -- optional for vim.ui.select
    		},
    		config = true,
			},
		})
		require("flutter-tools").setup{}
