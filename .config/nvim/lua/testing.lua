local co = coroutine

local function yielding()
        local value = co.yield(1)
        print(string.format('Value: %s', value))
end

local function unroll(thread)
        print('Starting Unroll')
        local result  = {co.resume(thread)}
        while result[1] do
                local str = ''
                for _, value in ipairs(result) do
                        str = string.format("%s, %s", str, value)
                end
                print(str)
                result = {co.resume(thread)}
        end

end


local thread = co.create(yielding)
unroll(thread)
