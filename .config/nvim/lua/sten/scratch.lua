local function new_scratch_buf()
        -- Create new window (vertical)
        vim.cmd("vnew")

        -- Set options for a scratch buffer (see 'scratch-buffer')
        vim.b.buftype = 'nofile'
        vim.b.bufhidden = 'hide'
        vim.b.swapfile = nil

        -- Save the id of the scratch buffer
        local buffer_id = vim.api.nvim_get_current_buf()

        -- Set the name of the buffer to "SCRATCH"
        vim.api.nvim_buf_set_name(buffer_id, "SCRATCH")

        return buffer_id
end

-- Buffer ID if a scratch buffer is already opened (-1 if none exists)
local scratch_buf_id = -1

local function open_scratch(force_new)
        print(force_new)
        print(scratch_buf_id)
        print(vim.api.nvim_buf_is_loaded(scratch_buf_id))
        if force_new or scratch_buf_id == -1 or not vim.api.nvim_buf_is_loaded(scratch_buf_id)
        then
                scratch_buf_id = new_scratch_buf()
        else
                vim.cmd("vsplit")
                vim.api.nvim_win_set_buf(0, scratch_buf_id)
        end
end

return {
        open_scratch = open_scratch

}
