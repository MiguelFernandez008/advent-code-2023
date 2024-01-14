require 'utils.functions'

function find_number_as_text(char_buffer)
    local valid_string_as_number_values = {
        "one", 
        "two", 
        "three", 
        "four", 
        "five", 
        "six", 
        "seven", 
        "eight", 
        "nine"
    }
    local found = 0
    for k, v in pairs(valid_string_as_number_values) do
        if string.find(char_buffer, v) then
            found = k
            break
        end
    end
    return found
end

function store_digit(digits, digist_found, value)
    if digist_found == 0 then
        digits[1] = value
    else
        digits[2] = value
    end
end

function mirror_first_digit(digits, digist_found)
    if digist_found == 1 and digits[2] == nil then
        digits[2] = digits[1]
    end       
end

function get_line_total(digits)
    return tonumber(table.concat(digits))
end

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
                store_digit(digits, digist_found, char)
                digist_found = digist_found + 1
            end
        end   
        mirror_first_digit(digits, digist_found)
        local total_line = get_line_total(digits)
        total_sum = total_sum + total_line
    end    
   end
   Utils:close()
   print(string.format("Total part 1 is: %d", total_sum))
end

function part2()
    Utils:open("1")
    local total_sum = 0
    if Utils.file then
        local lines = Utils:lines()
        for key, line in pairs(lines) do
            local digits = {}
            local length = #lines
            local digist_found = 0
            local char_buffer = ""        
            for i = 1, #line do
                local char = string.sub(line, i, i)
                if tonumber(char) then
                    store_digit(digits, digist_found, char)
                    digist_found = digist_found + 1
                    char_buffer = ""
                else
                    char_buffer = char_buffer .. char
                    local key = find_number_as_text(char_buffer)
                    if key ~= 0 then
                        store_digit(digits, digist_found, key)
                        digist_found = digist_found + 1
                        char_buffer = string.sub(char_buffer, -1)
                    end
                end
            end
            mirror_first_digit(digits, digist_found)
            local total_line = get_line_total(digits)
            total_sum = total_sum + total_line
        end
    end
    Utils:close()
    print(string.format("Total part 2 is: %d", total_sum))
end

part1()
part2()