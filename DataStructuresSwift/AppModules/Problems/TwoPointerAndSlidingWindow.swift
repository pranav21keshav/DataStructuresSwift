//
//  TwoPointerAndSlidingWindow.swift
//  DataStructuresSwift
//
//  Created by Pranav pravakar on 12/08/25.
//  Copyright © 2025 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation

struct TwoPointerAndSlidingWindow {
    init() {
        var nums = [0, 1, 2, 2]
        print("totalFruit - \(nums) - \(totalFruit(nums))")
    }
    /*
     977. Squares of a Sorted Array

     Given an integer array nums sorted in non-decreasing order, return an array of the squares of each number sorted in non-decreasing order.



     Example 1:

     Input: nums = [-4,-1,0,3,10]
     Output: [0,1,9,16,100]
     Explanation: After squaring, the array becomes [16,1,0,9,100].
     After sorting, it becomes [0,1,9,16,100].
     Example 2:

     Input: nums = [-7,-3,2,3,11]
     Output: [4,9,9,49,121]


     Constraints:

     1 <= nums.length <= 104
     -104 <= nums[i] <= 104
     nums is sorted in non-decreasing order.


     Follow up: Squaring each element and sorting the new array is very trivial, could you find an O(n) solution using a different approach?
     */
    // BF - Square and sort
    // Two pointer
    func sortedSquares(_ nums: [Int]) -> [Int] {
        let count = nums.count
        var result = [Int](repeating: 0, count: count)
        var left = 0
        var right = count - 1
        for i in stride(from: count - 1, through: 0, by: -1) {
            if abs(nums[left]) < abs(nums[right]) {
                result[i] = nums[right] ^ 2
                right -= 1
            } else {
                result[i] = nums[left] ^ 2
                left += 1
            }
        }
        return result
    }
    /*
     1004. Max Consecutive Ones III

     Given a binary array nums and an integer k, return the maximum number of consecutive 1's in the array if you can flip at most k 0's.



     Example 1:

     Input: nums = [1,1,1,0,0,0,1,1,1,1,0], k = 2
     Output: 6
     Explanation: [1,1,1,0,0,1,1,1,1,1,1]
     Bolded numbers were flipped from 0 to 1. The longest subarray is underlined.
     Example 2:

     Input: nums = [0,0,1,1,0,0,1,1,1,0,1,1,0,0,0,1,1,1,1], k = 3
     Output: 10
     Explanation: [0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1]
     Bolded numbers were flipped from 0 to 1. The longest subarray is underlined.


     Constraints:

     1 <= nums.length <= 105
     nums[i] is either 0 or 1.
     0 <= k <= nums.length
     */

    func longestOnes(_ nums: [Int], _ k: Int) -> Int {
        var zeroes = 0
        var maxLength = 0
        var left = 0
        var right = 0
        let count = nums.count
        while right < count {
            if nums[right] == 0 {
                zeroes += 1
            }
            if zeroes > k {
                if nums[left] == 0 {
                    zeroes -= 1
                }
                left += 1
            } else {
                maxLength = max(maxLength, right - left + 1)
            }
            right += 1
        }
        return maxLength
    }

