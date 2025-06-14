M = {}

M.content = {
    active = function()
    local git         = MiniStatusline.section_git(        { trunc_width = 40 })
    local diff        = MiniStatusline.section_diff(       { trunc_width = 75 })
    local lsp         = MiniStatusline.section_lsp(        { trunc_width = 75 })
    local filename    = MiniStatusline.section_filename(   { trunc_width = 140})
    local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
    -- local fileinfo = MiniStatusline.section_fileinfo({
    --   trunc_width = 120,
    --
    -- })
    -- local location = MiniStatusline.section_location({ trunc_width = 9999 })
    -- local search = MiniStatusline.section_searchcount({ trunc_width = 75 })

    return MiniStatusline.combine_groups({
      { hl = "MiniStatuslineDevinfo", strings = { git, diff, lsp } },
      "%<", -- Mark general truncate point
      { hl = "MiniStatuslineFilename", strings = { filename } },
      "%=", -- End left alignment
      { hl = "MiniStatuslineFileinfo", strings = { diagnostics } },
      -- { hl = mode_hl, strings = { search } },
    })
  end
}

return M
