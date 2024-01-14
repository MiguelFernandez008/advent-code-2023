require 'utils.functions'

function part1()
   Utils:open("1")
   local total_sum = 0   
   if Utils.file then
    local lines = Utils:lines()
    for key, line in pairs(lines) do
        local digits = {}
        local length = #lines
        local digist_found = 0        
        for i = 1, #line do
            local char = string.sub(line, i, i)
            if tonumber(char) then
                if digist_found == 0 then
                    digits[1] = char
                else
                    digits[2] = char
                end
                digist_found = digist_found + 1
            end
        end   
        if digist_found == 1 and digits[2] == nil then
            digits[2] = digits[1]
        end       
        local total_line = tonumber(table.concat(digits))
        total_sum = total_sum + total_line
    end    
   end
   Utils:close()
   print(string.format("Total part 1 is: %d", total_sum))
end

function part2()
    Utils:open("1")
    local total_sum = 0
    Utils:close()
    print(string.format("Total part 2 is: %d", total_sum))
end

part1()
part2()