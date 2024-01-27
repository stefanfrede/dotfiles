return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        ["twig"] = { "djlint" },
      },
      formatters = {
        djlint = {
          args = { "--reformat", "-" },
          cwd = require("conform.util").root_file({
            ".djlintrc",
          }),
        },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        twig = { "djlint" },
      },
    },
  },
}
