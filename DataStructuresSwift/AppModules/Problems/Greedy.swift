//
//  Greedy.swift
//  DataStructuresSwift
//
//  Created by Pranav pravakar on 15/10/25.
//  Copyright © 2025 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation
struct Greedy {
    /*
     455. Assign Cookies
     Solved
     Easy
     Topics
     conpanies icon
     Companies
     Assume you are an awesome parent and want to give your children some cookies. But, you should give each child at most one cookie.

     Each child i has a greed factor g[i], which is the minimum size of a cookie that the child will be content with; and each cookie j has a size s[j]. If s[j] >= g[i], we can assign the cookie j to the child i, and the child i will be content. Your goal is to maximize the number of your content children and output the maximum number.



     Example 1:

     Input: g = [1,2,3], s = [1,1]
     Output: 1
     Explanation: You have 3 children and 2 cookies. The greed factors of 3 children are 1, 2, 3.
     And even though you have 2 cookies, since their size is both 1, you could only make the child whose greed factor is 1 content.
     You need to output 1.
     Example 2:

     Input: g = [1,2], s = [1,2,3]
     Output: 2
     Explanation: You have 2 children and 3 cookies. The greed factors of 2 children are 1, 2.
     You have 3 cookies and their sizes are big enough to gratify all of the children,
     You need to output 2.


     Constraints:

     1 <= g.length <= 3 * 104
     0 <= s.length <= 3 * 104
     1 <= g[i], s[j] <= 231 - 1

     */

    func findContentChildren(_ g: [Int], _ s: [Int]) -> Int {
        let g = g.sorted()
        let s = s.sorted()
        let cookieCount = s.count
        let childCount = g.count
        var cookieCounter = 0, childCounter = 0
        while cookieCounter < cookieCount && childCounter < childCount {
            if g[childCounter] <= s[cookieCounter] {
                childCounter += 1
            }
            cookieCounter += 1
        }
        return childCounter
        
    }

    /*
    860. Lemonade Change
    Solved
    Easy
    Topics
    conpanies icon
    Companies
    At a lemonade stand, each lemonade costs $5. Customers are standing in a queue to buy from you and order one at a time (in the order specified by bills). Each customer will only buy one lemonade and pay with either a $5, $10, or $20 bill. You must provide the correct change to each customer so that the net transaction is that the customer pays $5.

    Note that you do not have any change in hand at first.

    Given an integer array bills where bills[i] is the bill the ith customer pays, return true if you can provide every customer with the correct change, or false otherwise.



    Example 1:

    Input: bills = [5,5,5,10,20]
    Output: true
    Explanation:
    From the first 3 customers, we collect three $5 bills in order.
    From the fourth customer, we collect a $10 bill and give back a $5.
    From the fifth customer, we give a $10 bill and a $5 bill.
    Since all customers got correct change, we output true.
    Example 2:

    Input: bills = [5,5,10,10,20]
    Output: false
    Explanation:
    From the first two customers in order, we collect two $5 bills.
    For the next two customers in order, we collect a $10 bill and give back a $5 bill.
    For the last customer, we can not give the change of $15 back because we only have two $10 bills.
    Since not every customer received the correct change, the answer is false.


    Constraints:

    1 <= bills.length <= 105
    bills[i] is either 5, 10, or 20.
     */
    func lemonadeChange(_ bills: [Int]) -> Bool {
        var five = 0
        var ten = 0
        for bill in bills {
            if bill == 5 {
                five += 1
                continue
            }
            if bill == 10 {
                if five >= 1 {
                    five -= 1
                    ten += 1
                    continue
                }
                return false
                
            }
            if bill == 20 {
                if ten >= 1 && five >= 1 {
                    ten -= 1
                    five -= 1
                    continue
                }
                if five >= 3 {
                    five -= 3
                    continue
                }
                return false
            }
        }
        return true
    }

    // [4, 3, 7, 1, 2]
    func sjf(array: [Int]) -> Int {
        var array = array
        array.sort()
        var time = 0
        var waitTime = 0
        for element in array {
            waitTime += time
            time += element
        }
        return waitTime / array.count
    }

