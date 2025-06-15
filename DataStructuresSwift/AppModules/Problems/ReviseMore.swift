//
//  ReviseMore.swift
//  DataStructuresSwift
//
//  Created by Pranav pravakar on 13/05/25.
//  Copyright © 2025 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation
struct ReviseMore {
    /*
     You are given an integer array digits, where each element is a digit. The array may contain duplicates.

     You need to find all the unique integers that follow the given requirements:

     The integer consists of the concatenation of three elements from digits in any arbitrary order.
     The integer does not have leading zeros.
     The integer is even.
     For example, if the given digits were [1, 2, 3], integers 132 and 312 follow the requirements.

     Return a sorted array of the unique integers.



     Example 1:

     Input: digits = [2,1,3,0]
     Output: [102,120,130,132,210,230,302,310,312,320]
     Explanation: All the possible integers that follow the requirements are in the output array.
     Notice that there are no odd integers or integers with leading zeros.
     Example 2:

     Input: digits = [2,2,8,8,2]
     Output: [222,228,282,288,822,828,882]
     Explanation: The same digit can be used as many times as it appears in digits.
     In this example, the digit 8 is used twice each time in 288, 828, and 882.
     Example 3:

     Input: digits = [3,7,5]
     Output: []
     Explanation: No even integers can be formed using the given digits.


     Constraints:

     3 <= digits.length <= 100
     0 <= digits[i] <= 9
     */
    func findEvenNumbers(_ digits: [Int]) -> [Int] {
        var digitCount = [Int: Int]()
        for digit in digits {
            digitCount[digit] = (digitCount[digit] ?? 0) + 1
        }
        var i = 100
        var result = [Int]()
        while i < 1000 {
            var numberDigitCount = [Int: Int]()
            let firstDigit = i / 100
            let secondDigit = (i / 10) % 10
            let thirdDigit = i - (firstDigit * 100) - (secondDigit * 10)
            numberDigitCount[firstDigit] = (numberDigitCount[firstDigit] ?? 0) + 1
            numberDigitCount[secondDigit] = (numberDigitCount[secondDigit] ?? 0) + 1
            numberDigitCount[thirdDigit] = (numberDigitCount[thirdDigit] ?? 0) + 1
            var flag = true
            for (key, value) in numberDigitCount {
                if value > (digitCount[key] ?? 0) {
                    flag = false
                    break
                }
            }
            if flag == true {
                result.append(i)
            }
            i += 2
        }
        return result
    }

        /*
         You are given a string s and an integer t, representing the number of transformations to perform. In one transformation, every character in s is replaced according to the following rules:

         If the character is 'z', replace it with the string "ab".
         Otherwise, replace it with the next character in the alphabet. For example, 'a' is replaced with 'b', 'b' is replaced with 'c', and so on.
         Return the length of the resulting string after exactly t transformations.

         Since the answer may be very large, return it modulo 10^9 + 7.



         Example 1:

         Input: s = "abcyy", t = 2

         Output: 7

         Explanation:

         First Transformation (t = 1):
         'a' becomes 'b'
         'b' becomes 'c'
         'c' becomes 'd'
         'y' becomes 'z'
         'y' becomes 'z'
         String after the first transformation: "bcdzz"
         Second Transformation (t = 2):
         'b' becomes 'c'
         'c' becomes 'd'
         'd' becomes 'e'
         'z' becomes "ab"
         'z' becomes "ab"
         String after the second transformation: "cdeabab"
         Final Length of the string: The string is "cdeabab", which has 7 characters.
         Example 2:

         Input: s = "azbk", t = 1

         Output: 5

         Explanation:

         First Transformation (t = 1):
         'a' becomes 'b'
         'z' becomes "ab"
         'b' becomes 'c'
         'k' becomes 'l'
         String after the first transformation: "babcl"
         Final Length of the string: The string is "babcl", which has 5 characters.


         Example 3:

         s =
         "jqktcurgdvlibczdsvnsg"
         t =
         7517
         output = 79033769

         Constraints:

         1 <= s.length <= 105
         s consists only of lowercase English letters.
         1 <= t <= 105
         */
    func lengthAfterTransformations(s: String, t: Int) -> Int {
        let charArray = Array(s)
        var charCount: [Int] = Array(repeating: 0, count: 26)
        for char in charArray {
            let index = Int(char.asciiValue! - Character("a").asciiValue!)
            charCount[index] += 1
        }
        let mod = 1_000_000_007
        for _ in 0..<t {
            var tempCharCount: [Int] = Array(repeating: 0, count: 26)
            for i in 0..<25 {
                tempCharCount[i + 1] = charCount[i]
            }
            tempCharCount[0] = charCount[25]
            tempCharCount[1] = (tempCharCount[1] + charCount[25]) % mod
            charCount = tempCharCount
        }
        return charCount.reduce(0, +) % mod
    }

