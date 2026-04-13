//
//  StackProblems.swift
//  DataStructuresSwift
//
//  Created by Pranav pravakar on 10/08/25.
//  Copyright © 2025 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation
//swiftlint:disable file_length
struct StackProblems {
    init() {
        var values = [2, 1, 5, 6, 2, 3]
        print("is valid {[()]} - \(isValid("{[()]}"))")
        print("NSE \(values) - \(nextSmallerElements(array: values))")
        print("PSE \(values) - \(previousSmallerElements(array: values))")
        print("NSE Index \(values) - \(nextSmallerElementsIndex(array: values))")
        print("PSE Index \(values) - \(previousSmallerElementsIndex(array: values))")
        print("largestRectangleArea - \(values) - \(largestRectangleArea(values))")
    }
    /*
     71. Simplify Path

     You are given an absolute path for a Unix-style file system, which always begins with a slash '/'. Your task is to transform this absolute path into its simplified canonical path.

     The rules of a Unix-style file system are as follows:

     A single period '.' represents the current directory.
     A double period '..' represents the previous/parent directory.
     Multiple consecutive slashes such as '//' and '///' are treated as a single slash '/'.
     Any sequence of periods that does not match the rules above should be treated as a valid directory or file name. For example, '...' and '....' are valid directory or file names.
     The simplified canonical path should follow these rules:

     The path must start with a single slash '/'.
     Directories within the path must be separated by exactly one slash '/'.
     The path must not end with a slash '/', unless it is the root directory.
     The path must not have any single or double periods ('.' and '..') used to denote current or parent directories.
     Return the simplified canonical path.



     Example 1:

     Input: path = "/home/"

     Output: "/home"

     Explanation:

     The trailing slash should be removed.

     Example 2:

     Input: path = "/home//foo/"

     Output: "/home/foo"

     Explanation:

     Multiple consecutive slashes are replaced by a single one.

     Example 3:

     Input: path = "/home/user/Documents/../Pictures"

     Output: "/home/user/Pictures"

     Explanation:

     A double period ".." refers to the directory up a level (the parent directory).

     Example 4:

     Input: path = "/../"

     Output: "/"

     Explanation:

     Going one level up from the root directory is not possible.

     Example 5:

     Input: path = "/.../a/../b/c/../d/./"

     Output: "/.../b/d"

     Explanation:

     "..." is a valid name for a directory in this problem.



     Constraints:

     1 <= path.length <= 3000
     path consists of English letters, digits, period '.', slash '/' or '_'.
     path is a valid absolute Unix path.


     */
    func simplifyPath(_ path: String) -> String {
        var components = path.components(separatedBy: "/")
        var result = [String]()
        for component in components {
            if component.isEmpty || component == "." {
                continue
            } else if component == ".." {
                if !result.isEmpty {
                    result.removeLast()
                }
                
            } else {
                result.append(component)
            }
        }
        var string = String(result.joined(separator: "/"))
        string = "/" + string
        return string
    }
    /*
     20. Valid Parentheses

     Given a string s containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.

     An input string is valid if:

     Open brackets must be closed by the same type of brackets.
     Open brackets must be closed in the correct order.
     Every close bracket has a corresponding open bracket of the same type.


     Example 1:

     Input: s = "()"

     Output: true

     Example 2:

     Input: s = "()[]{}"

     Output: true

     Example 3:

     Input: s = "(]"

     Output: false

     Example 4:

     Input: s = "([])"

     Output: true

     Example 5:

     Input: s = "([)]"

     Output: false



     Constraints:

     1 <= s.length <= 104
     s consists of parentheses only '()[]{}'.
     */

    // Valid parenthesis without stack
    func isValid(_ s: String) -> Bool {
        var charArray = Array(s)
        var top = -1
        for i in 0..<charArray.count {
            if top < 0 || !match(left: charArray[top], right: charArray[i]) {
                top += 1
                charArray[top] = charArray[i]
            } else {
                top -= 1
            }
        }
        return top == -1
    }

    func match(left: Character, right: Character) -> Bool {
        return (left == "(" && right == ")") || (left == "{" && right == "}") || (left == "[" && right == "]")
    }

