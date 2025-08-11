//
//  DynamicProblemsString.swift
//  DataStructuresSwift
//
//  Created by Pranav pravakar on 13/07/25.
//  Copyright © 2025 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation

// swiftlint:disable file_length
// swiftlint:disable type_body_length
struct DynamicProblemsString {
    init() {
        var string1, string2: String
        print("Longest common subsequence abcde ,bdgek - \(lcsTabulation(string1: "abcde", string2: "bdgek"))")
        string1 = "abcde"
        string2 = "ace"
        print("Longest common subsequence Count Memo \(string1) ,\(string2) - \(lcsCountRecursionMemo(string1: string1, string2: string2, index1: string1.count - 1, index2: string2.count - 1))")
        print("Longest common subsequence Count Tabu \(string1) ,\(string2) - \(lcsCountTabulation(string1: string1, string2: string2))")
        string1 = "abac"
        string2 = "cab"
        print("Shortest common superseq \(string1) - \(string2) - \(shortestCommonSupersequenceRec(string1, string2))")
        print("Shortest common superseq \(string1) - \(string2) - \(shortestCommonSupersequenceMemo(string1, string2))")
        print("Shortest common superseq \(string1) - \(string2) - \(shortestCommonSupersequenceSpaceOptiMost(string1, string2))")
        print("Shortest common superseq \(string1) - \(string2) - \(shortestCommonSupersequenceSpaceOptiMost1(string1, string2))")
        string1 = "rabbbit"
        string2 = "rabbit"
        var array = ["a", "b", "ba", "bca", "bda", "bdca"]
        print("Disting subsequences \(string1) - \(string2) - \(numDistinctMemo(string1, string2))")
        print("LIS - \(array) - \(longestStrChain(array))")
        array = ["xbc", "pcxbcf", "xb", "cxbc", "pcxbc"]
        print("LIS - \(array) - \(longestStrChain(array))")
    }

    func lcsCountRecursion(string1: [Character], string2: [Character], index1: Int, index2: Int) -> Int {
        if index1 < 0 || index2 < 0 {
            return 0
        }
        if string1[index1] == string2[index2] {
            return 1 + lcsCountRecursion(string1: string1, string2: string2, index1: index1 - 1, index2: index2 - 1)
        }

        let first = lcsCountRecursion(string1: string1, string2: string2, index1: index1, index2: index2 - 1)
        let second = lcsCountRecursion(string1: string1, string2: string2, index1: index1 - 1, index2: index2)
        return max(first, second)
    }

    // TC -> O(N x M)
    // SC -> O(N x M) + O(N + M)
    func lcsCountRecursionMemo(string1: String, string2: String, index1: Int, index2: Int) -> Int {
        let count1 = string1.count
        let count2 = string2.count
        var dp = [[Int]](repeating: [Int](repeating: -1, count: count2), count: count1)
        return internalLcsCountRecursionMemo(string1: string1, string2: string2, dp: &dp, index1: count1 - 1, index2: count2 - 1)
    }

    private func internalLcsCountRecursionMemo(string1: String, string2: String, dp: inout [[Int]], index1: Int, index2: Int) -> Int {
        if index1 < 0 || index2 < 0 {
            return 0
        }
        if dp[index1][index2] != -1 {
            return dp[index1][index2]
        }
        let stringIndex1 = String.Index(utf16Offset: index1, in: string1)
        let stringIndex2 = String.Index(utf16Offset: index2, in: string2)
        if string1[stringIndex1] == string2[stringIndex2] {
            dp[index1][index2] = 1 + internalLcsCountRecursionMemo(string1: string1, string2: string2, dp: &dp, index1: index1 - 1, index2: index2 - 1)
            return  dp[index1][index2]
        }

        let first = internalLcsCountRecursionMemo(string1: string1, string2: string2, dp: &dp, index1: index1, index2: index2 - 1)
        let second = internalLcsCountRecursionMemo(string1: string1, string2: string2, dp: &dp, index1: index1 - 1, index2: index2)

        dp[index1][index2] = max(first, second)
        return dp[index1][index2]
    }

    func lcsCountTabulation(string1: String, string2: String) -> Int {
        let count1 = string1.count
        let count2 = string2.count
        var dp = [[Int]](repeating: [Int](repeating: 0, count: count2 + 1), count: count1 + 1)

        for index1 in stride(from: 1, through: count1, by: 1) {
            for index2 in stride(from: 1, through: count2, by: 1) {
                let stringIndex1 = String.Index(utf16Offset: index1 - 1, in: string1)
                let stringIndex2 = String.Index(utf16Offset: index2 - 1, in: string2)
                if string1[stringIndex1] == string2[stringIndex2] {
                    dp[index1][index2] = 1 + dp[index1 - 1][index2 - 1]

                } else {

                    let first = dp[index1][index2 - 1]
                    let second = dp[index1 - 1][index2]

                    dp[index1][index2] = max(first, second)
                }
            }
        }

        return dp[count1][count2]
    }

    func lcsCountRecursionSpaceOpti1(string1: String, string2: String) -> Int {
        let count1 = string1.count
        let count2 = string2.count
        var previous = [Int](repeating: 0, count: count2 + 1)

        for index2 in stride(from: 0, through: count2 - 1, by: 1) {
            previous[index2] = 0
        }

        for index1 in stride(from: 1, through: count1, by: 1) {
            var current = previous
            for index2 in stride(from: 1, through: count2, by: 1) {
                let stringIndex1 = String.Index(utf16Offset: index1 - 1, in: string1)
                let stringIndex2 = String.Index(utf16Offset: index2 - 1, in: string2)
                if string1[stringIndex1] == string2[stringIndex2] {
                    current[index2] = 1 + previous[index2 - 1]

                } else {

                    let first = current[index2 - 1]
                    let second = previous[index2]

                    current[index2] = max(first, second)
                }
            }
            previous = current

        }

        return previous[count2]
    }

