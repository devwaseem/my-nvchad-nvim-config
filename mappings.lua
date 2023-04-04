---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>w"] = { "<cmd> w <CR>", "save file" },
    -- Improved navigation
    ["<C-d>"] = { "<C-d>zz", "Scroll down" },
    ["<C-u>"] = { "<C-u>zz", "Scroll up" },
    -- Improved Paste
    ["<leader>p"] = { '"_dP', "Paste without overriding the buffer" },
    -- Splits navigation
    ["<A-Up>"] = { "<C-w>k", "Move to above split" },
    ["<A-Down>"] = { "<C-w>j", "Move to below split" },
    ["<A-Left>"] = { "<C-w>h", "Move to left split" },
    ["<A-Right>"] = { "<C-w>l", "Move to right split" },
    -- Trouble
    ["<leader>x"] = { "" },
    ["<leader>xx"] = { "<cmd>TroubleToggle<cr>", "Toggle Trouble" },
    ["<leader>xw"] = {
      "<cmd>TroubleToggle workspace_diagnostics<cr>",
      "Toggle Trouble for Workspace diagnostics",
    },
    ["<leader>xd"] = {
      "<cmd>TroubleToggle document_diagnostics<cr>",
      "Toggle Trouble for Document diagnostics",
    },
    ["<leader>xl"] = { "<cmd>TroubleToggle loclist<cr>", "Toggle Trouble Local List" },
    ["<leader>xq"] = { "<cmd>TroubleToggle quickfix<cr>", "Toggle Trouble for Quick Fix" },
    ["gR"] = { "<cmd>TroubleToggle lsp_references<cr>", "Toggle Trouble for LSP References" },
    ["<leader>c"] = {
      "<cmd> bdelete <cr>",
      "close buffer",
    },
  },

  v = {
    ["J"] = { ":m '>+1<CR>gv=gv", "Move selected visual down" },
    ["K"] = { ":m '<-2<CR>gv=gv", "Move selected visual down" },
  },

  t = {
    -- Improved Terminal Navigation
    ["<C-h>"] = { "<cmd>wincmd h<cr>", "Terminal left window navigation" },
    ["<C-j>"] = { "<cmd>wincmd j<cr>", "Terminal down window navigation" },
    ["<C-k>"] = { "<cmd>wincmd k<cr>", "Terminal up window navigation" },
    ["<C-l>"] = { "<cmd>wincmd l<cr>", "Terminal right window navigation" },
  },
}

M.neotree = {
  n = {
    ["<leader>e"] = { "<cmd>Neotree toggle<cr>", "Toggle Explorer" },
    ["<leader>o"] = {
      function()
        if vim.bo.filetype == "neo-tree" then
          vim.cmd.wincmd "p"
        else
          vim.cmd.Neotree "focus"
        end
      end,
      "Toggle Explorer Focus",
    },
  },
}

M.lspconfig = {
  n = {
    ["gd"] = {
      function()
        require("telescope.builtin").lsp_definitions()
      end,
      "lsp definition",
    },
    ["gr"] = {
      function()
        require("telescope.builtin").lsp_references()
      end,
      "lsp references",
    },
    ["gi"] = {
      function()
        require("telescope.builtin").lsp_implementations()
      end,
      "lsp implementation",
    },
    ["<leader>lr"] = {
      function()
        require("nvchad_ui.renamer").open()
      end,
      "lsp rename",
    },
    ["<leader>la"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "lsp code_action",
    },
    ["<leader>f"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "lsp formatting",
    },
    ["<leader>df"] = {
      function()
        vim.diagnostic.open_float { border = "rounded" }
      end,
      "floating diagnostic",
    },
  },
}

M.telescope = {
  n = {

    ["<leader>gm"] = { "<cmd> Telescope git_commits <CR>", "git commits" },
    ["<leader>gs"] = { "<cmd> Telescope git_status <CR>", "git status" },
    ["<leader>fk"] = { "<cmd> Telescope keymaps <CR>", "keymaps" },
    ["<leader>f/"] = {
      function()
        require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end,
      "[/] Fuzzily search in current buffer",
    },
    ["<leader>fc"] = {
      function()
        require("telescope.builtin").grep_string()
      end,
      "Find for word under cursor",
    },
    ["<leader>fW"] = {
      function()
        require("telescope.builtin").live_grep {
          additional_args = function(args)
            return vim.list_extend(args, { "--hidden", "--no-ignore" })
          end,
        }
      end,
      "Find words in all files",
    },
    ["<leader>lD"] = {
      function()
        require("telescope.builtin").diagnostics()
      end,
      "Search diagnostics",
    },
    ["<leader>ls"] = {
      function()
        local aerial_avail, _ = pcall(require, "aerial")
        if aerial_avail then
          require("telescope").extensions.aerial.aerial()
        else
          require("telescope.builtin").lsp_document_symbols()
        end
      end,
      "Search symbols",
    },

    -- theme switcher
    ["<leader>ft"] = { "<cmd> Telescope themes <CR>", "nvchad themes" },
  },
}