    /*
     55. Jump Game
     Medium
     Topics
     conpanies icon
     Companies
     You are given an integer array nums. You are initially positioned at the array's first index, and each element in the array represents your maximum jump length at that position.

     Return true if you can reach the last index, or false otherwise.



     Example 1:

     Input: nums = [2,3,1,1,4]
     Output: true
     Explanation: Jump 1 step from index 0 to 1, then 3 steps to the last index.
     Example 2:

     Input: nums = [3,2,1,0,4]
     Output: false
     Explanation: You will always arrive at index 3 no matter what. Its maximum jump length is 0, which makes it impossible to reach the last index.


     Constraints:

     1 <= nums.length <= 104
     0 <= nums[i] <= 105
     */

    func canJump(_ nums: [Int]) -> Bool {
        var maxIndex = 0
        for (index, num) in nums.enumerated() {
            if index > maxIndex {
                return false
            }
            maxIndex = max(maxIndex, index + num)
        }
        return true
    }

    /*

     45. Jump Game II

     Companies
     You are given a 0-indexed array of integers nums of length n. You are initially positioned at index 0.

     Each element nums[i] represents the maximum length of a forward jump from index i. In other words, if you are at index i, you can jump to any index (i + j) where:

     0 <= j <= nums[i] and
     i + j < n
     Return the minimum number of jumps to reach index n - 1. The test cases are generated such that you can reach index n - 1.



     Example 1:

     Input: nums = [2,3,1,1,4]
     Output: 2
     Explanation: The minimum number of jumps to reach the last index is 2. Jump 1 step from index 0 to 1, then 3 steps to the last index.
     Example 2:

     Input: nums = [2,3,0,1,4]
     Output: 2


     Constraints:

     1 <= nums.length <= 104
     0 <= nums[i] <= 1000
     It's guaranteed that you can reach nums[n - 1].
     */

    // Tc - O (n ^ n)
    // SC - O(n
    func jumpGameTwoRec(nums: [Int]) -> Int {
        jumpGameTwoRecursion(index: 0, jumps: 0, nums: nums)
    }

    private func jumpGameTwoRecursion(index: Int, jumps: Int, nums: [Int]) -> Int {
        if index >= nums.count - 1 {
            return jumps
        }
        var result = Int.max
        for i in stride(from: 1, through: nums[index], by: 1) {
            result = min(result, jumpGameTwoRecursion(index: index + i, jumps: jumps + 1, nums: nums))
        }
        return result
    }

    // SC - O(n ^ 2)
    // TC - O(n)
    func jumpGameTwoMemo(nums: [Int]) -> Int {
        var count = nums.count
        var dp = [[Int]](repeating: [Int](repeating: -1, count: count), count: count)
        return jumpGameTwoMemoization(index: 0, jumps: 0, nums: nums, dp: &dp)
    }

    private func jumpGameTwoMemoization(index: Int, jumps: Int, nums: [Int], dp: inout [[Int]]) -> Int {
        if index >= nums.count - 1 {
            return jumps
        }
        if dp[index][jumps] != -1 {
            return dp[index][jumps]
        }
        var result = Int.max
        for i in stride(from: 1, through: nums[index], by: 1) {
            result = min(result, jumpGameTwoMemoization(index: index + i, jumps: jumps + 1, nums: nums, dp: &dp))
        }
        dp[index][jumps] = result
        return result
    }

    // TC - O(n)
    // SC - O(1)
    func jumpGameTwoOpti(_ nums: [Int]) -> Int {
        var left = 0
        var right = 0
        var jumps = 0
        var farthest = 0
        while right < nums.count - 1 {
            for i in stride(from: left, through: right, by: 1) {
                farthest = max(farthest, i + nums[i])
            }
            left = right + 1
            right = farthest
            jumps += 1
        }
        return jumps
    }
    /*
     Problem Statement: You are given a set of N jobs where each job comes with a deadline and profit. The profit can only be earned upon completing the job within its deadline. Find the number of jobs done and the maximum profit that can be obtained. Each job takes a single unit of time and only one job can be performed at a time.

     Examples

     Example 1:

     Input: N = 4, Jobs = {(1,4,20),(2,1,10),(3,1,40),(4,1,30)}

     Output: 2 60

     Explanation: The 3rd job with a deadline 1 is performed during the first unit of time .The 1st job is performed during the second unit of time as its deadline is 4.
     Profit = 40 + 20 = 60

     Example 2:

     Input: N = 5, Jobs = {(1,2,100),(2,1,19),(3,2,27),(4,1,25),(5,1,15)}

     Output: 2 127

     Explanation: The  first and third job both having a deadline 2 give the highest profit.
     Profit = 100 + 27 = 127
     */