    /*
     Given two strings text1 and text2, return the length of their longest common subsequence. If there is no common subsequence, return 0.

     A subsequence of a string is a new string generated from the original string with some characters (can be none) deleted without changing the relative order of the remaining characters.

     For example, "ace" is a subsequence of "abcde".
     A common subsequence of two strings is a subsequence that is common to both strings.



     Example 1:

     Input: text1 = "abcde", text2 = "ace"
     Output: 3
     Explanation: The longest common subsequence is "ace" and its length is 3.
     Example 2:

     Input: text1 = "abc", text2 = "abc"
     Output: 3
     Explanation: The longest common subsequence is "abc" and its length is 3.
     Example 3:

     Input: text1 = "abc", text2 = "def"
     Output: 0
     Explanation: There is no such common subsequence, so the result is 0.


     Constraints:

     1 <= text1.length, text2.length <= 1000
     text1 and text2 consist of only lowercase English characters.
     */
    func lcsRecursion(string1: String, string2: String, index1: Int, index2: Int) -> String {
        if index1 < 0 || index2 < 0 {
            return ""
        }
        if string1[String.Index(utf16Offset: index1, in: string1)] == string2[String.Index(utf16Offset: index2, in: string2)] {
            return String(string1[String.Index(utf16Offset: index1, in: string1)]) +
            lcsRecursion(string1: string1, string2: string2, index1: index1 - 1, index2: index2 - 1)
        }

        let first = lcsRecursion(string1: string1, string2: string2, index1: index1, index2: index2 - 1)
        let second = lcsRecursion(string1: string1, string2: string2, index1: index1 - 1, index2: index2)
        return first.count > second.count ? first : second
    }

    func lcsRecursionMemo(string1: String, string2: String, dp: inout [[String]], index1: Int, index2: Int) -> String {
        if index1 < 0 || index2 < 0 {
            return ""
        }
        if dp[index1][index2] != "-1" {
            return dp[index1][index2]
        }
        if string1[String.Index(utf16Offset: index1, in: string1)] == string2[String.Index(utf16Offset: index2, in: string2)] {
            dp[index1][index2] = String(string1[String.Index(utf16Offset: index1, in: string1)]) +
            lcsRecursion(string1: string1, string2: string2, index1: index1 - 1, index2: index2 - 1)
            return dp[index1][index2]
        }

        let first = lcsRecursion(string1: string1, string2: string2, index1: index1, index2: index2 - 1)
        let second = lcsRecursion(string1: string1, string2: string2, index1: index1 - 1, index2: index2)
        dp[index1][index2] = first.count > second.count ? first : second

        return dp[index1][index2]
    }

    func lcsTabulation(string1: String, string2: String) -> String {
        let count1 = string1.count
        let count2 = string2.count
        var dp = [[String]](repeating: [String](repeating: "", count: count1 + 1), count: count2 + 1)

        for index2 in stride(from: 0, through: count2 - 1, by: 1) {
            dp[0][index2] = ""
        }

        for index1 in stride(from: 0, through: count1 - 1, by: 1) {
            dp[index1][0] = ""
        }

        for index1 in stride(from: 1, through: count1, by: 1) {
            for index2 in stride(from: 1, through: count2, by: 1) {
                let stringIndex1 = String.Index(utf16Offset: index1 - 1, in: string1)
                let stringIndex2 = String.Index(utf16Offset: index2 - 1, in: string2)
                if string1[stringIndex1] == string2[stringIndex2] {
                    dp[index1][index2] = String(string1[stringIndex1]) + dp[index1 - 1][index2 - 1]

                } else {

                    let first = dp[index1][index2 - 1]
                    let second = dp[index1 - 1][index2]

                    dp[index1][index2] = first.count > second.count ? first : second
                }
            }
        }

        return dp[count1][count2]
    }

    func longestCommonSubstringCount(string1: String, string2: String) -> Int {
        let count1 = string1.count
        let count2 = string2.count
        var count = 0
        
        var dp = [[Int]](repeating: [Int](repeating: 0, count: count1), count: count2)

        for index1 in stride(from: 1, through: count1, by: 1) {
            for index2 in stride(from: 1, through: count2, by: 1) {
                if string1[String.Index(utf16Offset: index1 - 1, in: string1)] == string2[String.Index(utf16Offset: index2 - 1, in: string2)] {
                    dp[index1][index2] = 1 + dp[index1 - 1][index2 - 1]
                    count = max(count, dp[index1][index2])
                } else {
                    dp[index1][index2] = 0
                }

            }
        }
        return count
    }

    func longestCommonSubstringCountSpaceOpti1(string1: String, string2: String) -> Int {
        let count1 = string1.count
        let count2 = string2.count
        var count = 0

        var previous = [Int](repeating: 0, count: count1)

        for index1 in stride(from: 1, through: count1, by: 1) {
            var current = previous
            for index2 in stride(from: 1, through: count2, by: 1) {
                if string1[String.Index(utf16Offset: index1 - 1, in: string1)] == string2[String.Index(utf16Offset: index2 - 1, in: string2)] {
                    current[index2] = 1 + previous[index2 - 1]
                    count = max(count, current[index2])
                } else {
                    current[index2] = 0
                }
            }
            previous = current
        }
        return count
    }

