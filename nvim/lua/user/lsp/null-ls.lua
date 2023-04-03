local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

-- register sources
local sources = {
  diagnostics.eslint.with {
    prefer_local = "node_modules/.bin",
    condition = function(utils)
      return utils.root_has_file {
        ".eslintrc.json",
      }
    end,
  },
  diagnostics.stylelint.with {
    filetypes = { "scss", "less", "css", "sass", "vue" },
    prefer_local = "node_modules/.bin",
    condition = function(utils)
      return utils.root_has_file {
        ".stylelintrc.json",
      }
    end,
  },
  formatting.deno_fmt.with {
    condition = function(utils)
      return utils.root_has_file {
        "deno.json",
        "deno.jsonc",
      }
    end,
  },
  formatting.eslint.with {
    prefer_local = "node_modules/.bin",
    condition = function(utils)
      return utils.root_has_file {
        ".eslintrc.json",
      }
    end,
  },
  formatting.prettier.with {
    extra_filetypes = { "toml" },
    prefer_local = "node_modules/.bin",
  },
  formatting.stylelint.with {
    filetypes = { "scss", "less", "css", "sass", "vue" },
    prefer_local = "node_modules/.bin",
    condition = function(utils)
      return utils.root_has_file {
        ".stylelintrc.json",
      }
    end,
  },
  formatting.stylua,
}

null_ls.setup {
  debug = false,
  sources = sources,
}