    /*
     Problem Statement: There is one meeting room in a firm. You are given two arrays, start and end each of size N. For an index ‘i’, start[i] denotes the starting time of the ith meeting while end[i] will denote the ending time of the ith meeting. Find the maximum number of meetings that can be accommodated if only one meeting can happen in the room at a particular time. Print the order in which these meetings will be performed.
     */

    /*
     252. Meeting Rooms

     Given an array of meeting time intervals where intervals[i] = [starti, endi], determine if a person could attend all meetings.



     Example 1:

     Input: intervals = [[0,30],[5,10],[15,20]]
     Output: false
     Example 2:

     Input: intervals = [[7,10],[2,4]]
     Output: true


     Constraints:

     0 <= intervals.length <= 104
     intervals[i].length == 2
     0 <= starti < endi <= 106
     */

    func canAttendMeetings(_ intervals: [[Int]]) -> Bool {
        let sortedIntervals = intervals.sorted { $0[0] < $1[0] }
        for i in stride(from: 0, through: sortedIntervals.count - 2, by: 1) {
            if sortedIntervals[i][1] > sortedIntervals[i + 1][0] {
                return false
            }
        }
        return true
    }

    /*
     253. Meeting Rooms II

     Given an array of meeting time intervals intervals where intervals[i] = [starti, endi], return the minimum number of conference rooms required.



     Example 1:

     Input: intervals = [[0,30],[5,10],[15,20]]
     Output: 2
     Example 2:

     Input: intervals = [[7,10],[2,4]]
     Output: 1


     Constraints:

     1 <= intervals.length <= 104
     0 <= starti < endi <= 106
     */
    func minMeetingRooms(_ intervals: [[Int]]) -> Int {
        var startTimes = [Int]()
        var endTimes = [Int]()
        for interval in intervals {
            startTimes.append(interval[0])
            endTimes.append(interval[1])
        }
        startTimes.sort()
        endTimes.sort()

        var result = 0
        let totalCount = intervals.count
        var startCounter = 0
        var endCounter = 0
        var count = 0

        while startCounter < totalCount {
            if startTimes[startCounter] < endTimes[endCounter] {
                startCounter += 1
                count += 1
            } else {
                endCounter += 1
                count -= 1
            }
            result = max(result, count)
        }
        return result
    }

    /*
     57. Insert Interval

     Hint
     You are given an array of non-overlapping intervals intervals where intervals[i] = [starti, endi] represent the start and the end of the ith interval and intervals is sorted in ascending order by starti. You are also given an interval newInterval = [start, end] that represents the start and end of another interval.

     Insert newInterval into intervals such that intervals is still sorted in ascending order by starti and intervals still does not have any overlapping intervals (merge overlapping intervals if necessary).

     Return intervals after the insertion.

     Note that you don't need to modify intervals in-place. You can make a new array and return it.



     Example 1:

     Input: intervals = [[1,3],[6,9]], newInterval = [2,5]
     Output: [[1,5],[6,9]]
     Example 2:

     Input: intervals = [[1,2],[3,5],[6,7],[8,10],[12,16]], newInterval = [4,8]
     Output: [[1,2],[3,10],[12,16]]
     Explanation: Because the new interval [4,8] overlaps with [3,5],[6,7],[8,10].


     Constraints:

     0 <= intervals.length <= 104
     intervals[i].length == 2
     0 <= starti <= endi <= 105
     intervals is sorted by starti in ascending order.
     newInterval.length == 2
     0 <= start <= end <= 105
     */