    func longestCommonSubstring(string1: String, string2: String) -> String {
        let count1 = string1.count
        let count2 = string2.count
        var substring = ""

        var dp = [[String]](repeating: [String](repeating: "", count: count1), count: count2)

        for index1 in stride(from: 1, through: count1, by: 1) {
            for index2 in stride(from: 1, through: count2, by: 1) {
                let char1 = string1[String.Index(utf16Offset: index1 - 1, in: string1)]
                let char2 = string2[String.Index(utf16Offset: index2 - 1, in: string2)]
                if char1 == char2 {
                    dp[index1][index2] = String(char1) + dp[index1 - 1][index2 - 1]
                    if dp[index1][index2].count > substring.count {
                        substring = dp[index1][index2]
                    }
                } else {
                    dp[index1][index2] = ""
                }

            }
        }
        return substring
    }

    func longestCommonSubstringSpaceOpti1(string1: String, string2: String) -> String {
        let count1 = string1.count
        let count2 = string2.count
        var substring = ""

        var current = [String](repeating: "", count: count1)

        for index1 in stride(from: 1, through: count1, by: 1) {
            var previous = current
            for index2 in stride(from: 1, through: count2, by: 1) {
                let char1 = string1[String.Index(utf16Offset: index1 - 1, in: string1)]
                let char2 = string2[String.Index(utf16Offset: index2 - 1, in: string2)]
                if char1 == char2 {
                    current[index2] = String(char1) + previous[index2 - 1]
                    if current[index2].count > substring.count {
                        substring = current[index2]
                    }
                } else {
                    current[index2] = ""
                }
            }
            previous = current
        }
        return substring
    }

    /*
     Given a string s, find the longest palindromic subsequence's length in s.

     A subsequence is a sequence that can be derived from another sequence by deleting some or no elements without changing the order of the remaining elements.



     Example 1:

     Input: s = "bbbab"
     Output: 4
     Explanation: One possible longest palindromic subsequence is "bbbb".
     Example 2:

     Input: s = "cbbd"
     Output: 2
     Explanation: One possible longest palindromic subsequence is "bb".


     Constraints:

     1 <= s.length <= 1000
     s consists only of lowercase English letters.
     
     Longest Palindrome
     Brute force - Find all subsequences and check for longest palindrome
     Optimal - Find lcs of string and string.reversed
     */

    /*
     Minimum insertions to make string palindromic
     Codingninja
     n - maximum palindromic sequence

     */

    /*
     Minimum number of operations to convert string1 into string2
     abcd, anc
     string1.count - lcs + string2.count - lcs = string1.count + string2.count - 2 * lcs(string1, string2)
     */

    /*
     Shortest Common supersequence
     brute,groot --- bleed, blue
     bgruoote, bleued
     string1.count + string2.count - count(lcs)
     */

    func shortestCommonSupersequenceRec(_ str1: String, _ str2: String) -> String {
        String(shortestCommonSupersequenceRecursion(string1: Array(str1), string2: Array(str2)))
    }

    func shortestCommonSupersequenceRecursion(string1: [Character], string2: [Character]) -> [Character] {
        if string1.isEmpty && string2.isEmpty {
            return [Character]("")
        }
        if string1.isEmpty {
            return string2
        }
        if string2.isEmpty {
            return string1
        }
        if string1[0] == string2[0] {
            return [string1[0]] + shortestCommonSupersequenceRecursion(string1: Array(string1.dropFirst()), string2: Array(string2.dropFirst()))
        } else {
            let first = [string1[0]] + shortestCommonSupersequenceRecursion(string1: Array(string1.dropFirst()), string2: string2)
            let second = [string2[0]] + shortestCommonSupersequenceRecursion(string1: string1, string2: Array(string2.dropFirst()))
            return first.count < second.count ? first : second
        }
    }

    func shortestCommonSupersequenceRec1(_ str1: String, _ str2: String) -> String {
        String(shortestCommonSupersequenceRecursionIndex(string1: Array(str1), string2: Array(str2), index1: 0, index2: 0))
    }

    func shortestCommonSupersequenceRecursionIndex(string1: [Character], string2: [Character], index1: Int, index2: Int) -> [Character] {
        let count1 = string1.count
        let count2 = string2.count
        if count1 == index1 && count2 == index2 {
            return [Character]("")
        }
        if count1 == index1 {
            return Array(string2[index2..<count2])
        }
        if count2 == index2 {
            return Array(string1[index1..<count1])
        }
        if string1[index1] == string2[index2] {
            return [string1[index1]] + shortestCommonSupersequenceRecursionIndex(string1: string1, string2: string2, index1: index1 + 1, index2: index2 + 1)
        } else {
            let first = [string1[index1]] + shortestCommonSupersequenceRecursionIndex(string1: string1, string2: string2, index1: index1 + 1, index2: index2)
            let second = [string2[index2]] + shortestCommonSupersequenceRecursionIndex(string1: string1, string2: string2, index1: index1, index2: index2 + 1)
            return first.count < second.count ? first : second
        }
    }

    // TC - O(N * M)
    // SC - O(N * M) + O(N + M)
    func shortestCommonSupersequenceMemo(_ str1: String, _ str2: String) -> String {
        var dp = [[[Character]]](repeating: [[Character]](repeating: [Character](""), count: str2.count), count: str1.count)
        return String(shortestCommonSupersequenceRecursionIndexMemo(string1: Array(str1), string2: Array(str2), dp: &dp, index1: 0, index2: 0))
    }

