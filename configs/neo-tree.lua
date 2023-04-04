local global_commands = {
  system_open = function(state)
    local path = state.tree:get_node():get_id()
    local job_id = vim.fn.jobstart("open " .. path, { detach = true })
    if job_id <= 0 then
      print("Failed to open system finder for " .. path)
    end
  end,

  copy_selector = function(state)
    local node = state.tree:get_node()
    local filepath = node:get_id()
    local filename = node.name
    local modify = vim.fn.fnamemodify

    local results = {
      e = { val = modify(filename, ":e"), msg = "Extension only" },
      f = { val = filename, msg = "Filename" },
      F = { val = modify(filename, ":r"), msg = "Filename w/o extension" },
      h = { val = modify(filepath, ":~"), msg = "Path relative to Home" },
      p = { val = modify(filepath, ":."), msg = "Path relative to CWD" },
      P = { val = filepath, msg = "Absolute path" },
    }

    local messages = {
      { "\nChoose to copy to clipboard:\n", "Normal" },
    }
    for i, result in pairs(results) do
      if result.val and result.val ~= "" then
        vim.list_extend(messages, {
          { ("%s."):format(i), "Identifier" },
          { (" %s: "):format(result.msg) },
          { result.val, "String" },
          { "\n" },
        })
      end
    end
    vim.api.nvim_echo(messages, false, {})
    local result = results[vim.fn.getcharstr()]
    if result and result.val and result.val ~= "" then
      vim.notify("Copied: " .. result.val)
      vim.fn.setreg("+", result.val)
    end
  end,
}

return function()
  require("neo-tree").setup {
    auto_clean_after_session_restore = true,
    close_if_last_window = true,
    source_selector = {
      winbar = true,
      content_layout = "center",
    },
    window = {
      mappings = {
        ["<space>"] = false, -- disable space until we figure out which-key disabling
        ["[b"] = "prev_source",
        ["]b"] = "next_source",
        o = "open",
        h = "toggle_hidden",
        O = "system_open",
        Y = "copy_selector",
      },
    },
    filesystem = {
      follow_current_file = true,
      hijack_netrw_behavior = "open_current",
      use_libuv_file_watcher = true,
      commands = global_commands,
    },
    buffers = { commands = global_commands },
    git_status = { commands = global_commands },
    diagnostics = { commands = global_commands },
    event_handlers = {
      {
        event = "neo_tree_buffer_enter",
        handler = function(_)
          vim.opt_local.signcolumn = "auto"
        end,
      },
    },
  }
end
