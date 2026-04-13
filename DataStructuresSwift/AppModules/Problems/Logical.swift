//
//  Logical.swift
//  DataStructuresSwift
//
//  Created by Pranav pravakar on 15/05/25.
//  Copyright © 2025 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation

struct Logical {
    /*
     Roman numerals are represented by seven different symbols: I, V, X, L, C, D and M.

     Symbol       Value
     I             1
     V             5
     X             10
     L             50
     C             100
     D             500
     M             1000
     For example, 2 is written as II in Roman numeral, just two ones added together. 12 is written as XII, which is simply X + II. The number 27 is written as XXVII, which is XX + V + II.

     Roman numerals are usually written largest to smallest from left to right. However, the numeral for four is not IIII. Instead, the number four is written as IV. Because the one is before the five we subtract it making four. The same principle applies to the number nine, which is written as IX. There are six instances where subtraction is used:

     I can be placed before V (5) and X (10) to make 4 and 9.
     X can be placed before L (50) and C (100) to make 40 and 90.
     C can be placed before D (500) and M (1000) to make 400 and 900.
     Given a roman numeral, convert it to an integer.



     Example 1:

     Input: s = "III"
     Output: 3
     Explanation: III = 3.
     Example 2:

     Input: s = "LVIII"
     Output: 58
     Explanation: L = 50, V= 5, III = 3.
     Example 3:

     Input: s = "MCMXCIV"
     Output: 1994
     Explanation: M = 1000, CM = 900, XC = 90 and IV = 4.


     Constraints:

     1 <= s.length <= 15
     s contains only the characters ('I', 'V', 'X', 'L', 'C', 'D', 'M').
     It is guaranteed that s is a valid roman numeral in the range [1, 3999].
     */

    func romanToInt(_ s: String) -> Int {
        let count = s.count
        var result = 0
        let stringArray = Array(s)
        var i = 0
        
        while i < count {
            let current = value(stringArray[i])
            guard i < count - 1 else {
                result += current
                i += 1
                continue
            }
            let next = value(stringArray[i + 1])
            if current >= next {
                result += current
                i += 1
            } else {
                result += next - current
                i += 2
            }
        }
        return result
    }
    
    func value(_ character: Character) -> Int {
        switch character {
        case "I":
            return 1
        case "V":
            return 5
        case "X":
            return 10
        case "L":
            return 50
        case "C":
            return 100
        case "D":
            return 500
        case "M":
            return 1000
        default:
            return 0
        }
    }

    /*

     528. Random Pick with Weight
     You are given a 0-indexed array of positive integers w where w[i] describes the weight of the ith index.

     You need to implement the function pickIndex(), which randomly picks an index in the range [0, w.length - 1] (inclusive) and returns it. The probability of picking an index i is w[i] / sum(w).

     For example, if w = [1, 3], the probability of picking index 0 is 1 / (1 + 3) = 0.25 (i.e., 25%), and the probability of picking index 1 is 3 / (1 + 3) = 0.75 (i.e., 75%).


     Example 1:

     Input
     ["Solution","pickIndex"]
     [[[1]],[]]
     Output
     [null,0]

     Explanation
     Solution solution = new Solution([1]);
     solution.pickIndex(); // return 0. The only option is to return 0 since there is only one element in w.
     Example 2:

     Input
     ["Solution","pickIndex","pickIndex","pickIndex","pickIndex","pickIndex"]
     [[[1,3]],[],[],[],[],[]]
     Output
     [null,1,1,1,1,0]

     Explanation
     Solution solution = new Solution([1, 3]);
     solution.pickIndex(); // return 1. It is returning the second element (index = 1) that has a probability of 3/4.
     solution.pickIndex(); // return 1
     solution.pickIndex(); // return 1
     solution.pickIndex(); // return 1
     solution.pickIndex(); // return 0. It is returning the first element (index = 0) that has a probability of 1/4.

     Since this is a randomization problem, multiple answers are allowed.
     All of the following outputs can be considered correct:
     [null,1,1,1,1,0]
     [null,1,1,1,1,1]
     [null,1,1,1,0,0]
     [null,1,1,1,0,1]
     [null,1,0,1,0,0]
     ......
     and so on.


     Constraints:

     1 <= w.length <= 104
     1 <= w[i] <= 105
     pickIndex will be called at most 104 times.
     */
    // Unsolved

    class Solution {

        init(_ w: [Int]) {

        }

        func pickIndex() -> Int {

            return 0
        }
    }

    /*
     * Your Solution object will be instantiated and called as such:
     * let obj = Solution(w)
     * let ret_1: Int = obj.pickIndex()
     */

    /*
     65. Valid Number
    
     Given a string s, return whether s is a valid number.

     For example, all the following are valid numbers: "2", "0089", "-0.1", "+3.14", "4.", "-.9", "2e10", "-90E3", "3e+7", "+6e-1", "53.5e93", "-123.456e789", while the following are not valid numbers: "abc", "1a", "1e", "e3", "99e2.5", "--6", "-+3", "95a54e53".

     Formally, a valid number is defined using one of the following definitions:

     An integer number followed by an optional exponent.
     A decimal number followed by an optional exponent.
     An integer number is defined with an optional sign '-' or '+' followed by digits.

     A decimal number is defined with an optional sign '-' or '+' followed by one of the following definitions:

     Digits followed by a dot '.'.
     Digits followed by a dot '.' followed by digits.
     A dot '.' followed by digits.
     An exponent is defined with an exponent notation 'e' or 'E' followed by an integer number.

     The digits are defined as one or more digits.



     Example 1:

     Input: s = "0"

     Output: true

     Example 2:

     Input: s = "e"

     Output: false

     Example 3:

     Input: s = "."

     Output: false



     Constraints:

     1 <= s.length <= 20
     s consists of only English letters (both uppercase and lowercase), digits (0-9), plus '+', minus '-', or dot '.'.
     */
    // Unsolved
    /*
     1762. Buildings With an Ocean View

     There are n buildings in a line. You are given an integer array heights of size n that represents the heights of the buildings in the line.

     The ocean is to the right of the buildings. A building has an ocean view if the building can see the ocean without obstructions. Formally, a building has an ocean view if all the buildings to its right have a smaller height.

     Return a list of indices (0-indexed) of buildings that have an ocean view, sorted in increasing order.



     Example 1:

     Input: heights = [4,2,3,1]
     Output: [0,2,3]
     Explanation: Building 1 (0-indexed) does not have an ocean view because building 2 is taller.
     Example 2:

     Input: heights = [4,3,2,1]
     Output: [0,1,2,3]
     Explanation: All the buildings have an ocean view.
     Example 3:

     Input: heights = [1,3,2,4]
     Output: [3]
     Explanation: Only building 3 has an ocean view.


     Constraints:

     1 <= heights.length <= 105
     1 <= heights[i] <= 109
     */

    // BF - For each building check if right side blocks view
    // Opti 1 - Check for monotonic stack
    // Opti 2 - Check for monotonic stack
    // Opti 3 - Start from right and check if it is more than max. If yes then add it to list and at the end reverse it
    func findBuildings(_ heights: [Int]) -> [Int] {
        var result = [Int]()
        var maximum = -1
        let count = heights.count
        for i in stride(from: count - 1, through: 0, by: -1) {
            if maximum < heights[i] {
                maximum = heights[i]
                result.append(i)
            }
        }
        return result.reversed()
    }
}