    func shortestCommonSupersequenceRecursionIndexMemo(string1: [Character], string2: [Character], dp: inout [[[Character]]], index1: Int, index2: Int) -> [Character] {
        let count1 = string1.count
        let count2 = string2.count
        if count1 == index1 && count2 == index2 {
            return [Character]("")
        }
        if count1 == index1 {
            return Array(string2[index2..<count2])
        }
        if count2 == index2 {
            return Array(string1[index1..<count1])
        }
        if dp[index1][index2] != [Character]("") {
            return dp[index1][index2]
        }
        if string1[index1] == string2[index2] {
            dp[index1][index2] = [string1[index1]] + shortestCommonSupersequenceRecursionIndexMemo(string1: string1, string2: string2, dp: &dp, index1: index1 + 1, index2: index2 + 1)
            return dp[index1][index2]
        } else {
            let first = [string1[index1]] + shortestCommonSupersequenceRecursionIndexMemo(string1: string1, string2: string2, dp: &dp, index1: index1 + 1, index2: index2)
            let second = [string2[index2]] + shortestCommonSupersequenceRecursionIndexMemo(string1: string1, string2: string2, dp: &dp, index1: index1, index2: index2 + 1)
            dp[index1][index2] = first.count < second.count ? first : second
            return  dp[index1][index2]
        }
    }

    func shortestCommonSupersequenceTab(_ str1: String, _ str2: String) -> String {
        let string1 = Array(str1)
        let string2 = Array(str2)
        let count1 = string1.count
        let count2 = string2.count
        var dp = [[[Character]]](repeating: [[Character]](repeating: [Character](""), count: count2 + 1), count: count1 + 1)
        for index2 in stride(from: 0, through: count2, by: 1) {
            dp[0][index2] = Array(string2[0..<index2])
        }
        for index1 in stride(from: 0, through: count1, by: 1) {
            dp[index1][0] = Array(string1[0..<index1])
        }

        for index1 in stride(from: 1, through: count1, by: 1) {
            for index2 in stride(from: 1, through: count2, by: 1) {
                if string1[index1 - 1] == string2[index2 - 1] {
                    dp[index1][index2] = dp[index1 - 1][index2 - 1] + [string1[index1 - 1]]
                } else {
                    let first = dp[index1 - 1][index2] + [string1[index1 - 1]]
                    let second = dp[index1][index2 - 1] + [string2[index2 - 1]]
                    dp[index1][index2] = first.count < second.count ? first : second
                }
            }
        }
        return String(dp[count1][count2])
    }

    func shortestCommonSupersequenceSpaceOpti1(_ str1: String, _ str2: String) -> String {
        let string1 = Array(str1)
        let string2 = Array(str2)
        let count1 = string1.count
        let count2 = string2.count
        var previous = [[Character]](repeating: [Character](""), count: count2 + 1)
        for index2 in stride(from: 0, through: count2, by: 1) {
            previous[index2] = Array(string2[0..<index2])
        }

        for index1 in stride(from: 1, through: count1, by: 1) {
            var current = [[Character]](repeating: [Character](""), count: count2 + 1)
            current[0] = Array(string1[0..<index1])
            for index2 in stride(from: 1, through: count2, by: 1) {
                if string1[index1 - 1] == string2[index2 - 1] {
                    current[index2] = previous[index2 - 1] + [string1[index1 - 1]]
                } else {
                    let first = previous[index2] + [string1[index1 - 1]]
                    let second = current[index2 - 1] + [string2[index2 - 1]]
                    current[index2] = first.count < second.count ? first : second
                }
            }
            previous = current
        }
        return String(previous[count2])
    }

    func shortestCommonSupersequenceSpaceOptiMost(_ str1: String, _ str2: String) -> String {
        let string1 = Array(str1)
        let string2 = Array(str2)
        let count1 = string1.count
        let count2 = string2.count
        var dp = [[Int]](repeating: [Int](repeating: 0, count: count2 + 1), count: count1 + 1)

        for index1 in stride(from: 1, through: count1, by: 1) {
            for index2 in stride(from: 1, through: count2, by: 1) {
                if string1[index1 - 1] == string2[index2 - 1] {
                    dp[index1][index2] = 1 + dp[index1 - 1][index2 - 1]

                } else {

                    let first = dp[index1][index2 - 1]
                    let second = dp[index1 - 1][index2]

                    dp[index1][index2] = max(first, second)
                }
            }
        }

        var index1 = count1
        var index2 = count2
        var result = [Character]()
        while index1 > 0 && index2 > 0 {
            if string1[index1 - 1] == string2[index2 - 1] {
                result.append(string1[index1 - 1])
                index1 -= 1
                index2 -= 1
            } else if dp[index1 - 1][index2] > dp[index1][index2 - 1] {
                result.append(string1[index1 - 1])
                index1 -= 1
            } else {
                result.append(string2[index2 - 1])
                index2 -= 1
            }
        }

        while index1 > 0 {
            result.append(string1[index1 - 1])
            index1 -= 1
        }

        while index2 > 0 {
            result.append(string2[index2 - 1])
            index2 -= 1
        }
        result.reverse()
        return String(result)
    }

    func shortestCommonSupersequenceSpaceOptiMost1(_ str1: String, _ str2: String) -> String {
        let string1 = Array(str1)
        let string2 = Array(str2)
        let count1 = string1.count
        let count2 = string2.count
        var dp = [[Int]](repeating: [Int](repeating: 0, count: count2 + 1), count: count1 + 1)

        for index1 in stride(from: 1, through: count1, by: 1) {
            for index2 in stride(from: 1, through: count2, by: 1) {
                if string1[index1 - 1] == string2[index2 - 1] {
                    dp[index1][index2] = 1 + dp[index1 - 1][index2 - 1]

                } else {

                    let first = dp[index1][index2 - 1]
                    let second = dp[index1 - 1][index2]

                    dp[index1][index2] = max(first, second)
                }
            }
        }

        var index1 = count1
        var index2 = count2
        var scsCount = count1 + count2 - dp[index1][index2]
        var result = [Character](repeating: Character(" "), count: scsCount)
        scsCount -= 1
        while index1 > 0 && index2 > 0 {
            if string1[index1 - 1] == string2[index2 - 1] {
                result[scsCount] = string1[index1 - 1]
                index1 -= 1
                index2 -= 1
                scsCount -= 1
            } else if dp[index1 - 1][index2] > dp[index1][index2 - 1] {
                result[scsCount] = string1[index1 - 1]
                index1 -= 1
                scsCount -= 1
            } else {
                result[scsCount] = string2[index2 - 1]
                index2 -= 1
                scsCount -= 1
            }
        }

        while index1 > 0 {
            result[scsCount] = string1[index1 - 1]
            index1 -= 1
            scsCount -= 1
        }

        while index2 > 0 {
            result[scsCount] = string2[index2 - 1]
            index2 -= 1
            scsCount -= 1
        }
        return String(result)
    }

