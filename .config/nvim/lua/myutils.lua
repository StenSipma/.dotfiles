local function printtable(t)
        for k, v in pairs(t) do
                print(tostring(k), tostring(v))
        end
end

return {printtable = printtable}
