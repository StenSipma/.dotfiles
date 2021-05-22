local actions = require('telescope.actions')

-- Function to use as a telescope select action. Wraps around the inspect_fits
-- from the fits.nvim plugin
local function ts_fits_inspect(prompt_bufnr)
        local entry = actions.get_selected_entry(prompt_bufnr)
        actions.close(prompt_bufnr)
        require('fits').inspect_fits(entry.value)
end

local function fits_inspect()
        require('telescope.builtin').find_files{
                -- requires the fd command
                find_command = {"fd", "--no-ignore-vcs", "--type", "f", "-e", "fits", "-e", "fit", "-e", "FITS", "-e", "FIT"},
                previewer=false,
                attach_mappings = function(prompt_bufnr, map)
                    map('i', '<CR>', ts_fits_inspect)
                    return true
                end,
        }
end

return {
        fits_inspect = fits_inspect,
        ts_fits_inspect, ts_fits_inspect,
}