    func isValidStack(_ s: String) -> Bool {
        var charArray = Array(s)
        var stack = [Character]()
        for char in charArray {
            if char == "(" || char == "{" || char == "[" {
                stack.append(char)
            } else if stack.isEmpty {
                return false
            } else {
                let popped = stack.removeLast()
                if (popped == "(" && char == ")") || (popped == "{" && char == "}") || (popped == "[" && char == "]") {
                    continue
                } else {
                    return false
                }
            }
        }
        return stack.isEmpty
    }

    /*

     1249. Minimum Remove to Make Valid Parentheses

     Given a string s of '(' , ')' and lowercase English characters.

     Your task is to remove the minimum number of parentheses ( '(' or ')', in any positions ) so that the resulting parentheses string is valid and return any valid string.

     Formally, a parentheses string is valid if and only if:

     It is the empty string, contains only lowercase characters, or
     It can be written as AB (A concatenated with B), where A and B are valid strings, or
     It can be written as (A), where A is a valid string.


     Example 1:

     Input: s = "lee(t(c)o)de)"
     Output: "lee(t(c)o)de"
     Explanation: "lee(t(co)de)" , "lee(t(c)ode)" would also be accepted.
     Example 2:

     Input: s = "a)b(c)d"
     Output: "ab(c)d"
     Example 3:

     Input: s = "))(("
     Output: ""
     Explanation: An empty string is also valid.


     Constraints:

     1 <= s.length <= 105
     s[i] is either '(' , ')', or lowercase English letter.
     */
    func minRemoveToMakeValid(_ s: String) -> String {
        var stack = [Int]()
        var indexes = Set<Int>()
        let count = s.count
        for i in stride(from: 0, through: count - 1, by: 1) {
            let char = s[String.Index(utf16Offset: i, in: s)]
            if char == "(" {
                stack.append(i)
            } else if char == ")" {
                if !stack.isEmpty {
                    stack.removeLast()
                } else {
                    indexes.insert(i)
                }
            }
        }
        for index in stack {
            indexes.insert(index)
        }
        var result = ""
        for i in stride(from: 0, through: count - 1, by: 1) {
            if !indexes.contains(i) {
                result.append(s[String.Index(utf16Offset: i, in: s)])
            }
        }
        return result
    }
    // TC - O(2n)
    // SC - O(n) + O(n)
    func nextGreaterElements(array: [Int]) -> [Int] {
        let count = array.count
        var nge = [Int]()
        var stack = [Int]()
        for index in stride(from: count - 1, through: 0, by: -1) {
            while !stack.isEmpty && stack.last! <= array[index] {
                stack.removeLast()
            }
            let element = stack.isEmpty ? -1 : stack.last!
            nge[index] = element
            stack.append(array[index])
        }
        return nge
    }

    // TC - O(2n)
    // SC - O(n) + O(n)
    func nextSmallerElements(array: [Int]) -> [Int] {
        let count = array.count
        var nse = [Int](repeating: -1, count: count)
        var stack = [Int]()
        for index in stride(from: count - 1, through: 0, by: -1) {
            while !stack.isEmpty && stack.last! >= array[index] {
                stack.removeLast()
            }
            let element = stack.isEmpty ? count : stack.last!
            nse[index] = element
            stack.append(array[index])
        }
        return nse
    }

    // TC - O(4N)
    // SC - O(3N)
    func nextGreaterElementCircular(array: [Int]) -> [Int] {
        let count = array.count
        var nge = [Int](repeating: -1, count: count)
        var stack = [Int]()
        for index in stride(from: 2 * count - 1, through: 0, by: -1) {
            while !stack.isEmpty && stack.last! <= array[index % count] {
                stack.removeLast()
            }
            if index < count {
                let element = stack.isEmpty ? -1 : stack.last!
                nge[index] = element
            }
            stack.append(array[index % count])
        }

        return nge
    }

    func previousSmallerElements(array: [Int]) -> [Int] {
        let count = array.count
        var nse = [Int](repeating: -1, count: count)
        var stack = [Int]()

        for index in stride(from: 0, through: count - 1, by: 1) {
            while !stack.isEmpty && stack.last! >= array[index] {
                stack.removeLast()
            }
            let element = stack.isEmpty ? -1 : stack.last!
            nse[index] = element
            stack.append(array[index])
        }
        return nse
    }

