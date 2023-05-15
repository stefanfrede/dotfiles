local M = {
  "jose-elias-alvarez/null-ls.nvim",
  event = "BufReadPre",
  commit = "60b4a7167c79c7d04d1ff48b55f2235bf58158a7",
  dependencies = {
    {
      "nvim-lua/plenary.nvim",
      commit = "9a0d3bf7b832818c042aaf30f692b081ddd58bd9",
      lazy = true,
    },
  },
}

function M.config()
  local null_ls = require "null-ls"
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
  local formatting = null_ls.builtins.formatting
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
  local diagnostics = null_ls.builtins.diagnostics

  -- https://github.com/prettier-solidity/prettier-plugin-solidity
  null_ls.setup {
    debug = false,
    sources = {
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
    },
  }
end

return M
