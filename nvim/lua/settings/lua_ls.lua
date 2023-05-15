return {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim", "lvim", "reload" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
}
