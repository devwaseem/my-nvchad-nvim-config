local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  b.formatting.prettier.with { filetypes = { "html", "markdown", "css", "scss" }, disabled_filetypes = { "htmldjango" } }, -- so prettier works only on these filetypes

  -- Lua
  b.formatting.stylua,

  -- [[Python]]
  -- Formatters
  b.formatting.isort,
  b.formatting.black,
  -- Linters
  b.diagnostics.flake8.with {
    method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
  },
  b.diagnostics.pylint.with {
    prefer_local = ".venv/bin",
    method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
  },
}

null_ls.setup {
  debug = true,
  sources = sources,
}