    func nextSmallerElementsIndex(array: [Int]) -> [Int] {
        let count = array.count
        var nse = [Int](repeating: count, count: count)
        var stack = [Int]()
        for index in stride(from: count - 1, through: 0, by: -1) {
            while !stack.isEmpty && array[stack.last!] >= array[index] {
                stack.removeLast()
            }
            if !stack.isEmpty {
                nse[index] = stack.last!
            }
            stack.append(index)
        }
        return nse
    }
    
    func previousSmallerElementsIndex(array: [Int]) -> [Int] {
        let count = array.count
        var pse = [Int](repeating: -1, count: count)
        var stack = [Int]()
        for index in stride(from: 0, through: count - 1, by: 1) {
            while !stack.isEmpty && array[stack.last!] >= array[index] {
                stack.removeLast()
            }
            if !stack.isEmpty {
                pse[index] = stack.last!
            }
            stack.append(index)
        }
        return pse
    }

    /*
     42. Trapping Rain Water
     Solved
     Hard
     Topics
     conpanies icon
     Companies
     Given n non-negative integers representing an elevation map where the width of each bar is 1, compute how much water it can trap after raining.



     Example 1:


     Input: height = [0,1,0,2,1,0,1,3,2,1,2,1]
     Output: 6
     Explanation: The above elevation map (black section) is represented by array [0,1,0,2,1,0,1,3,2,1,2,1]. In this case, 6 units of rain water (blue section) are being trapped.
     Example 2:

     Input: height = [4,2,0,3,2,5]
     Output: 9


     Constraints:

     n == height.length
     1 <= n <= 2 * 104
     0 <= height[i] <= 105
     */

    func trap(_ height: [Int]) -> Int {
        let count = height.count
        var suffixArray = Array(repeating: 0, count: count)
        suffixArray[count - 1] = height[count - 1]
        for i in stride(from: count - 2, through: 0, by: -1) {
            suffixArray[i] = max(height[i], suffixArray[i + 1])
        }
        
        var leftMax = height[0]
        var result = 0
        for i in stride(from: 1, through: count - 1, by: 1) {
            let current = height[i]
            leftMax = max(leftMax, current)
            if current < leftMax && current < suffixArray[i] {
                result += (min(leftMax, suffixArray[i]) - current)
            }
            
        }
        return result
        
    }

    func trapEfficient(_ height: [Int]) -> Int {
        let count = height.count
        var left = 0
        var leftMax = 0
        var right = count - 1
        var rightMax = 0
        var result = 0
        while left < right {
            if height[left] <= height[right] {
                if leftMax > height[left] {
                    result += leftMax - height[left]
                } else {
                    leftMax = height[left]
                }
                left += 1
            } else {
                if rightMax > height[right] {
                    result += rightMax - height[right]
                } else {
                    rightMax = height[right]
                }
                right -= 1
            }
        }

        return result

    }

    /*
     907. Sum of Subarray Minimums
     Medium
     Topics
     conpanies icon
     Companies
     Given an array of integers arr, find the sum of min(b), where b ranges over every (contiguous) subarray of arr. Since the answer may be large, return the answer modulo 109 + 7.



     Example 1:

     Input: arr = [3,1,2,4]
     Output: 17
     Explanation:
     Subarrays are [3], [1], [2], [4], [3,1], [1,2], [2,4], [3,1,2], [1,2,4], [3,1,2,4].
     Minimums are 3, 1, 2, 4, 1, 1, 2, 1, 1, 1.
     Sum is 17.
     Example 2:

     Input: arr = [11,81,94,43,3]
     Output: 444


     Constraints:

     1 <= arr.length <= 3 * 104
     1 <= arr[i] <= 3 * 104
     */

    // TC - O(5N)
    // SC - O(5N)
    func sumSubarrayMins(_ arr: [Int]) -> Int {
        let modulo = Int(1e9 + 7)
        let nse = nse(array: arr)
        let pse = psee(array: arr)
        var result = 0
        let count = arr.count
        for i in stride(from: 0, through: count - 1, by: 1) {
            let left = i - pse[i]
            let right = nse[i] - i
            result += (left * right * arr[i]) % modulo
            result %= modulo
        }
        return result
    }

