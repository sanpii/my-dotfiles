require("telescope").setup({
    extensions = {
        undo = {
            layout_config = {
                preview_width = 0.7,
            },
            mappings = {
                i = {
                    ["<cr>"] = require("telescope-undo.actions").restore,
                },
            },
        },
    },
})
require("telescope").load_extension("undo")
vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
