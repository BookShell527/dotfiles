lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "onedarker"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
lvim.relativenumber = true
lvim.keys.normal_mode["<S-Tab>"] = ":BufferPrevious<cr>"
lvim.keys.normal_mode["<Tab>"] = ":BufferNext<cr>"
lvim.keys.normal_mode["<C-S-Tab"] = ":BufferMovePrevious<cr>"
lvim.keys.normal_mode["<C-Tab>"] = ":BufferMoveNext<cr>"
lvim.keys.normal_mode["<C-a>"] = ":FlutterOutlineToggle<cr>"
lvim.keys.normal_mode["mw"] = ":BufferClose<cr>"
lvim.keys.normal_mode["K"] = ":lua vim.lsp.diagnostic.show_line_diagnostics()<cr>"
lvim.keys.normal_mode["Z"] = ":lua vim.lsp.buf.hover()<cr>"
lvim.keys.normal_mode["gD"] = ":lua vim.lsp.buf.declaration()<cr>"
lvim.keys.normal_mode["gd"] = ":lua vim.lsp.buf.definition()<cr>"
lvim.keys.normal_mode["<C-l>"] = "<C-w>l"
lvim.keys.normal_mode["<C-k>"] = "<C-w>k"
lvim.keys.normal_mode["<C-j>"] = "<C-w>j"
lvim.keys.normal_mode["<C-h>"] = "<C-w>h"
lvim.keys.normal_mode["<leader>H"] = ":execute 5 .. 'new +terminal' | let b:term_type = 'hori' | startinsert<cr>"
lvim.keys.normal_mode["<leader>v"] = ":execute 'vnew +terminal' | let b:term_type = 'vert' | startinsert<cr>"
lvim.keys.normal_mode["<leader>r"] = ":resize5<cr>"
-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0
lvim.builtin.nvimtree.setup.view.width = 20

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- Additional Plugins
lvim.plugins = {
  {"norcalli/nvim-colorizer.lua"},
  {"lukas-reineke/indent-blankline.nvim"},
  {"akinsho/flutter-tools.nvim", requires = "nvim-lua/plenary.nvim"},
  {"kristijanhusak/orgmode.nvim"},
  {"vimwiki/vimwiki"},
  {"mattn/emmet-vim"},
  {"TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim"}
}

require("indent_blankline").setup {
  char = "|",
  buftype_exclude = {"terminal"}
}

require'colorizer'.setup(
  {"*";},
  {
    RGB      = true;
	  RRGGBB   = true;
	  names    = true;
	  RRGGBBAA = false;
	  rgb_fn   = false;
	  hsl_fn   = false;
	  css      = false;
	  css_fn   = false;
  }
)
require("flutter-tools").setup{
  line_length = 120
}
require'lspconfig'.tailwindcss.setup{}
require'luasnip'.filetype_extend("dart", {"flutter"})
require('neogit').setup{}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
--lvim.autocommands.custom_groups = {
--  { "BufWinEnter", "*", "setlocal relativenumber" },
--}