    func insert(_ intervals: [[Int]], _ newInterval: [Int]) -> [[Int]] {
        var result = [[Int]]()
        let count = intervals.count
        var i = 0
        while i < count && intervals[i][1] <  newInterval[0] {
            result.append(intervals[i])
            i += 1
        }
        var intervalUpdate = newInterval
        while i < count && intervals[i][0] <= newInterval[1] {
            intervalUpdate[0] = min(intervals[i][0], intervalUpdate[0])
            intervalUpdate[1] = max(intervals[i][1], intervalUpdate[1])
            i += 1
        }
        result.append(intervalUpdate)
        result.append(contentsOf: intervals.suffix(count - i))
        return result
    }

    /*
     We are given two arrays that represent the arrival and departure times of trains that stop at the platform. We need to find the minimum number of platforms needed at the railway station so that no train has to wait.
     */

    // TC - O(n * n)
    // SC - O(n)
    func platformCount(trainTimes: [[Int]]) -> Int {
        var platformCount = 0
        let count = trainTimes.count
        for i in stride(from: 0, through: count - 1, by: 1) {
            var currentCount = 1
            for j in stride(from: i + 1, through: count - 1, by: 1) {
                if trainTimes[j][0] > trainTimes[i][0] {
                    currentCount += 1
                }
            }
            platformCount = max(platformCount, currentCount)
        }
        return platformCount
    }

    func platformCountOptimized(trainTimes: [[Int]]) -> Int {
        let startTimes = trainTimes.map { $0[0] }.sorted { $0 < $1 }
        let endTimes = trainTimes.map { $0[1] }.sorted { $0 < $1 }
        let totalCount = trainTimes.count
        var result = 0
        var count = 0
        var startCounter = 0
        var endCounter = 0
        while startCounter < totalCount {
            if startTimes[startCounter] < endTimes[endCounter] {
                startCounter += 1
                count += 1
            } else {
                endCounter += 1
                count -= 1
            }
            result = max(result, count)
        }
        return result
    }

    /*
     678. Valid Parenthesis String

     Given a string s containing only three types of characters: '(', ')' and '*', return true if s is valid.

     The following rules define a valid string:

     Any left parenthesis '(' must have a corresponding right parenthesis ')'.
     Any right parenthesis ')' must have a corresponding left parenthesis '('.
     Left parenthesis '(' must go before the corresponding right parenthesis ')'.
     '*' could be treated as a single right parenthesis ')' or a single left parenthesis '(' or an empty string "".


     Example 1:

     Input: s = "()"
     Output: true
     Example 2:

     Input: s = "(*)"
     Output: true
     Example 3:

     Input: s = "(*))"
     Output: true

     */

    func checkValidString(_ s: String) -> Bool {
        var min = 0
        var max = 0
        for character in s {
            if character == "(" {
                min += 1
                max += 1
            } else if character == ")" {
                min -= 1
                max -= 1
            } else if character == "*" {
                min -= 1
                max += 1
            }
            if min < 0 {
                min = 0
            }
            if max < 0 {
                return false
            }
        }

        return min == 0
    }

    /*
     135. Candy

     There are n children standing in a line. Each child is assigned a rating value given in the integer array ratings.

     You are giving candies to these children subjected to the following requirements:

     Each child must have at least one candy.
     Children with a higher rating get more candies than their neighbors.
     Return the minimum number of candies you need to have to distribute the candies to the children.



     Example 1:

     Input: ratings = [1,0,2]
     Output: 5
     Explanation: You can allocate to the first, second and third child with 2, 1, 2 candies respectively.
     Example 2:

     Input: ratings = [1,2,2]
     Output: 4
     Explanation: You can allocate to the first, second and third child with 1, 2, 1 candies respectively.
     The third child gets 1 candy because it satisfies the above two conditions.


     Constraints:

     n == ratings.length
     1 <= n <= 2 * 104
     0 <= ratings[i] <= 2 * 104
     */

    // TC - O(2N)
    // SC - O(N)
    func candy(_ ratings: [Int]) -> Int {
        let count = ratings.count
        var left = [Int](repeating: 0, count: count)
        left[0] = 1
        for i in stride(from: 1, through: count - 1, by: 1) {
            if ratings[i] > ratings[i - 1] {
                left[i] = left[i - 1] + 1
            } else {
                left[i] = 1
            }
        }
        var sum = left[count - 1]
        var current = 0
        var right = 1
        for i in stride(from: count - 2, through: 0, by: -1) {
            if ratings[i] > ratings[i + 1] {
                current = right + 1
            } else {
                current = 1
            }
            right = current
            sum += max(current, left[i])
        }
        return sum
    }

