-- Convenience function printing each argument given to it
-- Make it global by including: `:lua _G.dump = dump somewhere`
-- --------------------------------------------------------------
-- From lua  > dump( {1, 2, 3} )
-- From vim  > :lua dump( {1, 2, 3} )
--           > call v:lua.dump( [1, 2, 3] )
local function dump(...)
        -- Call vim.inspect in each argument given
        local objects = vim.tbl_map(vim.inspect, {...})

        -- Unpack the arguments and print them
        print(unpack(objects))
end

return {dump = dump}
