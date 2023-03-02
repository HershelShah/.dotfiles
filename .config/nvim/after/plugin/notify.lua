----------------------------------------------------------------------------------
-- @file notify.lua
-- @author Hershel Shah
-- @brief Load Packer Modules
----------------------------------------------------------------------------------
require('notify').setup {
    stages = 'fade_in_slide_out',
    timeout = 3000,
}
vim.notify = require('notify')
