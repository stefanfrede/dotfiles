local status_ok, copilot = pcall(require, "copilot")
if not status_ok then
  return
end

local panel = {
  enabled = true,
  auto_refresh = false,
  keymap = {
    jump_prev = "[[",
    jump_next = "]]",
    accept = "<CR>",
    refresh = "gr",
    open = "<M-CR>",
  },
}

local suggestion = {
  enabled = true,
  auto_trigger = false,
  debounce = 75,
  keymap = {
    accept = "<M-l>",
    accept_word = false,
    accept_line = false,
    next = "<M-]>",
    prev = "<M-[>",
    dismiss = "<C-]>",
  },
}

local filetypes = {
  yaml = false,
  markdown = false,
  help = false,
  gitcommit = false,
  gitrebase = false,
  hgcommit = false,
  svn = false,
  cvs = false,
  ["."] = false,
}

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    vim.defer_fn(function()
      copilot.setup {
        panel = panel,
        suggestion = suggestion,
        filetypes = filetypes,
        copilot_node_command = "/home/sfrede/.asdf/installs/nodejs/16.19.0/bin/node", -- Node.js version must be > 16.x
        server_opts_overrides = {},
      }
    end, 100)
  end,
})
