local status_ok, move = pcall(require, "move")
if not status_ok then
	return
end

move.setup({
	max_aot_targets = nil,
	highlight_unlabeled = false,
	case_sensitive = false,
	-- Sets of characters that should match each other.
	-- Obvious candidates are braces and quotes ('([{', ')]}', '`"\'').
	equivalence_classes = { " \t\r\n" },
	-- Leaving the appropriate list empty effectively disables "smart" mode,
	-- and forces auto-jump to be on or off.
	safe_labels = { "s", "f", "n", "u", "t", "/", "S", "F", "N", "L", "H", "M", "U", "G", "T", "?", "Z" },
	labels = {
		"s",
		"f",
		"n",
		"j",
		"k",
		"l",
		"h",
		"o",
		"d",
		"w",
		"e",
		"m",
		"b",
		"u",
		"y",
		"v",
		"r",
		"g",
		"t",
		"c",
		"x",
		"/",
		"z",
		"S",
		"F",
		"N",
		"J",
		"K",
		"L",
		"H",
		"O",
		"D",
		"W",
		"E",
		"M",
		"B",
		"U",
		"Y",
		"V",
		"R",
		"G",
		"T",
		"C",
		"X",
		"?",
		"Z",
	},
	-- These keys are captured directly by the plugin at runtime.
	-- (For `prev_match`, I suggest <s-enter> if possible in the terminal/GUI.)
	special_keys = {
		repeat_search = "<enter>",
		next_match = "<enter>",
		prev_match = "<tab>",
		next_group = "<space>",
		prev_group = "<tab>",
	},
})