    /*

     You are visiting a farm that has a single row of fruit trees arranged from left to right. The trees are represented by an integer array fruits where fruits[i] is the type of fruit the ith tree produces.

     You want to collect as much fruit as possible. However, the owner has some strict rules that you must follow:

     You only have two baskets, and each basket can only hold a single type of fruit. There is no limit on the amount of fruit each basket can hold.
     Starting from any tree of your choice, you must pick exactly one fruit from every tree (including the start tree) while moving to the right. The picked fruits must fit in one of your baskets.
     Once you reach a tree with fruit that cannot fit in your baskets, you must stop.
     Given the integer array fruits, return the maximum number of fruits you can pick.



     Example 1:

     Input: fruits = [1,2,1]
     Output: 3
     Explanation: We can pick from all 3 trees.
     Example 2:

     Input: fruits = [0,1,2,2]
     Output: 3
     Explanation: We can pick from trees [1,2,2].
     If we had started at the first tree, we would only pick from trees [0,1].
     Example 3:

     Input: fruits = [1,2,3,2,2]
     Output: 4
     Explanation: We can pick from trees [2,3,2,2].
     If we had started at the first tree, we would only pick from trees [1,2].


     Constraints:

     1 <= fruits.length <= 105
     0 <= fruits[i] < fruits.length

     Seen this question in a real interview before?
     1/5
     Yes
     No
     Accepted
     689,228/1.4M
     Acceptance Rate
     49.5%
     Topics
     icon
     Companies
     Similar Questions
     Discussion (294)

     Choose a type



     Copyright © 2025 LeetCode. All rights reserved.

     5.8K


     294


     145 Online
     Swift

     Auto




     12345
     class Solution {
         func totalFruit(_ fruits: [Int]) -> Int {

         }
     }
     Saved
     Case 1
     Case 2
     Case 3

     fruits =
     [1,2,1]
     Search questions

     */

    func totalFruit(_ fruits: [Int]) -> Int {
        let count = fruits.count
        var result = 0
        var left = 0
        var right = 0
        var dict = [Int: Int]()
        while right < count {
            dict[fruits[right]] = (dict[fruits[right]] ?? 0) + 1
            if dict.count <= 2 {
                result = max(result, right - left + 1)

            } else {
                dict[fruits[left]] = dict[fruits[left]]! - 1
                if dict[fruits[left]]! <= 0 {
                    dict.removeValue(forKey: fruits[left])
                }
                left += 1
            }
            right += 1
        }
        return result
    }

    /*

     395. Longest Substring with At Least K Repeating Characters
   
     Given a string s and an integer k, return the length of the longest substring of s such that the frequency of each character in this substring is greater than or equal to k.

     if no such substring exists, return 0.



     Example 1:

     Input: s = "aaabb", k = 3
     Output: 3
     Explanation: The longest substring is "aaa", as 'a' is repeated 3 times.
     Example 2:

     Input: s = "ababbc", k = 2
     Output: 5
     Explanation: The longest substring is "ababb", as 'a' is repeated 2 times and 'b' is repeated 3 times.


     Constraints:

     1 <= s.length <= 104
     s consists of only lowercase English letters.
     1 <= k <= 105
     */

    /*
     340. Longest Substring with At Most K Distinct Characters

     Example 1:

     Input: s = "eceba", k = 2
     Output: 3
     Explanation: The substring is "ece" with length 3.
     Example 2:

     Input: s = "aa", k = 1
     Output: 2
     Explanation: The substring is "aa" with length 2.


     Constraints:

     1 <= s.length <= 5 * 104
     0 <= k <= 50
     */
    func lengthOfLongestSubstringKDistinct(_ s: String, _ k: Int) -> Int {
        let count = s.count
        var left = 0
        var right = 0
        var dictionary = [Character: Int]()
        var result = 0
        while right < count {
            let index = String.Index(utf16Offset: right, in: s)
            let char = s[index]
            dictionary[char] = (dictionary[char] ?? 0) + 1
            if dictionary.count > k {
                let leftIndex = String.Index(utf16Offset: left, in: s)
                let leftChar = s[leftIndex]
                dictionary[leftChar] = dictionary[leftChar]! - 1
                if dictionary[leftChar]! == 0 {
                    dictionary.removeValue(forKey: leftChar)
                }
                left += 1
            } else {
                result = max(result, right - left + 1)
            }
            right += 1
        }
        return result
    }

    /*
     1358. Number of Substrings Containing All Three Characters
     
     Given a string s consisting only of characters a, b and c.

     Return the number of substrings containing at least one occurrence of all these characters a, b and c.



     Example 1:

     Input: s = "abcabc"
     Output: 10
     Explanation: The substrings containing at least one occurrence of the characters a, b and c are "abc", "abca", "abcab", "abcabc", "bca", "bcab", "bcabc", "cab", "cabc" and "abc" (again).
     Example 2:

     Input: s = "aaacb"
     Output: 3
     Explanation: The substrings containing at least one occurrence of the characters a, b and c are "aaacb", "aacb" and "acb".
     Example 3:

     Input: s = "abc"
     Output: 1


     Constraints:

     3 <= s.length <= 5 x 10^4

     */