   private  func nse(array: [Int]) -> [Int] {
        let count = array.count
        var nse = [Int](repeating: 0, count: count)
        var stack = [Int]()
        for i in stride(from: count - 1, through: 0, by: -1) {
            while !stack.isEmpty && array[stack.last!] >= array[i] {
                stack.removeLast()
            }
            nse[i] = stack.isEmpty ? count : stack.last!
            stack.append(i)
        }
        return nse
    }

    private func psee(array: [Int]) -> [Int] {
        let count = array.count
        var pse = [Int](repeating: 0, count: count)
        var stack = [Int]()
        for i in stride(from: 0, through: count - 1, by: 1) {
            while !stack.isEmpty && array[stack.last!] > array[i] {
                stack.removeLast()
            }
            pse[i] = stack.isEmpty ? -1 : stack.last!
            stack.append(i)
        }
        return pse
    }

    /*

     2104. Sum of Subarray Ranges
     Medium
     Topics
     conpanies icon
     Companies
     Hint
     You are given an integer array nums. The range of a subarray of nums is the difference between the largest and smallest element in the subarray.

     Return the sum of all subarray ranges of nums.

     A subarray is a contiguous non-empty sequence of elements within an array.



     Example 1:

     Input: nums = [1,2,3]
     Output: 4
     Explanation: The 6 subarrays of nums are the following:
     [1], range = largest - smallest = 1 - 1 = 0
     [2], range = 2 - 2 = 0
     [3], range = 3 - 3 = 0
     [1,2], range = 2 - 1 = 1
     [2,3], range = 3 - 2 = 1
     [1,2,3], range = 3 - 1 = 2
     So the sum of all ranges is 0 + 0 + 0 + 1 + 1 + 2 = 4.
     Example 2:

     Input: nums = [1,3,3]
     Output: 4
     Explanation: The 6 subarrays of nums are the following:
     [1], range = largest - smallest = 1 - 1 = 0
     [3], range = 3 - 3 = 0
     [3], range = 3 - 3 = 0
     [1,3], range = 3 - 1 = 2
     [3,3], range = 3 - 3 = 0
     [1,3,3], range = 3 - 1 = 2
     So the sum of all ranges is 0 + 0 + 0 + 2 + 0 + 2 = 4.
     Example 3:

     Input: nums = [4,-2,-3,4,1]
     Output: 59
     Explanation: The sum of all subarray ranges of nums is 59.


     Constraints:

     1 <= nums.length <= 1000
     -109 <= nums[i] <= 109
     */

    func subArrayRanges(_ nums: [Int]) -> Int {
        let nse = nse(array: nums)
        let pse = psee(array: nums)
        let nge = nge(array: nums)
        let pgee = pgee(array: nums)
        var result = 0
        let count = nums.count
        for i in stride(from: 0, through: count - 1, by: 1) {
            let leftMin = i - pse[i]
            let rightMin = nse[i] - i
            let minSum = (leftMin * rightMin * nums[i])
            let leftMax = i - pgee[i]
            let rightMax = nge[i] - i
            let maxSum = (leftMax * rightMax * nums[i])
            result += (maxSum - minSum)
        }
        return result
    }

    private  func nge(array: [Int]) -> [Int] {
        let count = array.count
        var nse = [Int](repeating: 0, count: count)
        var stack = [Int]()
        for i in stride(from: count - 1, through: 0, by: -1) {
            while !stack.isEmpty && array[stack.last!] <= array[i] {
                stack.removeLast()
            }
            nse[i] = stack.isEmpty ? count : stack.last!
            stack.append(i)
        }
        return nse
    }

    private func pgee(array: [Int]) -> [Int] {
        let count = array.count
        var pse = [Int](repeating: 0, count: count)
        var stack = [Int]()
        for i in stride(from: 0, through: count - 1, by: 1) {
            while !stack.isEmpty && array[stack.last!] < array[i] {
                stack.removeLast()
            }
            pse[i] = stack.isEmpty ? -1 : stack.last!
            stack.append(i)
        }
        return pse
    }

