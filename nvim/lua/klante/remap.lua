vim.g.mapleader = " "

vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "Q", "<nop>")

local sessionizer = vim.fn.expand("$HOME/.dotfiles/tmux/tmux-sessionizer/tmux-sessionizer")
vim.keymap.set("n", "<C-f>", function()
    local escaped = vim.fn.shellescape(sessionizer)
    if vim.env.TMUX and vim.env.TMUX ~= "" then
        vim.cmd("silent !tmux new-window " .. escaped)
    else
        vim.cmd("silent !" .. escaped)
    end
end, { desc = "tmux-sessionizer" })

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
