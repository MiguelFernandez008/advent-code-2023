Utils = {
    file = nill
}

function Utils:open(name)
    local path = "./data/" .. name .. ".txt"
    self.file = io.open(path, "r")
end

function Utils:lines()
    local lines = {}
    for l in self.file:lines() do
        table.insert(lines, l) 
    end
    return lines
end

function Utils:close()
    self.file:close()
end

return Utils