-- NOTE: it won't run if it's started after nvim has already started
-- function cond() return (vim.fn.has("macunix") == 1 and vim.system({ "pgrep", "llama-server" }):wait().code == 0) end

return {
  "ggml-org/llama.vim",
  enabled = false,
  -- cond = cond(),
  init = function()
    vim.g.llama_config = {
      -- auto_fim = false,
      keymap_accept_full = "<C-S>",
      keymap_accept_line = "<Right>",
      show_info = false,
    }
  end,
}