    /*
     735. Asteroid Collision

     We are given an array asteroids of integers representing asteroids in a row. The indices of the asteriod in the array represent their relative position in space.

     For each asteroid, the absolute value represents its size, and the sign represents its direction (positive meaning right, negative meaning left). Each asteroid moves at the same speed.

     Find out the state of the asteroids after all collisions. If two asteroids meet, the smaller one will explode. If both are the same size, both will explode. Two asteroids moving in the same direction will never meet.



     Example 1:

     Input: asteroids = [5,10,-5]
     Output: [5,10]
     Explanation: The 10 and -5 collide resulting in 10. The 5 and 10 never collide.
     Example 2:

     Input: asteroids = [8,-8]
     Output: []
     Explanation: The 8 and -8 collide exploding each other.
     Example 3:

     Input: asteroids = [10,2,-5]
     Output: [10]
     Explanation: The 2 and -5 collide resulting in -5. The 10 and -5 collide resulting in 10.


     Constraints:

     2 <= asteroids.length <= 104
     -1000 <= asteroids[i] <= 1000
     asteroids[i] != 0
     */

    func asteroidCollision(_ asteroids: [Int]) -> [Int] {
        var stack = [Int]()
        for asteroid in asteroids {
            if asteroid > 0 {
                stack.append(asteroid)
            } else {
                while !stack.isEmpty && stack.last! > 0 && stack.last! < abs(asteroid) {
                    stack.removeLast()
                }
                if !stack.isEmpty && stack.last! == abs(asteroid) {
                    stack.removeLast()
                } else if stack.isEmpty || stack.last! < 0 {
                    stack.append(asteroid)
                }
            }
        }
        return stack
    }
    /*
     Given an array of integers heights representing the histogram's bar height where the width of each bar is 1, return the area of the largest rectangle in the histogram.



     Example 1:


     Input: heights = [2,1,5,6,2,3]
     Output: 10
     Explanation: The above is a histogram where width of each bar is 1.
     The largest rectangle is shown in the red area, which has an area = 10 units.
     Example 2:


     Input: heights = [2,4]
     Output: 4


     Constraints:

     1 <= heights.length <= 105
     0 <= heights[i] <= 104
     */

    // TC - O(4N + N)
    // SC - O(4N)
    func largestRectangleAreaBF(_ heights: [Int]) -> Int {
        let nse = nextSmallerElementsIndex(array: heights)
        let pse = previousSmallerElementsIndex(array: heights)
        var maximum = 0
        for index in stride(from: 0, through: heights.count - 1, by: 1) {
            maximum = max(maximum, heights[index] * (nse[index] - pse[index] - 1))
        }
        return maximum
    }

    // TC - O(2N)
    // SC - O(N)
    func largestRectangleArea(_ heights: [Int]) -> Int {
        var stack = [Int]()
        var maximum = 0
        let count = heights.count
        for index in stride(from: 0, through: count, by: 1) {
            while !stack.isEmpty && (index == count || heights[stack.last!] >= heights[index]) {
                let height = heights[stack.removeLast()]
                let width = stack.isEmpty ? index : index - stack.last! - 1
                let area = height * width
                maximum = max(maximum, area)
            }
            stack.append(index)
        }
        return maximum
    }

    /*
     Given a rows x cols binary matrix filled with 0's and 1's, find the largest rectangle containing only 1's and return its area.



     Example 1:


     Input: matrix = [["1","0","1","0","0"],["1","0","1","1","1"],["1","1","1","1","1"],["1","0","0","1","0"]]
     Output: 6
     Explanation: The maximal rectangle is shown in the above picture.
     Example 2:

     Input: matrix = [["0"]]
     Output: 0
     Example 3:

     Input: matrix = [["1"]]
     Output: 1


     Constraints:

     rows == matrix.length
     cols == matrix[i].length
     1 <= row, cols <= 200
     matrix[i][j] is '0' or '1'.
     */

