<?php 
/**
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
*/

function storeDigit(&$digits, &$digits_found, $value) {
    if( $digits_found === 0 ) {
        $digits[ 0 ] = $value;
        $digits_found++;
    }                
    else {
        $digits[ 1 ] = $value;
        $digits_found++;
    }
}

function findNumberAsText( $char_buffer ) {
    $valid_string_as_number_values  = [
        1 => "one", 
        2 => "two", 
        3 => "three", 
        4 => "four", 
        5 => "five", 
        6 => "six", 
        7 => "seven", 
        8 => "eight", 
        9 => "nine"
    ];
    $found = 0;
    foreach( $valid_string_as_number_values as $key => $value ) {
        if( strpos( $char_buffer, $value ) !== false ) {
            $found = $key;
            break;
        }
    }
    return $found;
}

function challenge1Part1() {
    $calibration    = fopen( './data/1.txt', 'r' );
    $total_sum      = 0;
    if( $calibration ) {
        while( ( $buffer = fgets( $calibration ) ) !== false ) {
            $digits         = [];
            $length         = strlen( $buffer );
            $digits_found   = 0;
            for( $i = 0; $i < $length; $i++ ) {
                $char = $buffer[$i];
                if( !( is_numeric( $char ) ) ) {
                    continue;
                }
                storeDigit($digits, $digits_found, $char);
            }
            if( $digits_found === 1 && intval( $digits[ 1 ] ) === 0 ) {
                $digits[ 1 ] = $digits[ 0 ];
            } 
            $total_line = intval( implode( "", $digits ) );
            $total_sum += $total_line;
            printf( "Line sum is: %d. Digit 1: %d. Digit 2: %d. Found: %d \r\n", $total_line, $digits[ 0 ], $digits[ 1 ], $digits_found );
        }
        fclose( $calibration );
        printf( "Total part 1 is: %d \r\n", $total_sum );
    }  
}

function challenge1Part2() {
    $calibration                    = fopen( './data/1.txt', 'r' );
    $total_sum                      = 0;
    
    if( $calibration ) {
        while( ( $buffer = fgets( $calibration ) ) !== false ) {
            $digits         = [];
            $length         = strlen( $buffer );
            $digits_found   = 0;
            $char_buffer    = "";
            for( $i = 0; $i < $length; $i++ ) {
                $char = $buffer[$i];
                if( is_numeric( $char ) ) {
                    storeDigit($digits, $digits_found, $char);
                    $char_buffer = "";
                }
                else {
                    $char_buffer .= $char;
                    $key = findNumberAsText( $char_buffer );
                    //printf( "Found a number: %s || %s \r\n", $key, $char_buffer );
                    if( $key !== 0 ) {
                        storeDigit($digits, $digits_found, $key);
                        $char_buffer = substr( $char_buffer, -1 );
                    }
                }
            }
            if( $digits_found === 1 && intval( $digits[ 1 ] ) === 0 ) {
                $digits[ 1 ] = $digits[ 0 ];
            } 
            $total_line = intval( implode( "", $digits ) );
            $total_sum += $total_line;
            printf( "Line sum is: %d. Digit 1: %d. Digit 2: %d. Found: %d \r\n", $total_line, $digits[ 0 ], $digits[ 1 ], $digits_found );
        }
        fclose( $calibration );
        printf( "Total part 2 is: %d", $total_sum );
    }    
}

challenge1Part1();
challenge1Part2();