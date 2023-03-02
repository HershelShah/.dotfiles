local telescope = require("telescope")
local actions = require("telescope.actions")
local config = require("telescope.config")
local vimgrep_arguments = { unpack(config.values.vimgrep_arguments) }
local job = require("plenary.job")
local previewers = require("telescope.previewers")
local builtin = require('telescope.builtin')
local fb_actions = require("telescope._extensions.file_browser.actions")

-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")
-- I don't want to search in the `.git` directory.
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")

local new_maker = function(filepath, bufnr, opts)
    filepath = vim.fn.expand(filepath)
    job:new({
        command = "file",
        args = { "--mime-type", "-b", filepath },
        on_exit = function(j)
            local mime_type = vim.split(j:result()[1], "/")[1]
            if mime_type == "text" then
                previewers.buffer_previewer_maker(filepath, bufnr, opts)
            else
                -- maybe we want to write something to the buffer here
                vim.schedule(function()
                    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
                end)
            end
        end
    }):sync()
end

telescope.setup({
    defaults = {
        vimgrep_arguments = vimgrep_arguments,
        buffer_previewer_maker = new_maker,
        -- Default configuration for telescope goes here:
        -- config_key = value,
        mappings = {
            i = {
                -- map actions.which_key to <C-h> (default: <C-/>)
                -- actions.which_key shows the mappings for your picker,
                -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                -- ["<C-h>"] = "which_key",
                ["<ESC>"] = actions.close,
                ["<C-d>"] = actions.delete_buffer + actions.move_to_top,
                ['<C-g>'] = function(prompt_bufnr)
                    -- Use nvim-window-picker to choose the window by dynamically attaching a function
                    local action_set = require('telescope.actions.set')
                    local action_state = require('telescope.actions.state')

                    local picker = action_state.get_current_picker(prompt_bufnr)
                    picker.get_selection_window = function(picker, entry)
                        local picked_window_id = require('window-picker').pick_window() or vim.api.nvim_get_current_win()
                        -- Unbind after using so next instance of the picker acts normally
                        picker.get_selection_window = nil
                        return picked_window_id
                    end

                    return action_set.edit(prompt_bufnr, 'edit')
                end,
            }
        }
    },
    pickers = {
            find_files = {
                find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
            },
        },
        extensions = {
                file_browser = {
                    cwd_to_path = false,
                    grouped = false,
                    files = true,
                    add_dirs = true,
                    depth = 1,
                    auto_depth = false,
                    select_buffer = false,
                    hidden = false,
                    hide_parent_dir = false,
                    collapse_dirs = false,
                    quiet = false,
                    dir_icon = "",
                    dir_icon_hl = "Default",
                    display_stat = { date = true, size = true },
                    hijack_netrw = false,
                    use_fd = true,
                    git_status = true,
                    mappings = {
                        ["i"] = {
                            ["<A-c>"] = fb_actions.create,
                            ["<S-CR>"] = fb_actions.create_from_prompt,
                            ["<A-r>"] = fb_actions.rename,
                            ["<A-m>"] = fb_actions.move,
                            ["<A-y>"] = fb_actions.copy,
                            ["<A-d>"] = fb_actions.remove,
                            ["<C-o>"] = fb_actions.open,
                            ["<C-g>"] = fb_actions.goto_parent_dir,
                            ["<C-e>"] = fb_actions.goto_home_dir,
                            ["<C-w>"] = fb_actions.goto_cwd,
                            ["<C-t>"] = fb_actions.change_cwd,
                            ["<C-f>"] = fb_actions.toggle_browser,
                            ["<C-h>"] = fb_actions.toggle_hidden,
                            ["<C-s>"] = fb_actions.toggle_all,
                        },
                        ["n"] = {
                            ["c"] = fb_actions.create,
                            ["r"] = fb_actions.rename,
                            ["m"] = fb_actions.move,
                            ["y"] = fb_actions.copy,
                            ["d"] = fb_actions.remove,
                            ["o"] = fb_actions.open,
                            ["g"] = fb_actions.goto_parent_dir,
                            ["e"] = fb_actions.goto_home_dir,
                            ["w"] = fb_actions.goto_cwd,
                            ["t"] = fb_actions.change_cwd,
                            ["f"] = fb_actions.toggle_browser,
                            ["h"] = fb_actions.toggle_hidden,
                            ["s"] = fb_actions.toggle_all,
                        },
                    }
                }
            }
        })

require("telescope").load_extension("file_browser")