    func candySlope(_ ratings: [Int]) -> Int {
        var sum = 1
        let count = ratings.count
        var counter = 1
        while counter < count {
            if ratings[counter] == ratings[counter - 1] {
                sum += 1
                counter += 1
                continue
            }
            var peak = 1
            while counter < count && ratings[counter] > ratings[counter - 1] {
                peak += 1
                sum += peak
                counter += 1
            }
            var down = 1
            while counter < count && ratings[counter] < ratings[counter - 1] {
                sum += down
                down += 1
                counter += 1
            }
            if down > peak {
                sum += down - peak
            }
        }
        return sum
    }

    /*
     Problem Statement: The weight of N items and their corresponding values are given. We have to put these items in a knapsack of weight W such that the total value obtained is maximized.

     Note: We can either take the item as a whole or break it into smaller units.

     Example:

     Input: N = 3, W = 50, values[] = {100,60,120}, weight[] = {20,10,30}.

     Output: 240.00

     Explanation: The first and second items  are taken as a whole  while only 20 units of the third item is taken. Total value = 100 + 60 + 80 = 240.00

     */

    func fractionalKnapsack(valueWeights: [[Int]], max: Int) -> Double {
        let weights = 0
        var result: Double = 0
        var sortedValueWeights = valueWeights.sorted { Double($0[0]) / Double ($0[1]) > Double($1[0]) / Double($1[1]) }
        var counter = 0
        let count = valueWeights.count
        while counter < count {
            if sortedValueWeights[counter][1] + weights <= max {
                result += Double(sortedValueWeights[counter][0])
            } else {
                let remaining = Double(max - weights)
                let weightPerValue = Double(sortedValueWeights[counter][0]) / Double(sortedValueWeights[counter][1])
                result += remaining * weightPerValue
                break
            }
            counter += 1
        }

        return result
    }

    /*
     1710. Maximum Units on a Truck
     Solved
     Easy
     Topics
     conpanies icon
     Companies
     Hint
     You are assigned to put some amount of boxes onto one truck. You are given a 2D array boxTypes, where boxTypes[i] = [numberOfBoxesi, numberOfUnitsPerBoxi]:

     numberOfBoxesi is the number of boxes of type i.
     numberOfUnitsPerBoxi is the number of units in each box of the type i.
     You are also given an integer truckSize, which is the maximum number of boxes that can be put on the truck. You can choose any boxes to put on the truck as long as the number of boxes does not exceed truckSize.

     Return the maximum total number of units that can be put on the truck.



     Example 1:

     Input: boxTypes = [[1,3],[2,2],[3,1]], truckSize = 4
     Output: 8
     Explanation: There are:
     - 1 box of the first type that contains 3 units.
     - 2 boxes of the second type that contain 2 units each.
     - 3 boxes of the third type that contain 1 unit each.
     You can take all the boxes of the first and second types, and one box of the third type.
     The total number of units will be = (1 * 3) + (2 * 2) + (1 * 1) = 8.
     Example 2:

     Input: boxTypes = [[5,10],[2,5],[4,7],[3,9]], truckSize = 10
     Output: 91


     Constraints:

     1 <= boxTypes.length <= 1000
     1 <= numberOfBoxesi, numberOfUnitsPerBoxi <= 1000
     1 <= truckSize <= 106
     */

    // TC - O(n log n + n), SC - O(1)
    func maximumUnits(_ boxTypes: [[Int]], _ truckSize: Int) -> Int {
        let sortedBoxTypes = boxTypes.sorted { $0[1] > $1[1] }

        var counter = 0
        var result = 0
        var boxCount = 0
        while counter < sortedBoxTypes.count && boxCount < truckSize {
            let current = sortedBoxTypes[counter]
            if boxCount + current[0] <= truckSize {
                result += current[0] * current[1]
                boxCount += current[0]
            } else {
                let remaining = truckSize - boxCount
                result += remaining * current[1]
                boxCount += remaining
                break
            }
            counter += 1

        }
        return result
    }
}
