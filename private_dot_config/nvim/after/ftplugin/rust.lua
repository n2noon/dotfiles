vim.bo.makeprg = "cargo build"

--stylua: ignore start
vim.keymap.set("n", "<leader>cc", "<cmd>!cargo check<CR>",  { desc = "Cargo check<CR>" })
vim.keymap.set("n", "<leader>cb", "<cmd>!cargo build<CR>",  { desc = "Cargo build<CR>" })
vim.keymap.set("n", "<leader>cr", "<cmd>!cargo run<CR>",    { desc = "Cargo run<CR>" })
vim.keymap.set("n", "<leader>ct", "<cmd>!cargo test<CR>",   { desc = "Cargo test<CR>" })
vim.keymap.set("n", "<leader>cd", "<cmd>!cargo doc<CR>",    { desc = "Cargo doc<CR>" })
vim.keymap.set("n", "<leader>ci", "<cmd>!cargo clippy<CR>", { desc = "Cargo clippy<CR>" })
vim.keymap.set("n", "<leader>cp", "<cmd>!cargo fmt<CR>",    { desc = "Cargo fmt<CR>" })
--stylua: ignore end

-- Highlight rust todo!().
vim.b.minihipatterns_config = {
    highlighters = {
        rust_todo = { pattern = 'todo!', group = 'MiniHipatternsTodo' },
    },
}
