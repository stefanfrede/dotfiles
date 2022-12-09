local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
	ensure_installed = {
		"bash",
		"comment",
		"css",
		"dockerfile",
		"fish",
		"graphql",
		"html",
		"javascript",
		"jsdoc",
		"json",
		"lua",
		"regex",
		"scss",
		"toml",
		"typescript",
		"vim",
		"vue",
	}, -- one of "all", or a list of languages
	ignore_install = { "" }, -- List of parsers to ignore installing
	sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "" }, -- list of language that will be disabled
	},
	autopairs = {
		enable = true,
	},
	indent = {
    enable = true,
    disable = { "yaml" },
  },
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
})