    func numberOfSubstrings(_ s: String) -> Int {
        var indexCounter = [-1, -1, -1]
        let aAsciiValue = Character("a").asciiValue!
        var result = 0
        for i in stride(from: 0, through: s.count - 1, by: 1) {
            let index = String.Index(utf16Offset: i, in: s)
            let char = s[index]
            indexCounter[Int(char.asciiValue! - aAsciiValue)] = i
            if !indexCounter.contains(-1) {
                result += 1 + indexCounter.min()!
            }
        }
        return result
    }

    /*
     424. Longest Repeating Character Replacement

     You are given a string s and an integer k. You can choose any character of the string and change it to any other uppercase English character. You can perform this operation at most k times.

     Return the length of the longest substring containing the same letter you can get after performing the above operations.



     Example 1:

     Input: s = "ABAB", k = 2
     Output: 4
     Explanation: Replace the two 'A's with two 'B's or vice versa.
     Example 2:

     Input: s = "AABABBA", k = 1
     Output: 4
     Explanation: Replace the one 'A' in the middle with 'B' and form "AABBBBA".
     The substring "BBBB" has the longest repeating letters, which is 4.
     There may exists other ways to achieve this answer too.


     Constraints:

     1 <= s.length <= 105
     s consists of only uppercase English letters.
     0 <= k <= s.length
     */

    // Time limit exceeded
    func characterReplacement(_ s: String, _ k: Int) -> Int {
        var hash = [Int](repeating: 0, count: 26)
        var left = 0
        var right = 0
        let aAsciiValue = Character("A").asciiValue!
        var maxFrequency = 0
        var maxLength = 0
        while right < s.count {
            let index = String.Index(utf16Offset: right, in: s)
            let char = s[index]
            hash[Int(char.asciiValue! - aAsciiValue)] += 1
            maxFrequency = max(maxFrequency, hash[Int(char.asciiValue! - aAsciiValue)])
            if (right - left + 1) - maxFrequency > k {
                let leftIndex = String.Index(utf16Offset: left, in: s)
                let leftChar = s[leftIndex]
                hash[Int(leftChar.asciiValue! - aAsciiValue)] -= 1
                left += 1
            } else {
                maxLength = max(maxLength, right - left + 1)
            }
            right += 1

        }
        return maxLength
    }

    func characterReplacementUsingChar(_ s: String, _ k: Int) -> Int {
        var hash = [Int](repeating: 0, count: 26)
        var left = 0
        var right = 0
        let aAsciiValue = Character("A").asciiValue!
        var maxFrequency = 0
        var maxLength = 0
        let string = Array(s)
        let count = string.count
        while right < count {
            let char = string[right]
            let index = Int(char.asciiValue! - aAsciiValue)
            hash[index] += 1
            maxFrequency = max(maxFrequency, hash[index])
            if (right - left + 1) - maxFrequency > k {
                let leftChar = string[left]
                hash[Int(leftChar.asciiValue! - aAsciiValue)] -= 1
                left += 1
            } else {
                maxLength = max(maxLength, right - left + 1)
            }
            right += 1

        }
        return maxLength
    }

    /*
     930. Binary Subarrays With Sum
     Medium
     Topics
     conpanies icon
     Companies
     Given a binary array nums and an integer goal, return the number of non-empty subarrays with a sum goal.

     A subarray is a contiguous part of the array.



     Example 1:

     Input: nums = [1,0,1,0,1], goal = 2
     Output: 4
     Explanation: The 4 subarrays are bolded and underlined below:
     [1,0,1,0,1]
     [1,0,1,0,1]
     [1,0,1,0,1]
     [1,0,1,0,1]
     Example 2:

     Input: nums = [0,0,0,0,0], goal = 0
     Output: 15


     Constraints:

     1 <= nums.length <= 3 * 104
     nums[i] is either 0 or 1.
     0 <= goal <= nums.length
     */
    func numSubarraysWithSum(_ nums: [Int], _ goal: Int) -> Int {
        countSubarraysWithSum(nums, goal) - countSubarraysWithSum(nums, goal - 1)
    }