    /*
     iven a string s, return the length of the longest repeating substrings. If no repeating substring exists, return 0.



     Example 1:

     Input: s = "abcd"
     Output: 0
     Explanation: There is no repeating substring.
     Example 2:

     Input: s = "abbaba"
     Output: 2
     Explanation: The longest repeating substrings are "ab" and "ba", each of which occurs twice.
     Example 3:

     Input: s = "aabcaabdaab"
     Output: 3
     Explanation: The longest repeating substring is "aab", which occurs 3 times.


     Constraints:

     1 <= s.length <= 2000
     s consists of lowercase English letters.
     */

    func longestRepeatingSubstring(_ s: String) -> Int {
        let charArray = Array(s)
        var result = 0
        let count = charArray.count
        var dp = [[Int]](repeating: [Int](repeating: 0, count: count + 1), count: count + 1)
        for i in stride(from: 1, through: count, by: 1) {
            for j in stride(from: i + 1, through: count, by: 1) {
                if charArray[j - 1] == charArray[i - 1] {
                    dp[i][j] = 1 + dp[i - 1][j - 1]
                    result = max(dp[i][j], result)
                }
            }
        }
        return result
    }

    /*
     Given two strings s and t, return the number of distinct subsequences of s which equals t.

     The test cases are generated so that the answer fits on a 32-bit signed integer.



     Example 1:

     Input: s = "rabbbit", t = "rabbit"
     Output: 3
     Explanation:
     As shown below, there are 3 ways you can generate "rabbit" from s.
     rabbbit
     rabbbit
     rabbbit
     Example 2:

     Input: s = "babgbag", t = "bag"
     Output: 5
     Explanation:
     As shown below, there are 5 ways you can generate "bag" from s.
     babgbag
     babgbag
     babgbag
     babgbag
     babgbag


     Constraints:

     1 <= s.length, t.length <= 1000
     s and t consist of English letters.
     */

    func numDistinctRec(_ s: String, _ t: String) -> Int {
        distinctSubsequencesRec(s: Array(s), t: Array(t), sIndex: s.count - 1, tIndex: t.count - 1)
    }

    func distinctSubsequencesRec(s: [Character], t: [Character], sIndex: Int, tIndex: Int) -> Int {
        if tIndex < 0 {
            return 1
        }
        if sIndex < 0 {
            return 0
        }

        if s[sIndex] == t[tIndex] {
            return distinctSubsequencesRec(s: s, t: t, sIndex: sIndex - 1, tIndex: tIndex - 1) +
            distinctSubsequencesRec(s: s, t: t, sIndex: sIndex - 1, tIndex: tIndex)
        }
        return distinctSubsequencesRec(s: s, t: t, sIndex: sIndex - 1, tIndex: tIndex)
    }

    // TC - O(N * M)
    // SC - O(N * M) + O(N + M)
    func numDistinctMemo(_ s: String, _ t: String) -> Int {
        let sCount = s.count
        let tCount = t.count

        var dp = [[Int]](repeating: [Int](repeating: -1, count: tCount), count: sCount)
        return distinctSubsequencesMemo(s: Array(s), t: Array(t), dp: &dp, sIndex: sCount - 1, tIndex: tCount - 1)
    }

    func distinctSubsequencesMemo(s: [Character], t: [Character], dp: inout [[Int]], sIndex: Int, tIndex: Int) -> Int {
        if tIndex < 0 {
            return 1
        }
        if sIndex < 0 {
            return 0
        }
        if dp[sIndex][tIndex] != -1 {
            return dp[sIndex][tIndex]
        }

        if s[sIndex] == t[tIndex] {
            dp[sIndex][tIndex] = distinctSubsequencesMemo(s: s, t: t, dp: &dp, sIndex: sIndex - 1, tIndex: tIndex - 1) + distinctSubsequencesMemo(s: s, t: t, dp: &dp, sIndex: sIndex - 1, tIndex: tIndex)
            return dp[sIndex][tIndex]
        }
        dp[sIndex][tIndex] = distinctSubsequencesMemo(s: s, t: t, dp: &dp, sIndex: sIndex - 1, tIndex: tIndex)
        return dp[sIndex][tIndex]
    }

    func numDistinctTabu(_ s: String, _ t: String) -> Int {
        let sCount = s.count
        let tCount = t.count

        var dp = [[Double]](repeating: [Double](repeating: 0, count: tCount + 1), count: sCount + 1)
        let sArray = Array(s)
        let tArray = Array(t)
        for sIndex in stride(from: 0, through: sCount, by: 1) {
            dp[sIndex][0] = 1
        }

        for sIndex in stride(from: 1, through: sCount, by: 1) {
            for tIndex in stride(from: 1, through: tCount, by: 1) {
                if sArray[sIndex - 1] == tArray[tIndex - 1] {
                    dp[sIndex][tIndex] = dp[sIndex - 1][tIndex - 1] + dp[sIndex - 1][tIndex]

                } else {
                    dp[sIndex][tIndex] = dp[sIndex - 1][tIndex]
                }

            }
        }
        return Int(dp[sCount][tCount])
    }