    /*
     You are given a string s consisting of lowercase English letters, an integer t representing the number of transformations to perform, and an array nums of size 26. In one transformation, every character in s is replaced according to the following rules:

     Replace s[i] with the next nums[s[i] - 'a'] consecutive characters in the alphabet. For example, if s[i] = 'a' and nums[0] = 3, the character 'a' transforms into the next 3 consecutive characters ahead of it, which results in "bcd".
     The transformation wraps around the alphabet if it exceeds 'z'. For example, if s[i] = 'y' and nums[24] = 3, the character 'y' transforms into the next 3 consecutive characters ahead of it, which results in "zab".
     Return the length of the resulting string after exactly t transformations.

     Since the answer may be very large, return it modulo 109 + 7.



     Example 1:

     Input: s = "abcyy", t = 2, nums = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2]

     Output: 7

     Explanation:

     First Transformation (t = 1):

     'a' becomes 'b' as nums[0] == 1
     'b' becomes 'c' as nums[1] == 1
     'c' becomes 'd' as nums[2] == 1
     'y' becomes 'z' as nums[24] == 1
     'y' becomes 'z' as nums[24] == 1
     String after the first transformation: "bcdzz"
     Second Transformation (t = 2):

     'b' becomes 'c' as nums[1] == 1
     'c' becomes 'd' as nums[2] == 1
     'd' becomes 'e' as nums[3] == 1
     'z' becomes 'ab' as nums[25] == 2
     'z' becomes 'ab' as nums[25] == 2
     String after the second transformation: "cdeabab"
     Final Length of the string: The string is "cdeabab", which has 7 characters.

     Example 2:

     Input: s = "azbk", t = 1, nums = [2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2]

     Output: 8

     Explanation:

     First Transformation (t = 1):

     'a' becomes 'bc' as nums[0] == 2
     'z' becomes 'ab' as nums[25] == 2
     'b' becomes 'cd' as nums[1] == 2
     'k' becomes 'lm' as nums[10] == 2
     String after the first transformation: "bcabcdlm"
     Final Length of the string: The string is "bcabcdlm", which has 8 characters.



     Constraints:

     1 <= s.length <= 105
     s consists only of lowercase English letters.
     1 <= t <= 109
     nums.length == 26
     1 <= nums[i] <= 25
     */

    // Time limit exceedes
    func lengthAfterTransformations(_ s: String, _ t: Int, _ nums: [Int]) -> Int {
        let charArray = Array(s)
        var charCount: [Int] = Array(repeating: 0, count: 26)
        for char in charArray {
            let index = Int(char.asciiValue! - Character("a").asciiValue!)
            charCount[index] += 1
        }
        let mod = 1_000_000_007
        for _ in 0..<t {
            var tempCharCount: [Int] = Array(repeating: 0, count: 26)
            for i in 0..<26 {
                if charCount[i] != 0 {
                    for j in 0..<nums[i] {
                        let index = (i + 1 + j) % 26
                        tempCharCount[index] = (tempCharCount[index] + charCount[i]) % mod
                    }
                }

            }
            charCount = tempCharCount
        }
        return charCount.reduce(0, +) % mod
    }

    /*
     Example 1:

     Input: nums = [4,3,2,7,8,2,3,1]
     Output: [5,6]
     Example 2:

     Input: nums = [1,1]
     Output: [2]


     Constraints:

     n == nums.length
     1 <= n <= 105
     1 <= nums[i] <= n


     Follow up: Could you do it without extra space and in O(n) runtime? You may assume the returned list does not count as extra space.


     */

    func findDisappearedNumbers(_ nums: [Int]) -> [Int] {
        var nums = nums
        var result = [Int]()
        for i in 0..<nums.count {
            let index = abs(nums[i]) - 1
            if nums[index] > 0 {
                nums[index] = -nums[index]
            }
        }
        for i in 0..<nums.count {
            if nums[i] > 0 {
                result.append(i + 1)
            }
        }
        return result

    }
}
