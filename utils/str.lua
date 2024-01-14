local Str = {}

function Str:explode(str, pattern)
    local t = {}
    for token in string.gmatch(str, pattern) do
        table.insert(t, token)
    end
    return t
end

return Str