M.ToggleTerm = {
  t = {
    -- toggle in terminal mode
    ["<C-\\>"] = {
      "<cmd>ToggleTerm direction=float<cr>",
      "Toggle floating term",
    },
    ["<leader>th"] = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "ToggleTerm horizontal split" },
    ["<leader>tv"] = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "ToggleTerm vertical split" },
  },

  n = {
    -- toggle in normal mode
    ["<C-\\>"] = {
      "<cmd>ToggleTerm direction=float<cr>",
      "toggle floating term",
    },
    ["<leader>th"] = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "ToggleTerm horizontal split" },
    ["<leader>tv"] = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "ToggleTerm vertical split" },
  },
}

M.Tabs = {
  n = {
    ["<TAB>"] = {
      "<cmd> bnext <cr>",
      "goto next buffer",
    },

    ["<S-Tab>"] = {
      "<cmd> bprevious <cr>",
      "goto prev buffer",
    },
    ["<S-l>"] = {
      "<cmd> tabnext <cr>",
      "Move to Next Buffer",
    },
    ["<S-h>"] = {
      "<cmd> tabprevious <cr>",
      "Move to Prev Buffer",
    },
  },
}

M.gitsigns = {
  n = {
    ["]g"] = {
      function()
        require("gitsigns").next_hunk()
      end,
      "Next Git hunk",
    },
    ["[g"] = {
      function()
        require("gitsigns").prev_hunk()
      end,
      "Previous Git hunk",
    },
    ["<leader>gl"] = {
      function()
        require("gitsigns").blame_line()
      end,
      "View Git blame",
    },
    ["<leader>gp"] = {
      function()
        require("gitsigns").preview_hunk()
      end,
      "Preview Git hunk",
    },
    ["<leader>gh"] = {
      function()
        require("gitsigns").reset_hunk()
      end,
      "Reset Git hunk",
    },
    ["<leader>gr"] = {
      function()
        require("gitsigns").reset_buffer()
      end,
      "Reset Git buffer",
    },
    ["<leader>gs"] = {
      function()
        require("gitsigns").stage_hunk()
      end,
      "Stage Git hunk",
    },
    ["<leader>gS"] = {
      function()
        require("gitsigns").stage_buffer()
      end,
      "Stage Git buffer",
    },
    ["<leader>gu"] = {
      function()
        require("gitsigns").undo_stage_hunk()
      end,
      "Unstage Git hunk",
    },
    ["<leader>gd"] = {
      function()
        require("gitsigns").diffthis()
      end,
      "View Git diff",
    },
  },
}

M.LazyGit = {
  n = {
    ["<leader>gg"] = { "<CMD> LazyGit <cr>", "Toggle Lazy Git" },
  },
}

M.hop = {
  n = {
    ["s"] = { "<cmd>HopChar1<cr>", "Hop using 1 char" },
    ["S"] = { "<cmd>HopChar2<cr>", "Hop using 2 char" },
    ["sl"] = { "<cmd>HopLineStart<cr>", "Hop to the line start" },
    ["sw"] = { "<cmd>HopWord<cr>", "Hop to a word" },
    ["sa"] = { "<cmd>HopAnywhere<cr>", "Hop Anywhere" },
    ["f"] = {
      function()
        require("hop").hint_char1 {
          direction = require("hop.hint").HintDirection.AFTER_CURSOR,
          current_line_only = true,
        }
      end,
      "Find a character in current line after the cursor",
    },
    ["F"] = {
      function()
        require("hop").hint_char1 {
          direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
          current_line_only = true,
        }
      end,
      "Find a character in current line before the cursor",
    },
    ["t"] = {
      function()
        require("hop").hint_char1 {
          direction = require("hop.hint").HintDirection.AFTER_CURSOR,
          current_line_only = true,
          hint_offset = -1,
        }
      end,
      "Jump a character in current line after the cursor",
    },
    ["T"] = {
      function()
        require("hop").hint_char1 {
          direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
          current_line_only = true,
          hint_offset = -1,
        }
      end,
      "Jump a character in current line before the cursor",
    },
  },

  v = {
    ["s"] = { "<cmd>HopChar1<cr>", "Hop using 1 char" },
    ["S"] = { "<cmd>HopChar2<cr>", "Hop using 2 char" },
    ["sl"] = { "<cmd>HopLineStart<cr>", "Hop to the line start" },
    ["sw"] = { "<cmd>HopWord<cr>", "Hop to a word" },
    ["sa"] = { "<cmd>HopAnywhere<cr>", "Hop Anywhere" },
    ["f"] = {
      function()
        require("hop").hint_char1 {
          direction = require("hop.hint").HintDirection.AFTER_CURSOR,
          current_line_only = true,
        }
      end,
      "Find a character in current line after the cursor",
    },
    ["F"] = {
      function()
        require("hop").hint_char1 {
          direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
          current_line_only = true,
        }
      end,
      "Find a character in current line before the cursor",
    },
    ["t"] = {
      function()
        require("hop").hint_char1 {
          direction = require("hop.hint").HintDirection.AFTER_CURSOR,
          current_line_only = true,
          hint_offset = -1,
        }
      end,
      "Jump a character in current line after the cursor",
    },
    ["T"] = {
      function()
        require("hop").hint_char1 {
          direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
          current_line_only = true,
          hint_offset = -1,
        }
      end,
      "Jump a character in current line before the cursor",
    },
  },
}

return M
