-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local vim = vim
local api = vim.api

local function augroup(name)
  return api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

api.nvim_create_autocmd(
  { "BufReadPost", "FileReadPost" },
  { pattern = "*", command = "normal zR", group = augroup("format_group") }
)
