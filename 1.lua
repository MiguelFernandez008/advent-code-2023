require 'utils.data'

--[[
 * --- Day 1: Trebuchet?! ---
 * Something is wrong with global snow production, and you've been selected to take a look. The Elves have even given you a map; on it, they've used stars to mark the top fifty locations that are likely to be having problems.
 * You've been doing this long enough to know that to restore snow operations, you need to check all fifty stars by December 25th.
 * Collect stars by solving puzzles. Two puzzles will be made available on each day in the Advent calendar; the second puzzle is unlocked when you complete the first. Each puzzle grants one star. Good luck!
 * You try to ask why they can't just use a weather machine ("not powerful enough") and where they're even sending you ("the sky") and why your map looks mostly blank ("you sure ask a lot of questions") and hang on did you just say the sky ("of course, where do you think snow comes from") when you realize that the Elves are already loading you into a trebuchet ("please hold still, we need to strap you in").
 * As they're making the final adjustments, they discover that their calibration document (your puzzle input) has been amended by a very young Elf who was apparently just excited to show off her art skills. Consequently, the Elves are having trouble reading the values on the document.

 * The newly-improved calibration document consists of lines of text; each line originally contained a specific calibration value that the Elves now need to recover. On each line, the calibration value can be found by combining the first digit and the last digit (in that order) to form a single two-digit number.
 * For example:

 * 1abc2
 * pqr3stu8vwx
 * a1b2c3d4e5f
 * treb7uchet

 * In this example, the calibration values of these four lines are 12, 38, 15, and 77. Adding these together produces 142.
 * Consider your entire calibration document. What is the sum of all of the calibration values?
 * 
 * 
 * --- Part Two ---
 * Your calculation isn't quite right. It looks like some of the digits are actually spelled out with letters: one, two, three, four, five, six, seven, eight, and nine also count as valid "digits".
 * Equipped with this new information, you now need to find the real first and last digit on each line. For example:

 * two1nine
 * eightwothree
 * abcone2threexyz
 * xtwone3four
 * 4nineeightseven2
 * zoneight234
 * 7pqrstsixteen

 * In this example, the calibration values are 29, 83, 13, 24, 42, 14, and 76. Adding these together produces 281.
 * What is the sum of all of the calibration values?
]]--

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
   Data:open("1")
   local total_sum = 0   
   if Data.file then
    local lines = Data:lines()
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
   Data:close()
   print(string.format("Total part 1 is: %d", total_sum))
end

function part2()
    Data:open("1")
    local total_sum = 0
    if Data.file then
        local lines = Data:lines()
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
    Data:close()
    print(string.format("Total part 2 is: %d", total_sum))
end

part1()
part2()