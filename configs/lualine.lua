local colors = require("base46").get_theme_tb "base_30"

local theme = {
  normal = {
    a = { fg = colors.black2, bg = colors.red },
    b = { fg = colors.grey_fg, bg = colors.black2 },
    c = { fg = colors.white, bg = colors.black },
    z = { fg = colors.white, bg = colors.black },
  },
  insert = { a = { fg = colors.black, bg = colors.red } },
  visual = { a = { fg = colors.black, bg = colors.green } },
  replace = { a = { fg = colors.black, bg = colors.green } },
}

local vim_icons = {
  function()
    return ""
  end,
  separator = { left = "", right = "" },
  color = { bg = colors.one_bg, fg = colors.red },
}

local space = {
  function()
    return " "
  end,
  color = { bg = colors.black, fg = colors.red },
}

local filename = {
  "filename",
  color = { bg = colors.one_bg, fg = colors.red },
  separator = { left = "", right = "" },
}

local filetype = {
  "filetype",
  icon_only = true,
  colored = true,
  color = { bg = "#313244" },
  separator = { left = "", right = "" },
}

local buffer = {
  require("tabline").tabline_buffers,
  separator = { left = "", right = "" },
}

local tabs = {
  require("tabline").tabline_tabs,
  separator = { left = "", right = "" },
}

local fileformat = {
  "fileformat",
  color = { bg = "#b4befe", fg = "#313244" },
  separator = { left = "", right = "" },
}

local encoding = {
  "encoding",
  color = { bg = colors.one_bg, fg = colors.blue },
  separator = { left = "", right = "" },
}

local branch = {
  "branch",
  color = { bg = colors.black2, fg = colors.light_grey },
  separator = { left = "", right = "" },
  on_click = function()
    vim.cmd "LazyGit"
  end,
}

local diff = {
  "diff",
  colored = true,
  diff_color = {
    added = { bg = colors.black2, fg = colors.green }, -- Changes the diff's added color
    modified = { bg = colors.black2, fg = colors.blue }, -- Changes the diff's modified color
    removed = { bg = colors.black2, fg = colors.red }, -- Changes the diff's removed color you
  },
  symbols = { added = " ", modified = " ", removed = " " },
  separator = { left = "", right = "" },
}

local modes = {
  "mode",
  fmt = function(str)
    return str:sub(1, 1)
  end,
  color = { bg = colors.red, fg = colors.black2 },
  separator = { left = "", right = "" },
}

local brand = {
  function()
    return "WAAK Labs"
  end,
  color = { bg = colors.red, fg = colors.black2 },
  -- separator = { left = "", right = "" },
  separator = { left = "", right = "" },
}

-- local function get_lsp_name()
--   local msg = "No Active Lsp"
--   local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
--   local clients = vim.lsp.get_active_clients()
--   if next(clients) == nil then
--     return msg
--   end
--   for _, client in ipairs(clients) do
--     local filetypes = client.config.filetypes
--     if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
--       return "  " .. client.name
--     end
--   end
--   return "  " .. msg
-- end


local function get_lsp_clients()
  local registered = {}
  local clients = vim.lsp.get_active_clients()
  for _, client in ipairs(clients) do
    if client.name ~= "null-ls" then
      table.insert(registered, client.name)
    end
  end
  return registered
end


local function get_lsp_name()
  local msg = "No Active Lsp"
  local clients = get_lsp_clients()
  if next(clients) == nil then
    return msg
  end

  return "  " .. table.concat(clients, ", ")
end

local function get_null_sources()
  local registered = {}
  local sources_avail, sources = pcall(require, "null-ls.sources")
  if not sources_avail then
    return ""
  end
  local methods = {
    "NULL_LS_DIAGNOSTICS",
    "NULL_LS_DIAGNOSTICS_ON_OPEN",
    "NULL_LS_DIAGNOSTICS_ON_SAVE",
    "NULL_LS_FORMATTING",
    "NULL_LS_RANGE_FORMATTING"
  }
  for _, method in ipairs(methods) do
    for _, source in pairs(sources.get_available(vim.bo.filetype, method)) do
      local tool = source.name
      if registered[tool] == nil then
        registered[tool] = tool
      end
    end
  end
  local tools = {}
  for _, tool in pairs(registered) do
    table.insert(tools, tool)
  end
  return table.concat(tools, ", ")
end

local dia = {
  "diagnostics",
  color = { bg = colors.one_bg2, fg = colors.blue },
  separator = { left = "", right = "" },
}

local lsp = {
  function()
    return get_lsp_name()
  end,
  separator = { left = "", right = "" },
  color = { bg = colors.red, fg = colors.black2 },
}

local null_ls_sources = {
  function()
    return get_null_sources()
  end,
  separator = { left = "", right = "" },
  color = { bg = colors.one_bg3, fg = colors.red },
}

require("lualine").setup {

  options = {
    icons_enabled = true,
    theme = theme,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  },

  sections = {
    lualine_a = {
      --{ 'mode', fmt = function(str) return str:gsub(str, "  ") end },
      modes,
      vim_icons,
      --{ 'mode', fmt = function(str) return str:sub(1, 1) end },
    },
    lualine_b = {
      space,
    },
    lualine_c = {
      filename,
      branch,
      diff,
    },
    lualine_x = {
      space,
    },
    lualine_y = {
      space,
    },
    lualine_z = {
      encoding,
      dia,
      null_ls_sources,
      lsp,
      space,
      brand,
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {
    lualine_a = {
      buffer,
    },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {
      tabs,
    },
    lualine_y = {},
    lualine_z = {},
  },
  winbar = {},
  inactive_winbar = {},
}
