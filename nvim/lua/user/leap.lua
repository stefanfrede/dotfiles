local M = {
  "ggandor/leap.nvim",
  commit = "6f2912755c9c4ae790abd829f0cf1b07c037b2a4",
  event = "InsertEnter",
  dependencies = {
    {
      "tpope/vim-repeat",
      commit = "24afe922e6a05891756ecf331f39a1f6743d3d5a",
    },
  },
}

function M.config()
  local status_ok, leap = pcall(require, "leap")
  if not status_ok then
    return
  end

  leap.add_default_mappings()
end

return M
