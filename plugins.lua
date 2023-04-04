local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
    enabled = false,
  },
  {
    "NvChad/nvterm",
    enabled = false,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = overrides.blankline,
  },
  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
  {
    "Pocco81/TrueZen.nvim",
    cmd = { "TZAtaraxis", "TZMinimalist" },
    config = function() end,
  },
  {
    -- only needed if you want to use the commands with "_with_window_picker" suffix
    "s1n7ax/nvim-window-picker",
    config = function()
      require("window-picker").setup {
        autoselect_one = true,
        include_current = false,
        filter_rules = {
          -- filter using buffer options
          bo = {
            -- if the file type is one of following, the window will be ignored
            filetype = { "neo-tree", "neo-tree-popup", "notify" },

            -- if the buffer type is one of following, the window will be ignored
            buftype = { "terminal", "quickfix" },
          },
        },
        other_win_hl_color = "#000000",
      }
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      "s1n7ax/nvim-window-picker",
    },
    cmd = "Neotree",
    init = function()
      vim.g.neo_tree_remove_legacy_commands = true
    end,
    config = require "custom.configs.neo-tree",
  },
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    cmd = "Barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    init = function()
      require("core.utils").lazy_load "barbecue"
    end,
    opts = {
      -- configurations go here
    },
    config = function()
      require("barbecue").setup()
    end,
  },
  { "akinsho/toggleterm.nvim", cmd = { "ToggleTerm", "TermExec" }, opts = overrides.ToggleTerm },
  {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit", "LazyGitFilter", "LazyGitFilterCurrentFile" },
    ops = overrides.LazyGit,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false,
    opts = overrides.TodoComments,
    config = function()
      require("todo-comments").setup()
    end,
  },

  {
    "RRethy/nvim-treesitter-textsubjects",
    lazy = false,
    opts = overrides.TreesitterTextSubjects,
    config = function()
      require("treesitter-context").setup { enable = true }
    end,
  },
  {
    "romgrk/nvim-treesitter-context",
    lazy = false,
  },
  {
    "phaazon/hop.nvim",
    branch = "v2",
    cmd = { "HopWord", "HopChar1", "HopChar2", "HopLine", "HopLineStart", "HopAnywhere" },
    opts = {},
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require("lsp_signature").setup()
    end,
  },
  { "mattn/emmet-vim", lazy = false },
  { "https://github.com/preservim/tagbar" },
  { "bps/vim-textobj-python", lazy = false },
  { "kana/vim-textobj-user", lazy = false },
  { "tpope/vim-surround", lazy = false, },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
    opts = overrides.Trouble,
  },
  {
		'nvim-lualine/lualine.nvim',
    lazy=false,
		dependencies = { 'nvim-tree/nvim-web-devicons', },
    opts=overrides.lualine,
    config = function(_, opts)
      require('custom.configs.lualine')
    end
	},
  {
    "kdheepak/tabline.nvim",
    lazy = false,
    opts = overrides.tabline,
    config = function(_, opts)
      require("tabline").setup(opts)
      vim.cmd [[
      set guioptions-=e " Use showtabline in gui vim
      set sessionoptions+=tabpages,globals " store tabpages and globals in session
      ]]
    end,
  },
  {
    "tiagovla/scope.nvim",
    lazy=false,
    config = function()
      require('scope').setup()
    end
  },

}

return plugins