    func countSubarraysWithSum(_ nums: [Int], _ goal: Int) -> Int {
        if goal < 0 {
            return 0
        }
        let count = nums.count
        var left = 0
        var right = 0
        var sum = 0
        var result = 0
        while right < count {
            sum += nums[right]
            while sum > goal {
                sum -= nums[left]
                left += 1
            }
            result += right - left + 1
            right += 1
        }
        return result
    }

    /*
     1248. Count Number of Nice Subarrays

     Given an array of integers nums and an integer k. A continuous subarray is called nice if there are k odd numbers on it.

     Return the number of nice sub-arrays.



     Example 1:

     Input: nums = [1,1,2,1,1], k = 3
     Output: 2
     Explanation: The only sub-arrays with 3 odd numbers are [1,1,2,1] and [1,2,1,1].
     Example 2:

     Input: nums = [2,4,6], k = 1
     Output: 0
     Explanation: There are no odd numbers in the array.
     Example 3:

     Input: nums = [2,2,2,1,2,2,1,2,2,2], k = 2
     Output: 16


     Constraints:

     1 <= nums.length <= 50000
     1 <= nums[i] <= 10^5
     1 <= k <= nums.length
     */

    func numberOfSubarrays(_ nums: [Int], _ k: Int) -> Int {
        countNiceSubarraysWithSum(nums, k) - countNiceSubarraysWithSum(nums, k - 1)
       }

    func countNiceSubarraysWithSum(_ nums: [Int], _ goal: Int) -> Int {
        if goal < 0 {
            return 0
        }
        let count = nums.count
        var left = 0
        var right = 0
        var sum = 0
        var result = 0
        while right < count {
            sum += nums[right] % 2
            while sum > goal {
                sum -= nums[left] % 2
                left += 1
            }
            result += right - left + 1
            right += 1
        }
        return result
    }

    /*
     992. Subarrays with K Different Integers

     Given an integer array nums and an integer k, return the number of good subarrays of nums.

     A good array is an array where the number of different integers in that array is exactly k.

     For example, [1,2,3,1,2] has 3 different integers: 1, 2, and 3.
     A subarray is a contiguous part of an array.



     Example 1:

     Input: nums = [1,2,1,2,3], k = 2
     Output: 7
     Explanation: Subarrays formed with exactly 2 different integers: [1,2], [2,1], [1,2], [2,3], [1,2,1], [2,1,2], [1,2,1,2]
     Example 2:

     Input: nums = [1,2,1,3,4], k = 3
     Output: 3
     Explanation: Subarrays formed with exactly 3 different integers: [1,2,1,3], [2,1,3], [1,3,4].


     Constraints:

     1 <= nums.length <= 2 * 104
     1 <= nums[i], k <= nums.length
     */

    func subarraysWithKDistinct(_ nums: [Int], _ k: Int) -> Int {
        countSubarraysWithKDistinct(nums, k) - countSubarraysWithKDistinct(nums, k - 1)
    }
    
    private func countSubarraysWithKDistinct(_ nums: [Int], _ k: Int) -> Int {
        if k < 0 {
            return 0
        }
        let count = nums.count
        var dict = [Int: Int]()
        var left = 0
        var right = 0
        var result = 0
        while right < count {
            dict[nums[right]] = (dict[nums[right]] ?? 0) + 1
            while dict.count > k {
                dict[nums[left]] = dict[nums[left]]! - 1
                if dict[nums[left]] == 0 {
                    dict.removeValue(forKey: nums[left])
                }
                left += 1
            }
            result += right - left + 1
            right += 1
            
        }
        return result
    }
}
