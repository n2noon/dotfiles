return {
  "ggml-org/llama.vim",
  enabled = false,
  init = function()
    vim.g.llama_config = {
      -- auto_fim = false,
      keymap_accept_full = "<C-S>",
      keymap_accept_line = "<Right>",
      show_info = false,
    }
  end,
}