    func numDistinctSpaceOpti(_ s: String, _ t: String) -> Int {
        let sCount = s.count
        let tCount = t.count

        var previous = [Double](repeating: 0, count: tCount + 1)
        var current = previous
        let sArray = Array(s)
        let tArray = Array(t)
        previous[0] = 1

        for sIndex in stride(from: 1, through: sCount, by: 1) {
            current = previous
            for tIndex in stride(from: 1, through: tCount, by: 1) {
                if sArray[sIndex - 1] == tArray[tIndex - 1] {
                    current[tIndex] = previous[tIndex - 1] + previous[tIndex]

                } else {
                    current[tIndex] = previous[tIndex]
                }

            }
            previous = current
        }
        return Int(previous[tCount])
    }

    func numDistinctSpaceOpti2(_ s: String, _ t: String) -> Int {
        let sCount = s.count
        let tCount = t.count

        var previous = [Double](repeating: 0, count: tCount + 1)
        let sArray = Array(s)
        let tArray = Array(t)
        previous[0] = 1

        for sIndex in stride(from: 1, through: sCount, by: 1) {
            for tIndex in stride(from: tCount, through: 1, by: -1) {
                if sArray[sIndex - 1] == tArray[tIndex - 1] {
                    previous[tIndex] = previous[tIndex - 1] + previous[tIndex]

                }

            }
        }
        return Int(previous[tCount])
    }
    /*
     Given two strings word1 and word2, return the minimum number of operations required to convert word1 to word2.

     You have the following three operations permitted on a word:

     Insert a character
     Delete a character
     Replace a character


     Example 1:

     Input: word1 = "horse", word2 = "ros"
     Output: 3
     Explanation:
     horse -> rorse (replace 'h' with 'r')
     rorse -> rose (remove 'r')
     rose -> ros (remove 'e')
     Example 2:

     Input: word1 = "intention", word2 = "execution"
     Output: 5
     Explanation:
     intention -> inention (remove 't')
     inention -> enention (replace 'i' with 'e')
     enention -> exention (replace 'n' with 'x')
     exention -> exection (replace 'n' with 'c')
     exection -> execution (insert 'u')


     Constraints:

     0 <= word1.length, word2.length <= 500
     word1 and word2 consist of lowercase English letters.
     */

    // TC - O(2^n*2^m) Exponential
    // SC - O(n + m)
    func minDistanceRec(_ word1: String, _ word2: String) -> Int {
        minDistanceRecursion(word1: Array(word1), word2: Array(word2), index1: word1.count - 1, index2: word2.count - 1)
    }

    func minDistanceRecursion(word1: [Character], word2: [Character], index1: Int, index2: Int) -> Int {
        if index1 < 0 {
            return index2 + 1
        }
        if index2 < 0 {
            return index1 + 1
        }
        if word1[index1] == word2[index2] {
            return minDistanceRecursion(word1: word1, word2: word2, index1: index1 - 1, index2: index2 - 1)
        }
        let insert = 1 + minDistanceRecursion(word1: word1, word2: word2, index1: index1, index2: index2 - 1)
        let delete = 1 + minDistanceRecursion(word1: word1, word2: word2, index1: index1 - 1, index2: index2)
        let replace = 1 + minDistanceRecursion(word1: word1, word2: word2, index1: index1 - 1, index2: index2 - 1)
        return min(insert, delete, replace)
    }

    // TC - O(n * m)
    // SC - O(n * m) + O(n + m)
    func minDistanceMemo(_ word1: String, _ word2: String) -> Int {
        let count1 = word1.count
        let count2 = word2.count
        var dp = [[Int]](repeating: [Int](repeating: -1, count: count2), count: count1)
        return minDistanceRecursionMemo(word1: Array(word1), word2: Array(word2), dp: &dp, index1: count1 - 1, index2: count2 - 1)
    }

    func minDistanceRecursionMemo(word1: [Character], word2: [Character], dp: inout [[Int]], index1: Int, index2: Int) -> Int {
        if index1 < 0 {
            return index2 + 1
        }
        if index2 < 0 {
            return index1 + 1
        }
        if dp[index1][index2] != -1 {
            return dp[index1][index2]
        }
        if word1[index1] == word2[index2] {
            dp[index1][index2] = minDistanceRecursionMemo(word1: word1, word2: word2, dp: &dp, index1: index1 - 1, index2: index2 - 1)
            return dp[index1][index2]
        }
        let insert = 1 + minDistanceRecursionMemo(word1: word1, word2: word2, dp: &dp, index1: index1, index2: index2 - 1)
        let delete = 1 + minDistanceRecursionMemo(word1: word1, word2: word2, dp: &dp, index1: index1 - 1, index2: index2)
        let replace = 1 + minDistanceRecursionMemo(word1: word1, word2: word2, dp: &dp, index1: index1 - 1, index2: index2 - 1)
        dp[index1][index2] = min(insert, delete, replace)
        return dp[index1][index2]
    }

