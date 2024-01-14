Data = {
    file = nill
}

function Data:open(name)
    local path = "./data/" .. name .. ".txt"
    self.file = io.open(path, "r")
end

function Data:lines()
    local lines = {}
    for l in self.file:lines() do
        table.insert(lines, l) 
    end
    return lines
end

function Data:close()
    self.file:close()
end

return Data