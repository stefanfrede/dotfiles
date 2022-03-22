local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = false,
	sources = {
		formatting.eslint.with({
			prefer_local = "node_modules/.bin",
		}),
		formatting.prettier.with({
			prefer_local = "node_modules/.bin",
		}),
		formatting.stylelint.with({
			filetypes = { "scss", "less", "css", "sass", "vue" },
			prefer_local = "node_modules/.bin",
		}),
		formatting.stylua,
		diagnostics.eslint.with({
			prefer_local = "node_modules/.bin",
		}),
		diagnostics.stylelint.with({
			filetypes = { "scss", "less", "css", "sass", "vue" },
			prefer_local = "node_modules/.bin",
		}),
	},
})