    // TC - O(n * m)
    // SC - O(n * m)
    func minDistanceTabu(_ word1: String, _ word2: String) -> Int {
        let count1 = word1.count
        let count2 = word2.count
        let string1 = Array(word1)
        let string2 = Array(word2)
        var dp = [[Int]](repeating: [Int](repeating: 0, count: count2 + 1), count: count1 + 1)
        for index2 in stride(from: 0, through: count2, by: 1) {
            dp[0][index2] = index2
        }
        for index1 in stride(from: 0, through: count1, by: 1) {
            dp[index1][0] = index1
        }

        for index1 in stride(from: 1, through: count1, by: 1) {
            for index2 in stride(from: 1, through: count2, by: 1) {
                if string1[index1 - 1] == string2[index2 - 1] {
                    dp[index1][index2] = dp[index1 - 1][index2 - 1]
                } else {
                    let insert = 1 + dp[index1][index2 - 1]
                    let delete = 1 + dp[index1 - 1][index2]
                    let replace = 1 + dp[index1 - 1][index2 - 1]
                    dp[index1][index2] = min(insert, delete, replace)
                }
            }
        }
        return dp[count1][count2]
    }

    // TC - O(n * m)
    // SC - O(m)
    func minDistanceSpaceOpti(_ word1: String, _ word2: String) -> Int {
        let count1 = word1.count
        let count2 = word2.count
        let string1 = Array(word1)
        let string2 = Array(word2)
        var previous =  [Int](repeating: 0, count: count2 + 1)
        for index2 in stride(from: 0, through: count2, by: 1) {
            previous[index2] = index2
        }
        var current = previous

        for index1 in stride(from: 1, through: count1, by: 1) {
            current[0] = index1
            for index2 in stride(from: 1, through: count2, by: 1) {
                if string1[index1 - 1] == string2[index2 - 1] {
                    current[index2] = previous[index2 - 1]
                } else {
                    let insert = 1 + current[index2 - 1]
                    let delete = 1 + previous[index2]
                    let replace = 1 + previous[index2 - 1]
                    current[index2] = min(insert, delete, replace)
                }
            }
            previous = current
        }
        return previous[count2]
    }

    /*
     Given an input string (s) and a pattern (p), implement wildcard pattern matching with support for '?' and '*' where:

     '?' Matches any single character.
     '*' Matches any sequence of characters (including the empty sequence).
     The matching should cover the entire input string (not partial).



     Example 1:

     Input: s = "aa", p = "a"
     Output: false
     Explanation: "a" does not match the entire string "aa".
     Example 2:

     Input: s = "aa", p = "*"
     Output: true
     Explanation: '*' matches any sequence.
     Example 3:

     Input: s = "cb", p = "?a"
     Output: false
     Explanation: '?' matches 'c', but the second letter is 'a', which does not match 'b'.


     Constraints:

     0 <= s.length, p.length <= 2000
     s contains only lowercase English letters.
     p contains only lowercase English letters, '?' or '*'.
     */

    func isMatchRec(_ s: String, _ p: String) -> Bool {
        isMatchRecusion(s: Array(s), p: Array(p), indexS: s.count - 1, indexP: p.count - 1)
    }

    func isMatchRecusion(s: [Character], p: [Character], indexS: Int, indexP: Int) -> Bool {
        if indexS < 0 && indexP < 0 {
            return true
        }
        if indexP < 0 && indexS >= 0 {
            return false
        }
        if indexS < 0 {
            for i in stride(from: indexP, through: 0, by: -1) {
                if p[indexP] != "*" {
                    return false
                }
            }
            return true
        }
        if s[indexS] == p[indexP] || p[indexP] == "?" {
            return isMatchRecusion(s: s, p: p, indexS: indexS - 1, indexP: indexP - 1)
        }
        if p[indexP] == "*" {
            return isMatchRecusion(s: s, p: p, indexS: indexS - 1, indexP: indexP) || isMatchRecusion(s: s, p: p, indexS: indexS, indexP: indexP - 1)
        }
        return false
    }

    // TC - O(n * m)
    // SC - O(n * m) + O(n + m)
    func isMatchMemo(_ s: String, _ p: String) -> Bool {
        let countS = s.count
        let countP = p.count
        var dp = [[Int]](repeating: [Int](repeating: -1, count: countP), count: countS)
        return isMatchRecusionMemo(s: Array(s), p: Array(p), dp: &dp, indexS: s.count - 1, indexP: p.count - 1)
    }

    func isMatchRecusionMemo(s: [Character], p: [Character], dp: inout [[Int]], indexS: Int, indexP: Int) -> Bool {
        if indexS < 0 && indexP < 0 {
            return true
        }
        if indexP < 0 && indexS >= 0 {
            return false
        }
        if indexS < 0 {
            for i in stride(from: indexP, through: 0, by: -1) {
                if p[i] != "*" {
                    return false
                }
            }
            return true
        }
        if dp[indexS][indexP] != -1 {
            return dp[indexS][indexP] == 1
        }
        if s[indexS] == p[indexP] || p[indexP] == "?" {
            dp[indexS][indexP] = isMatchRecusionMemo(s: s, p: p, dp: &dp, indexS: indexS - 1, indexP: indexP - 1) ? 1 : 0
            return dp[indexS][indexP] == 1
        }
        if p[indexP] == "*" {
            dp[indexS][indexP] = isMatchRecusionMemo(s: s, p: p, dp: &dp, indexS: indexS - 1, indexP: indexP) || isMatchRecusionMemo(s: s, p: p, dp: &dp, indexS: indexS, indexP: indexP - 1) ? 1: 0
            return dp[indexS][indexP] == 1
        }
        return false
    }

    func isMatchMemo1(_ s: String, _ p: String) -> Bool {
        let countS = s.count
        let countP = p.count
        var dp = [[Int]](repeating: [Int](repeating: -1, count: countP + 1), count: countS + 1)
        return isMatchRecusionMemo1(s: Array(s), p: Array(p), dp: &dp, indexS: countS, indexP: countP)
    }

