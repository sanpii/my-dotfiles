require("telescope").setup({
    extensions = {
        undo = {},
    },
})
require("telescope").load_extension("undo")
vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