    func maximalRectangle(_ matrix: [[Character]]) -> Int {
        var rowCount = matrix.count
        var columnCount = matrix[0].count
        var histo = [Int](repeating: 0, count: columnCount)
        var result = 0
        for i in stride(from: 0, through: rowCount - 1, by: 1) {
            for j in stride(from: 0, through: columnCount - 1, by: 1) {
                if matrix[i][j] == "1" {
                    histo[j] += 1
                } else {
                    histo[j] = 0
                }
            }
            let area = largestRectangleArea(histo)
            result = max(result, area)

        }
        return result

    }

    /*
     402. Remove K Digits

     Given string num representing a non-negative integer num, and an integer k, return the smallest possible integer after removing k digits from num.



     Example 1:

     Input: num = "1432219", k = 3
     Output: "1219"
     Explanation: Remove the three digits 4, 3, and 2 to form the new number 1219 which is the smallest.
     Example 2:

     Input: num = "10200", k = 1
     Output: "200"
     Explanation: Remove the leading 1 and the number is 200. Note that the output must not contain leading zeroes.
     Example 3:

     Input: num = "10", k = 2
     Output: "0"
     Explanation: Remove all the digits from the number and it is left with nothing which is 0.


     Constraints:

     1 <= k <= num.length <= 105
     num consists of only digits.
     num does not have any leading zeros except for the zero itself.
     */

    func removeKdigits(_ num: String, _ k: Int) -> String {
        var totalCount = k
        var result = [Character]()
        let zeroAscii = Character("0").asciiValue!
        for char in num {
            let current = char.asciiValue! - zeroAscii
            while !result.isEmpty && totalCount > 0 && result.last!.asciiValue! - zeroAscii > current {
                result.removeLast()
                totalCount -= 1
            }
            result.append(char)
            
        }
        if totalCount > 0 {
            result.removeLast(totalCount)
        }
        let returnResult = String(result.drop(while: { $0 == "0" }))
        return returnResult.isEmpty ? "0" : returnResult
    }

    /*
     901. Online Stock Span
     Medium
     Topics
     conpanies icon
     Companies
     Design an algorithm that collects daily price quotes for some stock and returns the span of that stock's price for the current day.

     The span of the stock's price in one day is the maximum number of consecutive days (starting from that day and going backward) for which the stock price was less than or equal to the price of that day.

     For example, if the prices of the stock in the last four days is [7,2,1,2] and the price of the stock today is 2, then the span of today is 4 because starting from today, the price of the stock was less than or equal 2 for 4 consecutive days.
     Also, if the prices of the stock in the last four days is [7,34,1,2] and the price of the stock today is 8, then the span of today is 3 because starting from today, the price of the stock was less than or equal 8 for 3 consecutive days.
     Implement the StockSpanner class:

     StockSpanner() Initializes the object of the class.
     int next(int price) Returns the span of the stock's price given that today's price is price.


     Example 1:

     Input
     ["StockSpanner", "next", "next", "next", "next", "next", "next", "next"]
     [[], [100], [80], [60], [70], [60], [75], [85]]
     Output
     [null, 1, 1, 1, 2, 1, 4, 6]

     Explanation
     StockSpanner stockSpanner = new StockSpanner();
     stockSpanner.next(100); // return 1
     stockSpanner.next(80);  // return 1
     stockSpanner.next(60);  // return 1
     stockSpanner.next(70);  // return 2
     stockSpanner.next(60);  // return 1
     stockSpanner.next(75);  // return 4, because the last 4 prices (including today's price of 75) were less than or equal to today's price.
     stockSpanner.next(85);  // return 6


     Constraints:

     1 <= price <= 105
     At most 104 calls will be made to next.
     */
    // BF - Start from

    // TC - O(2N)
    class StockSpanner {

        var index: Int
        var stack: [(Int, Int)]

        init() {
            index = -1
            stack =  [(Int, Int)]()

        }

        func next(_ price: Int) -> Int {
            index += 1
            while !stack.isEmpty && stack.last!.1 <= price {
                stack.removeLast()
            }
            let answer = index - (stack.isEmpty ? -1 : stack.last!.0)
            stack.append((index, price))
            return answer
        }
    }

    /**
     * Your StockSpanner object will be instantiated and called as such:
     * let obj = StockSpanner()
     * let ret_1: Int = obj.next(price)
     */