    func isMatchRecusionMemo1(s: [Character], p: [Character], dp: inout [[Int]], indexS: Int, indexP: Int) -> Bool {
        if indexS == 0 && indexP == 0 {
            return true
        }
        if indexP == 0 && indexS > 0 {
            return false
        }
        if indexS == 0 && indexP > 0 {
            for i in stride(from: indexP, through: 1, by: -1) {
                if p[i - 1] != "*" {
                    return false
                }
            }
            return true
        }
        if dp[indexS][indexP] != -1 {
            return dp[indexS][indexP] == 1
        }
        if s[indexS - 1] == p[indexP - 1] || p[indexP - 1] == "?" {
            dp[indexS][indexP] = isMatchRecusionMemo1(s: s, p: p, dp: &dp, indexS: indexS - 1, indexP: indexP - 1) ? 1 : 0
            return dp[indexS][indexP] == 1
        }
        if p[indexP - 1] == "*" {
            dp[indexS][indexP] = isMatchRecusionMemo1(s: s, p: p, dp: &dp, indexS: indexS - 1, indexP: indexP) || isMatchRecusionMemo1(s: s, p: p, dp: &dp, indexS: indexS, indexP: indexP - 1) ? 1: 0
            return dp[indexS][indexP] == 1
        }
        return false
    }

    func isMatchTab(_ s: String, _ p: String) -> Bool {
        let countS = s.count
        let countP = p.count
        let target = Array(s)
        let pattern = Array(p)
        var dp = [[Bool]](repeating: [Bool](repeating: false, count: countS + 1), count: countP + 1)
        dp[0][0] = true
        for indexS in stride(from: 1, through: countS, by: 1) {
            dp[0][indexS] = false
        }
        var flag = true
        for indexP in stride(from: countP, through: 1, by: -1) {
            var flag = true
            for i in stride(from: indexP, through: 1, by: -1) {
                if pattern[i - 1] != "*" {
                    flag = false
                }
            }
            dp[indexP][0] = flag
        }
        for indexP in stride(from: 1, through: countP, by: 1) {
            for indexS in stride(from: 1, through: countS, by: 1) {
                if target[indexS - 1] == pattern[indexP - 1] || pattern[indexP - 1] == "?" {
                    dp[indexP][indexS] = dp[indexP - 1][indexS - 1]
                }
                if pattern[indexP - 1] == "*" {
                    dp[indexP][indexS] = dp[indexP][indexS - 1] || dp[indexP - 1][indexS]
                }
            }
        }

        return dp[countP][countS]
    }

    func isMatchSpaceOpti(_ s: String, _ p: String) -> Bool {
        let countS = s.count
        let countP = p.count
        let target = Array(s)
        let pattern = Array(p)
        
        var previous =  [Bool](repeating: false, count: countS + 1)
        previous[0] = true
        var current = previous
        for indexP in stride(from: 1, through: countP, by: 1) {
            var flag = true
            for i in stride(from: indexP, through: 1, by: -1) {
                if pattern[i - 1] != "*" {
                    flag = false
                }
            }
            current[0] = flag
            for indexS in stride(from: 1, through: countS, by: 1) {
                if target[indexS - 1] == pattern[indexP - 1] || pattern[indexP - 1] == "?" {
                    current[indexS] = previous[indexS - 1]
                } else if pattern[indexP - 1] == "*" {
                    current[indexS] = current[indexS - 1] || previous[indexS]
                } else {
                    current[indexS] = false
                }
            }
            previous = current
        }
        
        return previous[countS]
    }

    /*
     You are given an array of words where each word consists of lowercase English letters.

     wordA is a predecessor of wordB if and only if we can insert exactly one letter anywhere in wordA without changing the order of the other characters to make it equal to wordB.

     For example, "abc" is a predecessor of "abac", while "cba" is not a predecessor of "bcad".
     A word chain is a sequence of words [word1, word2, ..., wordk] with k >= 1, where word1 is a predecessor of word2, word2 is a predecessor of word3, and so on. A single word is trivially a word chain with k == 1.

     Return the length of the longest possible word chain with words chosen from the given list of words.



     Example 1:

     Input: words = ["a","b","ba","bca","bda","bdca"]
     Output: 4
     Explanation: One of the longest word chains is ["a","ba","bda","bdca"].
     Example 2:

     Input: words = ["xbc","pcxbcf","xb","cxbc","pcxbc"]
     Output: 5
     Explanation: All the words can be put in a word chain ["xb", "xbc", "cxbc", "pcxbc", "pcxbcf"].
     Example 3:

     Input: words = ["abcd","dbqca"]
     Output: 1
     Explanation: The trivial word chain ["abcd"] is one of the longest word chains.
     ["abcd","dbqca"] is not a valid word chain because the ordering of the letters is changed.

     */

    // TC - O(N ^ 2 * l)
    func longestStrChain(_ words: [String]) -> Int {

        let count = words.count
        var words = words.sorted { $0.count < $1.count }
        print("Sorted - \(words)")
        var maximum = Int.min
        var dp = [Int](repeating: 1, count: count)
        for index in stride(from: 0, through: count - 1, by: 1) {
            for previousIndex in stride(from: 0, through: index - 1, by: 1) {
                if compare(string1: Array(words[index]), string2: Array(words[previousIndex])) && 1 + dp[previousIndex] > dp[index] {
                    dp[index] = 1 + dp[previousIndex]
                }
            }
            maximum = max(maximum, dp[index])
        }
        return maximum
    }

    func compare(string1: [Character], string2: [Character]) -> Bool {
        guard string1.count == string2.count + 1 else {
            return false
        }
        var count1 = 0
        var count2 = 0
        while count1 < string1.count {
            if count2 == string2.count {
                count1 += 1
                break
            }
            if string1[count1] == string2[count2] {
                count1 += 1
                count2 += 1
            } else {
                count1 += 1
            }
        }
        return count1 == string1.count && count2 == string2.count

    }
}