    /*
     239. Sliding Window Maximum

     You are given an array of integers nums, there is a sliding window of size k which is moving from the very left of the array to the very right. You can only see the k numbers in the window. Each time the sliding window moves right by one position.

     Return the max sliding window.



     Example 1:

     Input: nums = [1,3,-1,-3,5,3,6,7], k = 3
     Output: [3,3,5,5,6,7]
     Explanation:
     Window position                Max
     ---------------               -----
     [1  3  -1] -3  5  3  6  7       3
      1 [3  -1  -3] 5  3  6  7       3
      1  3 [-1  -3  5] 3  6  7       5
      1  3  -1 [-3  5  3] 6  7       5
      1  3  -1  -3 [5  3  6] 7       6
      1  3  -1  -3  5 [3  6  7]      7
     Example 2:

     Input: nums = [1], k = 1
     Output: [1]


     Constraints:

     1 <= nums.length <= 105
     -104 <= nums[i] <= 104
     1 <= k <= nums.length
     */

    // BF
    // TC - O(n - k) * k
    // SC - O(n - k)
    // DQ

    func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
        var result = [Int]()
        var dequeue = [Int]()
        for (index, element) in nums.enumerated() {
            if !dequeue.isEmpty && dequeue[0] <= index - k {
                dequeue.remove(at: 0)
            }
            while !dequeue.isEmpty && nums[dequeue.last!] <= element {
                dequeue.removeLast()
            }
            dequeue.append(index)
            if index >= k - 1 {
                result.append(nums[dequeue[0]])
            }
        }
        return result
    }

    /*
     277. Find the Celebrity
     Solved
     Medium
     Topics
     conpanies icon
     Companies
     Hint
     Suppose you are at a party with n people labeled from 0 to n - 1 and among them, there may exist one celebrity. The definition of a celebrity is that all the other n - 1 people know the celebrity, but the celebrity does not know any of them.

     Now you want to find out who the celebrity is or verify that there is not one. You are only allowed to ask questions like: "Hi, A. Do you know B?" to get information about whether A knows B. You need to find out the celebrity (or verify there is not one) by asking as few questions as possible (in the asymptotic sense).

     You are given an integer n and a helper function bool knows(a, b) that tells you whether a knows b. Implement a function int findCelebrity(n). There will be exactly one celebrity if they are at the party.

     Return the celebrity's label if there is a celebrity at the party. If there is no celebrity, return -1.

     Note that the n x n 2D array graph given as input is not directly available to you, and instead only accessible through the helper function knows. graph[i][j] == 1 represents person i knows person j, wherease graph[i][j] == 0 represents person j does not know person i.



     Example 1:


     Input: graph = [[1,1,0],[0,1,0],[1,1,1]]
     Output: 1
     Explanation: There are three persons labeled with 0, 1 and 2. graph[i][j] = 1 means person i knows person j, otherwise graph[i][j] = 0 means person i does not know person j. The celebrity is the person labeled as 1 because both 0 and 2 know him but 1 does not know anybody.
     Example 2:


     Input: graph = [[1,0,1],[1,1,0],[0,1,1]]
     Output: -1
     Explanation: There is no celebrity.


     Constraints:

     n == graph.length == graph[i].length
     2 <= n <= 100
     graph[i][j] is 0 or 1.
     graph[i][i] == 1


     Follow up: If the maximum number of allowed calls to the API knows is 3 * n, could you find a solution without exceeding the maximum number of calls?



     */
    func findCelebrity(_ n: Int) -> Int {
        var top = 0
        var bottom = n - 1
        while top < bottom {
            if knows(top, bottom) {
                top += 1
            } else if knows(bottom, top) {
                bottom -= 1
            } else {
                top += 1
                bottom -= 1
            }
        }
        if top > bottom {
            return -1
        }
        for i in stride(from: 0, through: n - 1, by: 1) {
            if i == top {
                continue
            }
            if !knows(top, i) && knows(i, top) {
                continue
            } else {
                return -1
            }
        }
        return top
    }

    func knows(_ a: Int, _ b: Int) -> Bool {
        // dummy
        return true
    }
}
