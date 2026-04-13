//
//  DP.swift
//  DataStructuresSwift
//
//  Created by Pranav Pravakar on 10/03/25.
//  Copyright © 2025 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation
// swiftlint:disable file_length
// swiftlint:disable type_body_length
struct DynamicProblem {
    init() {
        print("Fibonacci number 5 with memoization - \(fibonacciMemoization(n: 6))")
        print("Fibonacci number 5 with tabulation - \(fibonacciTabulation(n: 6))")
        print("Fibonacci number 5 with optimization - \(fibonacciOptimization(n: 6))")
        let frogJump = [30, 10, 60, 10, 60, 50]
        print("Frog Jump Recursion with [10, 20, 30, 10] - \(frogJumpRecursion(nums: [10, 20, 30, 10], index: [10, 20, 30, 10].count - 1))")
        print("Frog Jump Recursion with \(frogJump) - \(frogJumpRecursion(nums: frogJump, index: frogJump.count - 1))")
        print("Frog Jump Memoization with \(frogJump) - \(frogJumpMemoization(nums: frogJump, index: frogJump.count - 1))")
        print("Frog Jump Tabulation with \(frogJump) - \(frogJumpTabulation(nums: frogJump))")
        print("Frog Jump Space with \(frogJump) - \(frogJumpSpaceOptimized(nums: frogJump))")
        print("subsequenceSumNotAdjacentRecursion  [2, 1, 4, 9] - \(subsequenceSumNotAdjacentRecursion(nums: [2, 1, 4, 9], index: 3))")
        print("subsequenceSumNotAdjacentRecursion Memoization  [2, 1, 4, 9] - \(subsequenceSumNotAdjacentMemoization(nums: [2, 1, 4, 9], index: 3))")
        print("subsequenceSumNotAdjacent Tabulation  [2, 1, 4, 9] - \(subsequenceSumNotAdjacentTabulation(nums: [2, 1, 4, 9]))")
        print("subsequenceSumNotAdjacent Space optimization   [2, 1, 4, 9] - \(subsequenceSumNotAdjacentSpaceOptimization(nums: [2, 1, 4, 9]))")

        print("Ninja Taks Tabulation- \([[1, 2, 5], [3, 1, 1], [3, 3, 3]]) - ", ninjaMaximumPointsTabulation(nums: [[1, 2, 5], [3, 1, 1], [3, 3, 3]]))
        print("Ninja Taks Memoization- \([[1, 2, 5], [3, 1, 1], [3, 3, 3]]) - ", ninjaMaximumPointsMemoization(nums: [[1, 2, 5], [3, 1, 1], [3, 3, 3]]))

        print("Unique Path recursion 5x5 - \(uniquePathRecursion(row: 5, column: 5))")
        print("Unique Path recursion 2x2 - \(uniquePathRecursion(row: 2, column: 2))")

        print("Unique Path recursion mem0 5x5 - \(uniquePathRecursionMemo(row: 5, column: 5))")
        print("Unique Path recursion tabulation 5x5 - \(uniquePathRecursionTabulation(row: 5, column: 5))")
        print("Unique Path space optimized 5x5 - \(uniquePathRecursionSpaceOptimized(row: 5, column: 5))")
        var x = [
            [1, 2, 5, 7],
            [10, 20, 30, 40],
            [1, 1, 1, 1],
            [4, 5, 6, 7]
        ]
        print("Min path - \(x) - \(minimumPathGridRecursionSpace(grid: x))")

        print("Is sum 3 present in subsequence: [1, 8, 3, 5] - \(isSubsequencesWithGivenSumPresentRecursionMemo(nums: [1, 8, 3, 5], sum: 3))")
        var numbers = [1, 3, 5, 4, 7]
        print("Number of subsequences: \(numbers) - \(findNumberOfLIS(numbers))")

    }

    // Check for most optimum approach for fibonacci
    func fibonacciRecursion(n: Int) -> Int {
        if n <= 1 {
            return n
        }
        return fibonacciRecursion(n: n - 1) + fibonacciRecursion(n: n - 2)
    }

    // TC - O(n)
    // SC - O(n) (Auxillary space) + O(n) array
    func fibonacciMemoizationRecursion(dp: inout [Int], n: Int) -> Int {
        if n <= 1 {
            return n
        }
        if dp[n] == -1 {
            dp[n] = fibonacciMemoizationRecursion(dp: &dp, n: n - 1) + fibonacciMemoizationRecursion(dp: &dp, n: n - 2)
        }
        return dp[n]
    }

    func fibonacciMemoization(n: Int) -> Int {
        var dp = [Int](repeating: -1, count: n)
        return fibonacciMemoizationRecursion(dp: &dp, n: n - 1)
    }

    func fibonacciTabulation(n: Int) -> Int {
        var dp = [Int](repeating: -1, count: n)
        dp[0] = 0
        dp[1] = 1
        for i in 2..<n {
            dp[i] = dp[i - 1] + dp[i - 2]
        }
        return dp[n - 1]
    }

    func fibonacciOptimization(n: Int) -> Int {
        if n <= 1 {
            return n
        }

        var prev1 = 0
        var prev = 1
        for _ in 2..<n {
            let value = prev + prev1
            prev1 = prev
            prev = value
        }
        return prev
    }

    /*
     You have been given a number of stairs. Initially, you are on 0th stair and you need to reach the nth stair. Each time you can either climb 1 or 2 steps.
     You are supposed to return thr number of distinct ways in which you can climb from thr 0th step to nth step
     Ex, input n = 3, output - 3
     */

    func countWaysToClimbSteps(n: Int) -> Int {
        if n <= 2 {
            return n
        }
        var prev1 = 1
        var prev2 = 1
        for _ in 2...n {
            let current = prev2 + prev1
            prev2 = prev1
            prev1 = current
        }
        return prev1
    }

    /*
     There is a frog on the '1st' step of an 'N' stairs long staircase. The frog wants to reach the 'Nth' stair. 'HEIGHT[i]' is the height of the '(i+1)th'
     stair.If Frog jumps from 'ith' to 'jth' stair, the energy lost in the jump is given by absolute value of ( HEIGHT[i-1] - HEIGHT[j-1] ). If the Frog is on
     'ith' staircase, he can jump either to '(i+1)th' stair or to '(i+2)th' stair. Your task is to find the minimum total energy used by the frog to reach from
     '1st' stair to 'Nth' stair.

     For Example
     If the given ‘HEIGHT’ array is [10,20,30,10], the answer 20 as the frog can jump from 1st stair to 2nd stair (|20-10| = 10 energy lost) and then a jump
     from 2nd stair to last stair (|10-20| = 10 energy lost). So, the total energy lost is 20.
     Example 2: Height array [30, 10, 60, 10, 60, 50]
     Answer - 40
     */

    func frogJumpRecursion(nums: [Int], index: Int) -> Int {
        if index == 0 {
            return 0
        }
        let left = frogJumpRecursion(nums: nums, index: index - 1) + abs(nums[index] - nums[index - 1])
        var right: Int?
        if index > 1 {
            right = frogJumpRecursion(nums: nums, index: index - 2) + abs(nums[index] - nums[index - 2])
        }
        return min(left, right ?? left)
    }

    func frogJumpMemoization(nums: [Int], index: Int) -> Int {
        var dp = [Int](repeating: -1, count: nums.count)
        return frogJumpMemoizationRecursion(nums: nums, dp: &dp, index: index)
    }

    func frogJumpMemoizationRecursion(nums: [Int], dp: inout [Int], index: Int) -> Int {
        if index == 0 {
            return 0
        }
        guard dp[index] == -1 else { return dp[index] }

        let left = frogJumpMemoizationRecursion(nums: nums, dp: &dp, index: index - 1) + abs(nums[index] - nums[index - 1])
        var right = Int.max
        if index > 1 {
            right = frogJumpMemoizationRecursion(nums: nums, dp: &dp, index: index - 2) + abs(nums[index] - nums[index - 2])
        }
        dp[index] = min(left, right)
        return dp[index]
    }

    func frogJumpTabulation(nums: [Int]) -> Int {
        var dp = [Int](repeating: -1, count: nums.count)

        dp[0] = 0
        var left: Int
        var right = Int.max
        for i in 1..<nums.count {
            left = dp[i - 1] + abs(nums[i] - nums[i - 1])
            if i > 1 {
                right = dp[i - 2] + abs(nums[i] - nums[i - 2])
            }
            dp[i] = min(left, right)
        }
        return dp[nums.count - 1]
    }

    func frogJumpSpaceOptimized(nums: [Int]) -> Int {
        var prev = 0
        var prev2 = 0
        for i in 1..<nums.count {
            let left = prev + abs(nums[i] - nums[i - 1])
            var right = Int.max
            if i > 1 {
                right = prev2 + abs(nums[i] - nums[i - 2])
            }
            let current = min(left, right)
            prev2 = prev
            prev = current
        }

        return prev
    }

    func frogJumpRecursionK(nums: [Int], index: Int, k: Int) -> Int {
        if index == 0 {
            return 0
        }
        var minJE = Int.max
        for i in 1..<nums.count {
            if i - k > 0 {
                let je = frogJumpRecursionK(nums: nums, index: i - k, k: k) + abs(nums[i] - nums[i - k])
                minJE = min(minJE, je)
            }

        }

        return minJE
    }

    /*
     A frog is crossing a river. The river is divided into some number of units, and at each unit, there may or may not exist a stone. The frog can jump on a
     stone, but it must not jump into the water.

     Given a list of stones positions (in units) in sorted ascending order, determine if the frog can cross the river by landing on the last stone. Initially,
     the frog is on the first stone and assumes the first jump must be 1 unit.

     If the frog's last jump was k units, its next jump must be either k - 1, k, or k + 1 units. The frog can only jump in the forward direction.
     */

    /*
     In a given array of N integers, return the maximum sum of the subsequence with the constraint that no to elements are adjacent in the given list
     Input - [2, 1, 4, 9]
     Output - 11
     Example 2 - [6, 5, 9, 8, 10, 24]
     Output - 39
     */

    func subsequenceSumNotAdjacentRecursion(nums: [Int], index: Int) -> Int {
        if index == 0 {
            return nums[index]
        }
        if index < 0 {
            return 0
        }
        let pick = nums[index] + subsequenceSumNotAdjacentRecursion(nums: nums, index: index - 2)
        let notPick = subsequenceSumNotAdjacentRecursion(nums: nums, index: index - 1)
        return max(pick, notPick)
    }

    func subsequenceSumNotAdjacentMemoization(nums: [Int], index: Int) -> Int {
        var dp = [Int](repeating: -1, count: nums.count)
        return subsequenceSumNotAdjacentMemoizationRecusrion(dp: &dp, nums: nums, index: index)
    }

    func subsequenceSumNotAdjacentMemoizationRecusrion(dp: inout [Int], nums: [Int], index: Int) -> Int {
        if index == 0 {
            return nums[index]
        }
        if index < 0 {
            return 0
        }
        guard dp[index] == -1 else { return dp[index] }
        let pick = nums[index] + subsequenceSumNotAdjacentMemoizationRecusrion(dp: &dp, nums: nums, index: index - 2)
        let notPick = subsequenceSumNotAdjacentMemoizationRecusrion(dp: &dp, nums: nums, index: index - 1)
        dp[index] = max(pick, notPick)
        return dp[index]
    }

    func subsequenceSumNotAdjacentTabulation(nums: [Int]) -> Int {
        var dp = [Int](repeating: -1, count: nums.count)
        dp[0] = 0
        for index in 1..<nums.count {
            let pick = index > 1 ? nums[index] + dp[index - 2] : nums[index]
            let notPick = dp[index - 1]
            dp[index] = max(pick, notPick)
        }

        return dp[nums.count - 1]
    }

    func subsequenceSumNotAdjacentSpaceOptimization(nums: [Int]) -> Int {
        var prev = 0
        var prev2 = 0
        for index in 1..<nums.count {
            let pick = index > 1 ? nums[index] + prev2 : nums[index]
            let notPick = prev
            let current = max(pick, notPick)
            prev2 = prev
            prev = current
        }

        return prev
    }

    /*
     A professional robber is planing to rob the houses. Each house has certain amount of money hidden. All houses are arranged in a circle, which means first
     is a neighbour of last. Adjacent houses have security system connected. It will automatically inform police if both are robbed in same night.
     There is a non negative integeger array representing money in each house. Find maximum amount which can be robbed in each house
     Ex -1: [2, 3, 2]
     Answer - 3
     Ex -2: [1, 2, 3, 1]
     Answer - 4

     OR

     You are a professional robber planning to rob houses along a street. Each house has a certain amount of money stashed. All houses at this place are arranged in a circle. That means the first house is the neighbor of the last one. Meanwhile, adjacent houses have a security system connected, and it will automatically contact the police if two adjacent houses were broken into on the same night.

     Given an integer array nums representing the amount of money of each house, return the maximum amount of money you can rob tonight without alerting the police.



     Example 1:

     Input: nums = [2,3,2]
     Output: 3
     Explanation: You cannot rob house 1 (money = 2) and then rob house 3 (money = 2), because they are adjacent houses.
     Example 2:

     Input: nums = [1,2,3,1]
     Output: 4
     Explanation: Rob house 1 (money = 1) and then rob house 3 (money = 3).
     Total amount you can rob = 1 + 3 = 4.
     Example 3:

     Input: nums = [1,2,3]
     Output: 3


     Constraints:

     1 <= nums.length <= 100
     0 <= nums[i] <= 1000
     */

    func robRecursion(_ nums: [Int]) -> Int {

        var nums1 = nums
        var nums2 = nums
        nums1.removeFirst()
        nums2.removeLast()
        let m1 = maxRobRecursion(nums: nums1, index: nums1.count - 1)
        let m2 = maxRobRecursion(nums: nums2, index: nums2.count - 1)
        return max(m1, m2)
    }

    private func maxRobRecursion(nums: [Int], index: Int) -> Int {
        if index == 0 {
            return nums[0]
        }
        if index < 0 {
            return 0
        }
        let take = nums[index] + maxRobRecursion(nums: nums, index: index - 2)
        let notTake = maxRobRecursion(nums: nums, index: index - 1)
        return max(take, notTake)
    }

    func robMemo(_ nums: [Int]) -> Int {
        if nums.count == 1 {
            return nums[0]
        }
        var nums1 = nums
        var nums2 = nums
        nums1.removeFirst()
        nums2.removeLast()
        var dp = [Int](repeating: -1, count: nums.count)
        let m1 = maxRobMemo(nums: nums1, dp: &dp, index: nums1.count - 1)
        dp = dp.map { _ in -1 }
        let m2 = maxRobMemo(nums: nums2, dp: &dp, index: nums2.count - 1)
        return max(m1, m2)
    }

    private func maxRobMemo(nums: [Int], dp: inout [Int], index: Int) -> Int {
        if index == 0 {
            return nums[0]
        }
        if index < 0 {
            return 0
        }
        if dp[index] != -1 {
            return dp[index]
        }
        let take = nums[index] + maxRobMemo(nums: nums, dp: &dp, index: index - 2)
        let notTake = maxRobMemo(nums: nums, dp: &dp, index: index - 1)
        dp[index] = max(take, notTake)
        return dp[index]
    }

    func robTabu(_ nums: [Int]) -> Int {
        let count = nums.count
        if count == 1 {
            return nums[0]
        }

        var dp = [Int](repeating: -1, count: count)
        dp[1] = nums[1]
        for index in stride(from: 2, through: count - 1, by: 1) {
            let take: Int
            if index >= 3 {
                take = nums[index] + dp[index - 2]
            } else {
                take = nums[index]
            }
            let notTake = dp[index - 1]
            dp[index] = max(take, notTake)
        }
        let maximum = dp[count - 1]
        dp[0] = nums[0]
        for index in stride(from: 1, through: count - 2, by: 1) {
            let take: Int
            if index > 1 {
                take = nums[index] + dp[index - 2]
            } else {
                take = nums[index]
            }
            let notTake = dp[index - 1]
            dp[index] = max(take, notTake)
        }
        return max(maximum, dp[count - 2])
    }

    func robSpace(_ nums: [Int]) -> Int {
        let count = nums.count
        if count == 1 {
            return nums[0]
        }

        var previous1 = nums[1]
        var previous2 = previous1
        for index in stride(from: 2, through: count - 1, by: 1) {
            let take: Int
            if index >= 3 {
                take = nums[index] + previous2
            } else {
                take = nums[index]
            }
            let notTake = previous1
            previous2 = previous1
            previous1 = max(take, notTake)
        }
        let maximum = previous1
        previous1 = nums[0]
        previous2 = previous1
        for index in stride(from: 1, through: count - 2, by: 1) {
            let take: Int
            if index > 1 {
                take = nums[index] + previous2
            } else {
                take = nums[index]
            }
            let notTake = previous1
            previous2 = previous1
            previous1 = max(take, notTake)
        }
        return max(maximum, previous1)
    }

    /*
     Ninja is planning a N Day training schedule. Each day he can perform following activities running, fighting practice or learning new moves. Each activity
     has some points. To improve skill same activity cannot be performed on two consecutive days

     Given a 2D array of size N*3 points with the points corresponding to each day and activity, find maximum number of points that can be earned
     Input - [[1, 2, 5], [3, 1, 1], [3, 3, 3]]
     Answer - 5 + 3 + 3

     Input - [[10, 50, 1], [5, 100, 11]]
     Answer - 110

     */

    func ninjaMaximumPoints(nums: [[Int]]) -> Int {
        ninjaMaximumPointsRecursion(nums: nums, day: nums.count - 1, last: 3)
    }

    func ninjaMaximumPointsRecursion(nums: [[Int]], day: Int, last: Int) -> Int {
        if day == 0 {
            var maximum = 0
            for task in 0...2 {
                guard task != last else { continue }
                maximum = max(maximum, nums[day][task])
            }
            return maximum
        }
        var maximum = 0
        for i in 0..<2 {
            guard i != last else { continue }
            let point = nums[day][i] + ninjaMaximumPointsRecursion(nums: nums, day: day - 1, last: i)
            maximum = max(maximum, point)
        }
        return maximum
    }

    func ninjaMaximumPointsMemoization(nums: [[Int]]) -> Int {
        let dpRow = [Int](repeating: -1, count: 4)
        var dp = [[Int]](repeating: dpRow, count: nums.count)

        return ninjaMaximumPointsMemoizationRecursion(nums: nums, day: nums.count - 1, last: 3, dp: &dp)
    }

    // TC - O(nx4x3)
    // SC - O(n) + O(Nx4)
    func ninjaMaximumPointsMemoizationRecursion(nums: [[Int]], day: Int, last: Int, dp: inout [[Int]]) -> Int {
        if day == 0 {
            var maximum = 0
            for task in 0...2 {
                guard task != last else { continue }
                maximum = max(maximum, nums[day][task])
            }
            return maximum
        }
        guard dp[day][last] == -1 else { return dp[day][last] }
        var maximum = 0
        for task in 0...2 {
            guard task != last else { continue }
            let point = nums[day][task] + ninjaMaximumPointsMemoizationRecursion(nums: nums, day: day - 1, last: task, dp: &dp)
            maximum = max(maximum, point)
        }
        dp[day][last] = maximum
        return dp[day][last]
    }

    func ninjaMaximumPointsTabulation(nums: [[Int]]) -> Int {
        let dpRow = [Int](repeating: 0, count: 4)
        var dp = [[Int]](repeating: dpRow, count: nums.count)
        dp[0][0] = max(nums[0][1], nums[0][2])
        dp[0][1] = max(nums[0][0], nums[0][2])
        dp[0][2] = max(nums[0][0], nums[0][1])
        dp[0][3] = max(nums[0][0], nums[0][1], nums[0][2])

        for day in 1..<nums.count {
            for last in 0...3 {
                dp[day][last] = 0
                for task in 0..<3 {
                    guard  task != last else { continue }
                    let point = nums[day][task] + dp[day - 1][task]
                    dp[day][last] = max(point, dp[day][last])
                }
            }
        }
        return dp[nums.count - 1][3]
    }

    /*

     Given a two-dimensional matrix, in how way can someone traverse it from top-left to bottom-right?
     Condition- At any particular cell the possible moves are either down or right, no other steps possible.
     Stop when the end is reached.

     Input : 2 2
     Output : 1

     Input : 3 3
     Output : 6

     Input : 5 5
     Output : 70
     */

    private func internalUniquePathRecursion(row: Int, column: Int) -> Int {
        if row == 0 && column == 0 {
            return 1
        }
        if row < 0 || column < 0 {
            return 0
        }
        let up = internalUniquePathRecursion(row: row - 1, column: column)
        let left = internalUniquePathRecursion(row: row, column: column - 1)
        return up + left
    }

    // TC - O(2^(m*n))
    // SC - O(n-1 + m -1)
    func uniquePathRecursion(row: Int, column: Int) -> Int {
        internalUniquePathRecursion(row: row - 1, column: column - 1)
    }

    private func internalUniquePathRecursionMemo(row: Int, column: Int, dp: inout [[Int]]) -> Int {
        if row == 0 && column == 0 {
            return 1
        }
        if row < 0 || column < 0 {
            return 0
        }
        if dp[row][column] != -1 {
            return dp[row][column]
        }
        let up = internalUniquePathRecursionMemo(row: row - 1, column: column, dp: &dp)
        let left = internalUniquePathRecursionMemo(row: row, column: column - 1, dp: &dp)
        dp[row][column] = up + left
        return dp[row][column]
    }

    // TC - O((m*n))
    // SC - O(n-1 + m -1) + O(nxm)
    func uniquePathRecursionMemo(row: Int, column: Int) -> Int {
        let dpcolumn = Array(repeating: -1, count: column)
        var dp = Array(repeating: dpcolumn, count: row)
        return internalUniquePathRecursionMemo(row: row - 1, column: column - 1, dp: &dp)
    }

    // TC - O(m*n))
    // SC -  O(nxm)
    func uniquePathRecursionTabulation(row: Int, column: Int) -> Int {
        let dpcolumn = Array(repeating: 0, count: column)
        var dp = Array(repeating: dpcolumn, count: row)
        for i in 0..<row {
            for j in 0..<column {
                if i == 0 && j == 0 {
                    dp[i][j] = 1
                } else {
                    var up: Int = 0
                    var left: Int = 0
                    if i > 0 {
                        up = dp[i - 1][j]
                    }
                    if j > 0 {
                        left = dp[i][j - 1]
                    }
                    dp[i][j] = up + left
                }

            }
        }

        return dp[row - 1][column - 1]

    }

    // TC - O(m*n))
    // SC -  O(nxm)
    func uniquePathRecursionSpaceOptimized(row: Int, column: Int) -> Int {
        var previous = Array(repeating: 0, count: column)
        for i in 0..<row {
            var current = Array(repeating: 0, count: column)
            for j in 0..<column {
                if i == 0 && j == 0 {
                    current[j] = 1
                } else {
                    var up: Int = 0
                    var left: Int = 0
                    if i > 0 {
                        up = previous[j]
                    }
                    if j > 0 {
                        left = current[j - 1]
                    }
                    current[j] = up + left
                }

            }
            previous = current
        }

        return previous[column - 1]

    }

    /*

     There is a  2d grid with n row and m column. Each point in the grid has some cost associated with it. Find a path from top left (0,0) to bottom right (n-1, m-1) which minimizes the sum of the cost of the numbers along the path. You need to tell the minimum span of the path
     Condition- At any particular cell the possible moves are either down or right, no other steps possible.
     Stop when the end is reached.

     Given a m x n grid filled with non-negative numbers, find a path from top left to bottom right, which minimizes the sum of all numbers along its path.

     Note: You can only move either down or right at any point in time.

     nput: grid = [[1,3,1],[1,5,1],[4,2,1]]
     Output: 7
     Explanation: Because the path 1 → 3 → 1 → 1 → 1 minimizes the sum.
     Example 2:

     Input: grid = [[1,2,3],[4,5,6]]
     Output: 12

     Input
     [[3,8,6,0,5,9,9,6,3,4,0,5,7,3,9,3],[0,9,2,5,5,4,9,1,4,6,9,5,6,7,3,2],[8,2,2,3,3,3,1,6,9,1,1,6,6,2,1,9],[1,3,6,9,9,5,0,3,4,9,1,0,9,6,2,7],[8,6,2,2,1,3,0,0,7,2,7,5,4,8,4,8],[4,1,9,5,8,9,9,2,0,2,5,1,8,7,0,9],[6,2,1,7,8,1,8,5,5,7,0,2,5,7,2,1],[8,1,7,6,2,8,1,2,2,6,4,0,5,4,1,3],[9,2,1,7,6,1,4,3,8,6,5,5,3,9,7,3],[0,6,0,2,4,3,7,6,1,3,8,6,9,0,0,8],[4,3,7,2,4,3,6,4,0,3,9,5,3,6,9,3],[2,1,8,8,4,5,6,5,8,7,3,7,7,5,8,3],[0,7,6,6,1,2,0,3,5,0,8,0,8,7,4,3],[0,4,3,4,9,0,1,9,7,7,8,6,4,6,9,5],[6,5,1,9,9,2,2,7,4,2,7,2,2,3,7,2],[7,1,9,6,1,2,7,0,9,6,6,4,4,5,1,0],[3,4,9,2,8,3,1,2,6,9,7,0,2,4,2,0],[5,1,8,8,4,6,8,5,2,4,1,6,2,2,9,7]]

     Output - 83

     Inout - [[1, 2, 5, 7], [10, 20, 30, 40], [1, 1, 1, 1], [4, 5, 6, 7]]
     Output - 22

     */

    func minimumPathGridRecursion(grid: [[Int]]) -> Int {
        return minimumPathGridRecursionInternal(i: grid.count - 1, j: grid[0].count - 1, grid: grid)
    }

    func minimumPathGridRecursionInternal(i: Int, j: Int, grid: [[Int]]) -> Int {
        if i == 0 && j == 0 {
            return grid[0][0]
        }
        if i < 0 || j < 0 {
            return Int(1e9)
        }
        let up = grid[i][j] + minimumPathGridRecursionInternal(i: i - 1, j: j, grid: grid)
        let left = grid[i][j] + minimumPathGridRecursionInternal(i: i, j: j - 1, grid: grid)
        return min(up, left)
    }

    // TC - O(n * m), SC - O(n * m)
    func minimumPathGridRecursionMemo(grid: [[Int]]) -> Int {
        let dpColumn = Array(repeating: 0, count: grid[0].count)
        var dp = Array(repeating: dpColumn, count: grid.count)
        return minimumPathGridRecursionMemoInternal(i: grid.count - 1, j: grid[0].count - 1, grid: grid, dp: &dp)
    }

    func minimumPathGridRecursionMemoInternal(i: Int, j: Int, grid: [[Int]], dp: inout [[Int]]) -> Int {
        if i == 0 && j == 0 {
            return grid[i][j]
        }
        if i < 0 || j < 0 {
            return Int(1e9)
        }
        guard dp[i][j] == -1 else { return dp[i][j] }
        let up = grid[i][j] + minimumPathGridRecursionMemoInternal(i: i - 1, j: j, grid: grid, dp: &dp)
        let left = grid[i][j] + minimumPathGridRecursionMemoInternal(i: i, j: j - 1, grid: grid, dp: &dp)
        dp[i][j] = min(up, left)
        return dp[i][j]
    }

    // TC - O(n * m), SC - O(n * m)
    func minimumPathGridRecursionTabu(grid: [[Int]]) -> Int {
        let column = grid[0].count
        let row = grid.count
        let dpColumn = Array(repeating: 0, count: column)
        var dp = Array(repeating: dpColumn, count: row)
        for i in 0..<row {
            for j in 0..<column {
                if i == 0 && j == 0 {
                    dp[i][j] = grid[i][j]
                    continue
                } else {
                    let up: Int
                    if i > 0 {
                        up = grid[i][j] + dp[i - 1][j]
                    } else {
                        up = grid[i][j] + Int(1e9)
                    }
                    let left: Int
                    if j > 0 {
                        left = grid[i][j] + dp[i][j - 1]
                    } else {
                        left = grid[i][j] + Int(1e9)
                    }
                    dp[i][j] = min(up, left)
                }
            }
        }
        return dp[row - 1][column - 1]
    }

    // TC - O(n * m), SC - O(n)
    func minimumPathGridRecursionSpace(grid: [[Int]]) -> Int {
        let column = grid[0].count
        let row = grid.count
        var previous = Array(repeating: 0, count: column)
        for i in 0..<row {
            var current = Array(repeating: 0, count: column)
            for j in 0..<column {
                if i == 0 && j == 0 {
                    current[j] = grid[0][0]
                } else {
                    let up: Int
                    if i > 0 {
                        up = grid[i][j] + previous[j]
                    } else {
                        up = grid[i][j] + Int(1e9)
                    }
                    let left: Int
                    if j > 0 {
                        left = grid[i][j] + current[j - 1]
                    } else {
                        left = grid[i][j] + Int(1e9)
                    }
                    current[j] = min(up, left)
                }
            }
            previous = current
        }
        return previous[column - 1]
    }

    /*
     you are given a triangular array list triangle. Return minimum path sum to reach top to bottom
     Triangle array will have n rows and ith row will have 0<=i<N i + 1 elements

     You can move only adjacent number of row below each step. For example if you are at index j in row i, then you move to j or j+1 index in row i+1 in each step

     triangle = [[1], [2, 3], [3, 6, 7], [8, 9, 6, 10]]
     */

    //TC - O(2 ^ n)
   // SC - O(n)
    func minimumPathTriangularGridRecursion(grid: [[Int]], i: Int, j: Int) -> Int {
        if i == grid.count - 1 {
            return grid[i][j]
        }
        let bottom = grid[i][j] + minimumPathTriangularGridRecursion(grid: grid, i: i + 1, j: j)
        let diagonal = grid[i][j] + minimumPathTriangularGridRecursion(grid: grid, i: i + 1, j: j + 1)
        return min(bottom, diagonal)
    }

    func minimumPathTriangularGridMemoization(grid: [[Int]]) -> Int {
        let column = Array(repeating: -1, count: grid[grid.count - 1].count)
        var dp = Array(repeating: column, count: grid.count)
        return minimumPathTriangularGridMemoizationRecursion(grid: grid, dp: &dp, i: 0, j: 0)
    }

    //
    func minimumPathTriangularGridMemoizationRecursion(grid: [[Int]], dp: inout [[Int]], i: Int, j: Int) -> Int {
        if i == grid.count - 1 {
            return grid[i][j]
        }
        guard dp[i][j] == -1 else {
            return dp[i][j]
        }
        let bottom = grid[i][j] + minimumPathTriangularGridRecursion(grid: grid, i: i + 1, j: j)
        let diagonal = grid[i][j] + minimumPathTriangularGridRecursion(grid: grid, i: i + 1, j: j + 1)
        dp[i][j] = min(bottom, diagonal)
        return dp[i][j]
    }

    func minimumPathTriangularGridTabulation(grid: [[Int]]) -> Int {
        let maxColumnCount = grid[grid.count - 1].count
        let rowCount = grid.count
        let column = Array(repeating: 0, count: maxColumnCount)
        var dp = Array(repeating: column, count: rowCount)
        for column in 0..<maxColumnCount {
            dp[rowCount - 1][column] = grid[rowCount - 1][column]
        }

        for i in stride(from: rowCount - 2, through: 0, by: -1) {
            for j in stride(from: i, through: 0, by: -1) {
                let down = grid[i][j] + dp[i + 1][j]
                let diagonal = grid[i][j] + dp[i + 1][j + 1]
                dp[i][j] = min(down, diagonal)

            }
        }
        return dp[0][0]
    }

    func minimumPathTriangularGridSpaceOptimizrd(grid: [[Int]]) -> Int {
        let count = grid.count
        var front = Array(repeating: 0, count: count)
        var current = Array(repeating: 0, count: count)
        for j in 0..<count {
            front[j] = grid[count - 1][j]
        }

        for i in stride(from: count - 2, through: 0, by: -1) {
            for j in stride(from: i, through: 0, by: -1) {
                let down = grid[i][j] + front[j]
                let diagonal = grid[i][j] + front[j + 1]
                current[j] = min(down, diagonal)

            }
            front = current
        }
        return front[0]
    }

    /*
     There is a  2d grid with n row and m column. Each point in the grid has some cost associated with it. Find a path from any cell in top row to any cell in bottom
     row which maximizes the sum of the cost of the numbers along the path. You need to tell the minimum span of the path
     Condition- At any particular cell the possible moves are
     1. down
     2. Digonally down left
     3. Digonally down right
     */

    func maxPathUnknowStartingPointRecursion(grid: [[Int]]) -> Int {
        var result = 0
        for i in stride(from: 0, through: grid[0].count - 1, by: 1) {
            result = max(result, maxPathUnknowStartingPointRecursionInternal(grid: grid, row: grid.count - 1, column: i))
        }
        return result
    }

    private func maxPathUnknowStartingPointRecursionInternal(grid: [[Int]], row: Int, column: Int) -> Int {
        if column < 0 || column > grid[0].count - 1 {
            return -Int(1e9)
        }
        if row == 0 {
            return grid[row][column]
        }
        let up = grid[row][column] + maxPathUnknowStartingPointRecursionInternal(grid: grid, row: row - 1, column: column)
        let upDiagonalLeft = grid[row][column] + maxPathUnknowStartingPointRecursionInternal(grid: grid, row: row - 1, column: column - 1)
        let upDiagonalRight = grid[row][column] + maxPathUnknowStartingPointRecursionInternal(grid: grid, row: row - 1, column: column + 1)
        return max(up, upDiagonalLeft, upDiagonalRight)
    }

    func maxPathUnknowStartingPointMemoization(grid: [[Int]]) -> Int {
        var result: Int = 0
        var rowCount = grid.count
        var columnCount = grid[0].count
        var dp = [[Int]](repeating: [Int](repeating: -1, count: columnCount), count: rowCount)
        for i in stride(from: 0, through: columnCount - 1, by: 1) {
            result = max(result, maxPathUnknowStartingPointMemoizationInternal(grid: grid, dp: &dp, row: rowCount - 1, column: i))
        }
        return result
    }

    // TC - O(n x m)
    // SC - O(n x m) + O(n) - recursive stack space
    private func maxPathUnknowStartingPointMemoizationInternal(grid: [[Int]], dp: inout [[Int]], row: Int, column: Int) -> Int {
        if column < 0 || column > grid[0].count - 1 {
            return -Int(1e9)
        }
        if row == 0 {
            return grid[row][column]
        }
        if dp[row][column] != -1 { return dp[row][column] }
        let up = grid[row][column] + maxPathUnknowStartingPointMemoizationInternal(grid: grid, dp: &dp, row: row - 1, column: column)
        let upDiagonalLeft = grid[row][column] + maxPathUnknowStartingPointMemoizationInternal(grid: grid, dp: &dp, row: row - 1, column: column - 1)
        let upDiagonalRight = grid[row][column] + maxPathUnknowStartingPointMemoizationInternal(grid: grid, dp: &dp, row: row - 1, column: column + 1)
        dp[row][column] = max(up, upDiagonalLeft, upDiagonalRight)
        return dp[row][column]
    }

    func maxPathUnknownStartingPointTabulation(grid: [[Int]]) -> Int {
        let rowCount = grid.count
        let columnCount = grid[0].count
        var dp = [[Int]](repeating: [Int](repeating: -1, count: columnCount), count: rowCount)
        for j in stride(from: 0, through: columnCount - 1, by: 1) {
            dp[0][j] = grid[0][j]
        }
        for i in stride(from: 1, through: rowCount - 1, by: 1) {
            for j in stride(from: 0, through: columnCount - 1, by: 1) {

                let up = grid[i][j] + dp[i - 1][j]
                let upDiagonalLeft = grid[i][j] + j - 1 >= 0 ? dp[i - 1][j - 1] : -Int(1e9)
                let upDiagonalRight = grid[i][j] + j + 1 <= columnCount - 1 ? dp[i - 1][j + 1] : -Int(1e9)
                dp[i][j] = min(up, upDiagonalLeft, upDiagonalRight)
            }
        }
        var result: Int = 0
        for j in 0..<columnCount - 1 {
            result = max(result, dp[rowCount - 1][j])
        }
        return result

    }

    func maxPathUnknownStartingPointSpaceOptmized(grid: [[Int]]) -> Int {
        let rowCount = grid.count
        let columnCount = grid[0].count
        var previous = [Int](repeating: -1, count: columnCount)
        for j in stride(from: 0, through: columnCount - 1, by: 1) {
            previous[j] = grid[0][j]
        }
        for i in stride(from: 1, through: rowCount - 1, by: 1) {
            var current = [Int](repeating: -1, count: columnCount)
            for j in stride(from: 0, through: columnCount - 1, by: 1) {

                let up = grid[i][j] + previous[j]
                let upDiagonalLeft = grid[i][j] + j - 1 >= 0 ? previous[j - 1] : -Int(1e9)
                let upDiagonalRight = grid[i][j] + j + 1 <= columnCount - 1 ? previous[j + 1] : -Int(1e9)
                current[j] = min(up, upDiagonalLeft, upDiagonalRight)
            }
            previous = current
        }
        var result: Int = 0
        for j in 0..<columnCount - 1 {
            result = max(result, previous[j])
        }
        return result

    }

    /*
     There is a grid of R and C with each cell containing chocolates. There are two friends Maverick and constantine and they want to collect maximum chocolates.
     Initially maverick is at top left (0, 0) and constantine is at top right (0, c -1).
     Rules of movement
     1. Bottom
     2. Bottom diagonal left
     3. Bottom diagonal right

     Finc maximum number of chocolates that can be collected
     */

    func maxPathGridTwoPathRecursion(grid: [[Int]], i: Int, j1: Int, j2: Int) -> Int {
        if j1 < 0 || j1 >= grid[0].count || j2 < 0 || j2 >= grid[0].count {
            return -Int(1e9)
        }
        if i == grid.count - 1 {
            return j1 == j2 ? grid[i][j1] : grid[i][j1] + grid[i][j2]
        }

        var maximum = -Int(1e8)
        for dj1 in stride(from: -1, through: 1, by: 1) {
            for dj2 in stride(from: -1, through: 1, by: 1) {
                var value = j1 == j2 ? grid[i][j1] : grid[i][j1] + grid[i][j2]
                value += maxPathGridTwoPathRecursion(grid: grid, i: i + 1, j1: j1 + dj1, j2: j2 + dj2)
                maximum = max(maximum, value)
            }
        }
        return maximum
    }

    func maxPathGridTwoPathMemoizationInternal(grid: [[Int]], dp: inout [[[Int]]], i: Int, j1: Int, j2: Int) -> Int {
        if j1 < 0 || j1 >= grid[0].count || j2 < 0 || j2 >= grid[0].count {
            return -Int(1e9)
        }
        if i == grid.count - 1 {
            return j1 == j2 ? grid[i][j1] : grid[i][j1] + grid[i][j2]
        }

        if dp[i][j1][j2] != -1 {
            return dp[i][j1][j2]
        }
        var maximum = -Int(1e8)
        for dj1 in stride(from: -1, through: 1, by: 1) {
            for dj2 in stride(from: -1, through: 1, by: 1) {
                var value = j1 == j2 ? grid[i][j1] : grid[i][j1] + grid[i][j2]
                value += maxPathGridTwoPathMemoizationInternal(grid: grid, dp: &dp, i: i + 1, j1: j1 + dj1, j2: j2 + dj2)
                maximum = max(maximum, value)
            }
        }
        dp[i][j1][j2] = maximum

        return dp[i][j1][j2]
    }

    private func maxPathGridTwoPathMemoization(grid: [[Int]], dp: inout [[[Int]]], i: Int, j1: Int, j2: Int) -> Int {
        var dp = [[[Int]]](repeating: [[Int]](repeating: [Int](repeating: -1, count: grid[0].count), count: grid[0].count), count: grid.count)

        return maxPathGridTwoPathMemoizationInternal(grid: grid, dp: &dp, i: 0, j1: 0, j2: grid[0].count - 1)
    }

    func maxPathGridTwoPathTabulation(grid: [[Int]]) -> Int {
        var dp = [[[Int]]](repeating: [[Int]](repeating: [Int](repeating: -1, count: grid[0].count), count: grid[0].count), count: grid.count)
        let rowCount = grid.count
        let columnCount = grid[0].count
        for j1 in 0..<columnCount {
            for j2 in 0..<columnCount {
                dp[rowCount - 1][j1][j2] = j1 == j2 ? grid[rowCount - 1][j1] : grid[rowCount - 1][j1] + grid[rowCount - 1][j2]
            }
        }

        var maximum = 0
        for i in stride(from: rowCount - 1, through: 0, by: -1) {
            for j1 in stride(from: 0, through: columnCount - 1, by: 1) {
                for j2 in stride(from: 0, through: columnCount - 1, by: 1) {
                    var maximum = -Int(1e8)
                    for dj1 in stride(from: -1, through: 1, by: 1) {
                        for dj2 in stride(from: -1, through: 1, by: 1) {
                            var value = j1 == j2 ? grid[i][j1] : grid[i][j1] + grid[i][j2]
                            if j1 + dj1 >= 0 && j1 + dj1 < columnCount && j2 + dj2 >= 0 && j2 + dj2 < columnCount {
                                value += dp[i + 1][j1 + dj1][j2 + dj2]
                            } else {
                                value += -Int(1e8)
                            }

                            maximum = max(maximum, value)
                        }
                    }
                    dp[i][j1][j2] = maximum

                }

            }
        }

       return dp[0][0][columnCount - 1]
    }

    func maxPathGridTwoPathSpaceOptimiezed(grid: [[Int]]) -> Int {
        var previous =  [[Int]](repeating: [Int](repeating: -1, count: grid[0].count), count: grid[0].count)
        var current = previous
        let rowCount = grid.count
        let columnCount = grid[0].count
        for j1 in 0..<columnCount {
            for j2 in 0..<columnCount {
                previous[j1][j2] = j1 == j2 ? grid[rowCount - 1][j1] : grid[rowCount - 1][j1] + grid[rowCount - 1][j2]
            }
        }

        for i in stride(from: rowCount - 1, through: 0, by: -1) {
            for j1 in stride(from: 0, through: columnCount - 1, by: 1) {
                for j2 in stride(from: 0, through: columnCount - 1, by: 1) {
                    var maximum = -Int(1e8)
                    for dj1 in stride(from: -1, through: 1, by: 1) {
                        for dj2 in stride(from: -1, through: 1, by: 1) {
                            var value = j1 == j2 ? grid[i][j1] : grid[i][j1] + grid[i][j2]
                            if j1 + dj1 >= 0 && j1 + dj1 < columnCount && j2 + dj2 >= 0 && j2 + dj2 < columnCount {
                                value += previous[j1 + dj1][j2 + dj2]
                            } else {
                                value += -Int(1e8)
                            }

                            maximum = max(maximum, value)
                        }
                    }
                    current[j1][j2] = maximum

                }

            }
            previous = current
        }

       return previous[0][columnCount - 1]
    }

    /*
     Given an array of positive integers and sum, find if there exists a subsequence with the given sum
     */

    func isSubsequencesWithGivenSumPresentRecursionInternal(nums: [Int], sum: Int) -> Bool {
        isSubsequencesWithGivenSumPresentRecursionInternal(nums: nums, sum: sum, index: nums.count - 1)
    }
    func isSubsequencesWithGivenSumPresentRecursionInternal(nums: [Int], sum: Int, index: Int) -> Bool {
        if sum == 0 {
            return true
        }
        if index == 0 {
            return nums[index] == sum
        }
        let notTake = isSubsequencesWithGivenSumPresentRecursionInternal(nums: nums, sum: sum, index: index - 1)
        let take: Bool
        if nums[index] <= sum {
            take = isSubsequencesWithGivenSumPresentRecursionInternal(nums: nums, sum: sum - nums[index], index: index - 1)
        } else {
            take = false
        }
        return take || notTake
    }

    func isSubsequencesWithGivenSumPresentRecursionMemo(nums: [Int], sum: Int) -> Bool {
        var dp = [[Int]](repeating: [Int](repeating: -1, count: sum + 1), count: nums.count)

        return isSubsequencesWithGivenSumPresentRecursionMemoInternal(nums: nums, dp: &dp, sum: sum, index: nums.count - 1)
    }

    func isSubsequencesWithGivenSumPresentRecursionMemoInternal(nums: [Int], dp: inout [[Int]], sum: Int, index: Int) -> Bool {
        if sum == 0 {
            return true
        }
        if index == 0 {
            return nums[index] == sum
        }
        if dp[index][sum] != -1 {
            return dp[index][sum] == 1
        }
        let notTake = isSubsequencesWithGivenSumPresentRecursionMemoInternal(nums: nums, dp: &dp, sum: sum, index: index - 1)
        let take: Bool
        if nums[index] <= sum {
            take = isSubsequencesWithGivenSumPresentRecursionMemoInternal(nums: nums, dp: &dp, sum: sum - nums[index], index: index - 1)
        } else {
            take = false
        }
        dp[index][sum] = take || notTake ? 1 : 0
        return  dp[index][sum] == 1
    }

    // TC - O(n^sum)
    func isSubsequencesWithGivenSumPresentTabulation(nums: [Int], sum: Int) -> Bool {
        var dp = [[Bool]](repeating: [Bool](repeating: false, count: sum + 1), count: nums.count)
        for i in stride(from: 0, through: nums.count - 1, by: 1) {
            dp[i][0] = true
        }
        dp[0][nums[0]] = true
        for index in stride(from: 1, through: nums.count - 1, by: 1) {
            for target in stride(from: 1, through: sum, by: 1) {
                let notTake = dp[index - 1][target]
                let take: Bool
                if nums[index] <= sum {
                    take = dp[index - 1][sum - target]
                } else {
                    take = false
                }
                dp[index][sum] = take || notTake
            }
        }

        return dp[nums.count - 1][sum]
    }

    // TC - O(n^sum)
    // SC - O(sum)
    func isSubsequencesWithGivenSumPresentSpaceOptimized(nums: [Int], sum: Int) -> Bool {
        var previous = [Bool](repeating: false, count: sum + 1)
        var current = previous
        previous[0] = true
        current[0] = true
        for index in stride(from: 1, through: nums.count - 1, by: 1) {
            for target in stride(from: 1, through: sum, by: 1) {
                let notTake = previous[target]
                let take: Bool
                if nums[index] <= sum {
                    take = previous[sum - target]
                } else {
                    take = false
                }
                current[sum] = take || notTake
            }
            previous = current
        }

        return previous[sum]
    }

    /*
     Given an integer array nums, return true if you can partition the array into two subsets such that the sum of the elements in both subsets is equal or false otherwise.



     Example 1:

     Input: nums = [1,5,11,5]
     Output: true
     Explanation: The array can be partitioned as [1, 5, 5] and [11].
     Example 2:

     Input: nums = [1,2,3,5]
     Output: false
     Explanation: The array cannot be partitioned into equal sum subsets.


     Constraints:

     1 <= nums.length <= 200
     1 <= nums[i] <= 100
     */

    // Time limit exceed
    func canPartition(_ nums: [Int]) -> Bool {
        let sum = nums.reduce(0, +)
        if sum & 1 == 1 {
            return false
        }
        return isSumPresent(nums: nums, sum: sum / 2, index: nums.count - 1)

    }

    private func isSumPresent(nums: [Int], sum: Int, index: Int) -> Bool {
        if sum == 0 {
            return true
        }
        if index == 0 {
            return sum == nums[0]
        }

        let notTake = isSumPresent(nums: nums, sum: sum, index: index - 1)
        let take: Bool
        let diff = sum - nums[index]
        if diff >= 0 {
            take = isSumPresent(nums: nums, sum: diff, index: index - 1)
        } else {
            take = false
        }
        return take || notTake
    }

    func canPartitionMemo(_ nums: [Int]) -> Bool {
        let sum = nums.reduce(0, +)
        if sum & 1 == 1 {
            return false
        }

        var dp = [[Int]](repeating: [Int](repeating: -1, count: sum / 2 + 1), count: nums.count)
        return isSumPresentMemo(nums: nums, dp: &dp, sum: sum / 2, index: nums.count - 1)

    }

    private func isSumPresentMemo(nums: [Int], dp: inout [[Int]], sum: Int, index: Int) -> Bool {
        if sum == 0 {
            return true
        }
        if index == 0 {
            return sum == nums[0]
        }
        if dp[index][sum] != -1 {
            return dp[index][sum] == 1
        }
        let notTake = isSumPresentMemo(nums: nums, dp: &dp, sum: sum, index: index - 1)
        let take: Bool
        let diff = sum - nums[index]
        if diff >= 0 {
            take = isSumPresentMemo(nums: nums, dp: &dp, sum: diff, index: index - 1)
        } else {
            take = false
        }
        dp[index][sum] = take || notTake ? 1 : 0
        return dp[index][sum] == 1
    }

    func canPartitionTabulation(_ nums: [Int]) -> Bool {
        let sum = nums.reduce(0, +)
        if sum & 1 == 1 {
            return false
        }
        let count = nums.count
        var dp = [[Bool]](repeating: [Bool](repeating: false, count: sum / 2 + 1), count: count)
        for i in stride(from: 0, through: count - 1, by: 1) {
            dp[i][0] = true
        }
        if nums[0] <= sum / 2 {
            dp[0][nums[0]] = true
        }

        for index in stride(from: 1, through: count - 1, by: 1) {
            let current = nums[index]
            for target in stride(from: 1, through: sum / 2, by: 1) {
                let notTake = dp[index - 1][target]
                let take: Bool
                let diff = target - current
                if diff >= 0 {
                    take = dp[index - 1][diff]
                } else {
                    take = false
                }
                dp[index][target] = take || notTake
            }
        }

        return dp[count - 1][sum / 2]
    }

    func canPartitionOptimization1(_ nums: [Int]) -> Bool {
        let sum = nums.reduce(0, +)
        if sum & 1 == 1 {
            return false
        }
        let count = nums.count
        var previous = [Bool](repeating: false, count: sum / 2 + 1)

        previous[0] = true
        if nums[0] <= sum / 2 {
            previous[nums[0]] = true
        }

        for index in stride(from: 1, through: count - 1, by: 1) {
            let currentValue = nums[index]
            var current = previous
            for target in stride(from: 1, through: sum / 2, by: 1) where target - currentValue > 0 {
                let notTake = previous[target]
                let take = previous[target - currentValue]

                current[target] = take || notTake
            }
            previous = current
        }

        return previous[sum / 2]
    }

    func canPartitionOptimization2(_ nums: [Int]) -> Bool {
        let sum = nums.reduce(0, +)
        if sum & 1 == 1 {
            return false
        }
        let count = nums.count
        var previous = [Bool](repeating: false, count: sum / 2 + 1)

        previous[0] = true
        if nums[0] <= sum / 2 {
            previous[nums[0]] = true
        }

        for index in stride(from: 1, through: count - 1, by: 1) {
            let currentValue = nums[index]
            for target in stride(from: sum / 2, through: 1, by: -1) where target - currentValue > 0 {
                let notTake = previous[target]
                let take = previous[target - currentValue]

                previous[target] = take || notTake
            }
        }

        return previous[sum / 2]
    }

    /*

     Given an integer array nums, partition nums into subsets to minimize the absolute difference of the sums of the subsets.

     1. Each element should belong to one subset
     2. Subsets do not need to be contiguous



     Example 1:

     Input: nums = [1,2,3,4]
     Output: 0
     Explanation: One optimal partition is: [1, 4] and [2, 3].
     The absolute difference between the sums of the arrays is abs((1 + 4) - (2 + 3)) = 0.

     */

    func subsetSumDifferenceMinDp(nums: [Int]) {
        let sum = nums.reduce(0, +)
        let count = nums.count

        var dp = [[Bool]](repeating: [Bool](repeating: false, count: sum + 1), count: count)
        for i in stride(from: 0, through: count - 1, by: 1) {
            dp[i][0] = true
        }
        if nums[0] <= sum {
            dp[0][nums[0]] = true
        }

        for index in stride(from: 1, through: count - 1, by: 1) {
            let current = nums[index]
            for sum in stride(from: 1, through: sum, by: 1) {
                let notTake = dp[index - 1][sum]
                let take: Bool
                let diff = sum - current
                take = diff >= 0 ? dp[index - 1][diff] : false
                dp[index][sum] = take || notTake
            }
        }

        var minimum = Int.max
        for i in stride(from: 0, through: sum / 2, by: 1) {
            if dp[count - 1][i] {
                minimum = min(minimum, abs(i - (sum - i)))
            }

        }

    }

    func subsetSumDifferenceMinSpace(nums: [Int]) {
        let sum = nums.reduce(0, +)
        let count = nums.count

        var previous = [Bool](repeating: false, count: sum + 1)
        previous[0] = true

        for index in stride(from: 1, through: count - 1, by: 1) {
            let current = nums[index]
            for sum in stride(from: sum, through: 1, by: 1) where sum - current >= 0 {
                let notTake = previous[sum]
                let take = previous[sum - current]

                previous[sum] = take || notTake
            }
        }

        var minimum = Int.max
        for i in stride(from: 0, through: sum / 2, by: 1) {
            if previous[i] {
                minimum = min(minimum, abs(i - (sum - i)))
            }

        }

    }
    /*
     Count the number of subsets with sum = k
     */

    func subsetSumTargetRecursion(nums: [Int], index: Int, target: Int) -> Int {
        if target == 0 {
            return 1
        }
        if index == 0 {
            return target == nums[0] ? 1 : 0
        }
        let notTake = subsetSumTargetRecursion(nums: nums, index: index - 1, target: target)
        let take: Int
        if nums[index] <= target {
            take = subsetSumTargetRecursion(nums: nums, index: index - 1, target: target - nums[index])
        } else {
            take = 0
        }

        return take + notTake
    }

    func subsetSumTargetRecursionMemo(nums: [Int], index: Int, target: Int) -> Int {
        var dp = [[Int]](repeating: [Int](repeating: -1, count: target + 1), count: nums.count)
        return subsetSumTargetRecursionMemoInternal(nums: nums, dp: &dp, index: nums.count - 1, target: target)
    }

    func subsetSumTargetRecursionMemoInternal(nums: [Int], dp: inout [[Int]], index: Int, target: Int) -> Int {
        if target == 0 {
            return 1
        }
        if index == 0 {
            return target == nums[0] ? 1 : 0
        }
        if dp[index][target] != -1 {
            return dp[index][target]
        }
        let notTake = subsetSumTargetRecursionMemoInternal(nums: nums, dp: &dp, index: index - 1, target: target)
        let take: Int
        let diff = nums[index] - target
        if diff >= 0 {
            take = subsetSumTargetRecursionMemoInternal(nums: nums, dp: &dp, index: index - 1, target: diff)
        } else {
            take = 0
        }

        dp[index][target] = take + notTake
        return dp[index][target]
    }

    func subsetSumTargetRecursionMemoInternalZero(nums: [Int], dp: inout [[Int]], index: Int, target: Int) -> Int {
        if index == 0 {
            if target == 0 && nums[0] == 0 { return 2 }
            if target == 0 || nums[0] == target { return 1 }
            return 0
        }
        if dp[index][target] != -1 {
            return dp[index][target]
        }
        let notTake = subsetSumTargetRecursionMemoInternal(nums: nums, dp: &dp, index: index - 1, target: target)
        let take: Int
        let diff = nums[index] - target
        if diff >= 0 {
            take = subsetSumTargetRecursionMemoInternal(nums: nums, dp: &dp, index: index - 1, target: diff)
        } else {
            take = 0
        }

        dp[index][target] = take + notTake
        return dp[index][target]
    }

    func subsetSumTargetRecursionMemoTabulation(nums: [Int], target: Int) -> Int {
        let count = nums.count
        var dp = [[Int]](repeating: [Int](repeating: 0, count: target + 1), count: nums.count)
        for i in stride(from: 0, through: count - 1, by: 1) {
            dp[i][0] = 1
        }
        if nums[0] <= target {
            dp[0][nums[target]] = 1
        }
        for index in stride(from: 0, through: count - 1, by: 1) {
            let current = nums[index]
            for sum in stride(from: 1, through: target, by: 1) where current - sum >= 0 {
                let notTake = dp[index - 1][target]
                let take = dp[index - 1][current - sum]
                dp[index][target] = take + notTake
            }
        }

        return dp[count - 1][target]
    }

    func subsetSumTargetRecursionMemoSpace(nums: [Int], target: Int) -> Int {
        let count = nums.count
        var previous = [Int](repeating: 0, count: target)
        for i in stride(from: 0, through: count - 1, by: 1) {
            previous[0] = 1
        }
//        if nums[0] <= target {
//            dp[0][nums[target]] = 1
//        }
        for index in stride(from: 0, through: count - 1, by: 1) {
            let currentValue = nums[index]
            var current = previous
            for sum in stride(from: 1, through: target, by: 1) where currentValue - sum >= 0 {
                let notTake = previous[target]
                let take = previous[currentValue - sum]
                current[target] = take + notTake
            }
            previous = current
        }

        return previous[target]
    }

    /*
     Find number of subsets in array with difference between subsets being k

     // S1 - S2 = k
     // TotalSum = S1 + S2
     // S1 = (Total Sum - k) / 2
     */

    func subsetSumDiffernceRecursionMemo(nums: [Int], index: Int, difference: Int) -> Int {
//
        let sum = nums.reduce(0, +)
        let target = (sum - difference) / 2
        guard target > 0 && target & 1 != 1 else { return 0 }
        var dp = [[Int]](repeating: [Int](repeating: -1, count: target + 1), count: nums.count)
        return subsetDifferenceTargetRecursionMemoInternalZero(nums: nums, dp: &dp, index: nums.count - 1, target: target)
    }

    func subsetDifferenceTargetRecursionMemoInternalZero(nums: [Int], dp: inout [[Int]], index: Int, target: Int) -> Int {
        if index == 0 {
            if target == 0 && nums[0] == 0 { return 2 }
            if target == 0 || nums[0] == target { return 1 }
            return 0
        }
        if dp[index][target] != -1 {
            return dp[index][target]
        }
        let notTake = subsetDifferenceTargetRecursionMemoInternalZero(nums: nums, dp: &dp, index: index - 1, target: target)
        let take: Int
        let diff = nums[index] - target
        if diff >= 0 {
            take = subsetDifferenceTargetRecursionMemoInternalZero(nums: nums, dp: &dp, index: index - 1, target: diff)
        } else {
            take = 0
        }

        dp[index][target] = (take + notTake) % Int(1e9 + 7)
        return dp[index][target]
    }

    func subsetDifferenceTargetRecursionMemoTabulation(nums: [Int], target: Int) -> Int {
        let count = nums.count
        var dp = [[Int]](repeating: [Int](repeating: 0, count: target + 1), count: nums.count)
        if nums[0] == 0 {
            dp[0][0] = 2
        } else {
            dp[0][0] = 1
        }
        if nums[0] != 0 && nums[0] <= target {
            dp[0][nums[target]] = 1
        }
        for index in stride(from: 0, through: count - 1, by: 1) {
            let current = nums[index]
            for sum in stride(from: 1, through: target, by: 1) where current - sum >= 0 {
                let notTake = dp[index - 1][target]
                let take = dp[index - 1][current - sum]
                dp[index][target] = (take + notTake) % Int(1e9 + 7)
            }
        }

        return dp[count - 1][target]
    }

    func subsetDifferenceTargetSpace(nums: [Int], target: Int) -> Int {
        let count = nums.count
        var previous = [Int](repeating: 0, count: target)
        if nums[0] == 0 {
            previous[0] = 2
        } else {
            previous[0] = 1
        }
        if nums[0] != 0 && nums[0] <= target {
            previous[nums[target]] = 1
        }
        for index in stride(from: 0, through: count - 1, by: 1) {
            let currentValue = nums[index]
            var current = previous
            for sum in stride(from: 1, through: target, by: 1) where currentValue - sum >= 0 {
                let notTake = previous[target]
                let take = previous[currentValue - sum]
                current[target] = (take + notTake) % Int(1e9 + 7)
            }
            previous = current
        }

        return previous[target]
    }

    /*
     Knapsack
     
     */
    func knapsackRecursion(values: [Int], weights: [Int], index: Int, weight: Int) -> Int {
        if index == 0 {
            return weights[0] <= weight ? values[0] : 0
        }
        let notTake = knapsackRecursion(values: values, weights: weights, index: index - 1, weight: weight)
        let take: Int
        let diff = weights[index] - weight
        if diff >= 0 {
            take = values[index] + knapsackRecursion(values: values, weights: weights, index: index - 1, weight: diff)
        } else {
            take = Int.min
        }

        return max(take, notTake)
    }

    func knapsackRecursionMemo(values: [Int], weights: [Int], dp: inout [[Int]], index: Int, weight: Int) -> Int {
        if index == 0 {
            return weights[0] <= weight ? values[0] : 0
        }
        if dp[index][weight] != -1 {
            return dp[index][weight]
        }
        let notTake = dp[index - 1][weight]
        let take: Int
        let diff = weight - weights[index]
        if diff >= 0 {
            take = values[index] + dp[index - 1][diff]
        } else {
            take = Int.min
        }

        dp[index][weight] = max(take, notTake)
        return dp[index][weight]
    }

    func knapsackTabu(values: [Int], weights: [Int], maxWeight: Int) -> Int {
        let count = values.count
        var dp = [[Int]](repeating: [Int](repeating: 0, count: maxWeight + 1), count: count)
        for weight in weights where weight < maxWeight {
            dp[0][weight] = values[0]
        }

        for index in stride(from: 1, through: count - 1, by: 1) {
            let currentWeight = weights[index]
            for weight in stride(from: 1, through: count - 1, by: 1) {
                let notTake = dp[index - 1][weight]
                let take: Int
                let diff = weight - weights[index]
                if diff >= 0 {
                    take = values[index] + dp[index - 1][diff]
                } else {
                    take = Int.min
                }

                dp[index][weight] = max(take, notTake)
            }
        }

        return dp[count - 1][maxWeight]
    }

    func knapsackSpaceOpti1(values: [Int], weights: [Int], maxWeight: Int) -> Int {
        let count = values.count
        var previous = [Int](repeating: 0, count: maxWeight + 1)
        for weight in weights where weight < maxWeight {
            previous[weight] = values[0]
        }

        for index in stride(from: 1, through: count - 1, by: 1) {
            let currentWeight = weights[index]
            var current = previous
            for weight in stride(from: 1, through: count - 1, by: 1) {
                let notTake = previous[weight]
                let take: Int
                let diff = weight - weights[index]
                if diff >= 0 {
                    take = values[index] + previous[diff]
                } else {
                    take = Int.min
                }

                current[weight] = max(take, notTake)
            }
            previous = current
        }

        return previous[maxWeight]
    }

    func knapsackSpaceOpti2(values: [Int], weights: [Int], maxWeight: Int) -> Int {
        let count = values.count
        var previous = [Int](repeating: 0, count: maxWeight + 1)
        for weight in weights where weight < maxWeight {
            previous[weight] = values[0]
        }

        for index in stride(from: 1, through: count - 1, by: 1) {
            let currentWeight = weights[index]
            for weight in stride(from: count - 1, through: 1, by: -1) {
                let notTake = previous[weight]
                let take: Int
                let diff = weight - currentWeight
                if diff >= 0 {
                    take = values[index] + previous[diff]
                } else {
                    take = Int.min
                }

                previous[weight] = max(take, notTake)
            }
        }

        return previous[maxWeight]
    }

    /*
     Unbounded knapsack
     */

    // SC - O(W)
    func unboundedKnapSack(weights: [Int], values: [Int], weight: Int) -> Int {
        unboundedKnapsackRecursion(weights: weights, values: values, index: values.count - 1, weight: weight)
    }

    private func unboundedKnapsackRecursion(weights: [Int], values: [Int], index: Int, weight: Int) -> Int {
        if index == 0 {
            return weights[0] <= weight ? weight * values[0] / weights[0] : 0
        }

        let notTake = unboundedKnapsackRecursion(weights: weights, values: values, index: index - 1, weight: weight)
        let take: Int
        if weights[index] <= weight {
            take = values[index] + unboundedKnapsackRecursion(weights: weights, values: values, index: index, weight: weight - weights[index])
        } else {
            take = Int(1e9)
        }

        return max(take, notTake)

    }

    private func unboundedKnapsackMemoRecursion(weights: [Int], values: [Int], dp: inout [[Int]], index: Int, weight: Int) -> Int {
        if index == 0 {
            return weights[0] <= weight ? weight * values[0] / weights[0] : 0
        }
        if dp[index][weight] != -1 {
            return dp[index][weight]
        }

        let notTake = unboundedKnapsackMemoRecursion(weights: weights, values: values, dp: &dp, index: index - 1, weight: weight)
        let take: Int
        if weights[index] <= weight {
            take = values[index] + unboundedKnapsackMemoRecursion(weights: weights, values: values, dp: &dp, index: index, weight: weight - weights[index])
        } else {
            take = -Int(1e9)
        }
        dp[index][weight] = max(take, notTake)

        return dp[index][weight]
    }

    func unboundedKnapSackTabu(weights: [Int], values: [Int], dp: inout [[Int]], index: Int, weight: Int) -> Int {
        var count = values.count
        var dp = [[Int]](repeating: [Int](repeating: 0, count: weight + 1), count: count)
        for i in stride(from: 1, through: weight, by: 1) {
            dp[0][i] = Int(weight / weights[0]) * values[0]
        }

        for index in stride(from: 1, through: count - 1, by: 1) {
            for weight in stride(from: 0, through: weight, by: 1) where weight - weights[index] >= 0 {
                let notTake = dp[index - 1][weight]
                let take = values[index] + dp[index][weight - weights[index]]

                dp[index][weight] = max(take, notTake)
            }
        }

        return dp[count - 1][weight]
    }

    func unboundedKnapSackSpace1(weights: [Int], values: [Int], dp: inout [[Int]], index: Int, weight: Int) -> Int {
        var count = values.count
        var previous = [Int](repeating: 0, count: weight + 1)
        for i in stride(from: 1, through: weight, by: 1) {
            previous[i] = Int(weight / weights[0]) * values[0]
        }

        for index in stride(from: 1, through: count - 1, by: 1) {
            var current = previous
            for w in stride(from: 0, through: weight, by: 1) where w - weights[index] >= 0 {
                let notTake = previous[w]
                let take = values[index] + current[w - weights[index]]

                current[w] = max(take, notTake)
            }
            previous = current
        }

        return previous[weight]
    }

    func unboundedKnapSackSpace2(weights: [Int], values: [Int], dp: inout [[Int]], index: Int, weight: Int) -> Int {
        var count = values.count
        var previous = [Int](repeating: 0, count: weight + 1)
        for i in stride(from: 1, through: weight, by: 1) {
            previous[i] = Int(weight / weights[0]) * values[0]
        }

        for index in stride(from: 1, through: count - 1, by: 1) {
            for w in stride(from: 0, through: weight, by: -1) where w - weights[index] >= 0 {
                let notTake = previous[w]
                let take = values[index] + previous[w - weights[index]]

                previous[w] = max(take, notTake)
            }
        }

        return previous[weight]
    }

    /*
     You are given an integer array coins representing coins of different denominations and an integer amount representing a total amount of money.

     Return the fewest number of coins that you need to make up that amount. If that amount of money cannot be made up by any combination of the coins, return -1.

     You may assume that you have an infinite number of each kind of coin.



     Example 1:

     Input: coins = [1,2,5], amount = 11
     Output: 3
     Explanation: 11 = 5 + 5 + 1
     Example 2:

     Input: coins = [2], amount = 3
     Output: -1
     Example 3:

     Input: coins = [1], amount = 0
     Output: 0

     */
    func coinChangeMemo(_ coins: [Int], _ amount: Int) -> Int {
        let count = coins.count
        if count == 1 && coins[0] != 0 && amount == 0 {
            return 0
        }
        if count == 1 {
            if amount % coins[0] != 0 {
                return -1
            }
            return  amount / coins[0]

        }
        var dp = [[Int]](repeating: [Int](repeating: -1, count: amount + 1), count: count)
        let value = coinChangeRecursionMemo(coins: coins, dp: &dp, index: count - 1, target: amount)
        return value >= Int(1e9) ? -1 : value
    }

    // TC - O(N x Target)
    // SC - O(N x Target) + O(N)
    private func coinChangeRecursionMemo(coins: [Int], dp: inout [[Int]], index: Int, target: Int) -> Int {
        if index == 0 {
            if target % coins[0] == 0 {
                return target / coins[0]
            }
            return Int(1e9)
        }
        if dp[index][target] != -1 {
            return dp[index][target]
        }
        let notTake = coinChangeRecursionMemo(coins: coins, dp: &dp, index: index - 1, target: target)
        let take: Int
        let diff = target - coins[index]
        if diff >= 0 {
            take = 1 + coinChangeRecursionMemo(coins: coins, dp: &dp, index: index, target: diff)
        } else {
            take = Int(1e9)
        }
        dp[index][target] = min(take, notTake)
        return dp[index][target]

    }

    func coinChangeTabu(_ coins: [Int], _ amount: Int) -> Int {
        let count = coins.count
        if count == 1 && coins[0] != 0 && amount == 0 {
            return 0
        }
        if count == 1 {
            if amount % coins[0] != 0 {
                return -1
            }
            return  amount / coins[0]

        }
        var dp = [[Int]](repeating: [Int](repeating: 0, count: amount + 1), count: count)
        for index in stride(from: 0, through: amount, by: 1) {
            if index % coins[0] == 0 {
                dp[0][index] = index / coins[0]
            } else {
                dp[0][index] = Int(1e9)
            }
        }

        for index in stride(from: 1, through: count - 1, by: 1) {
            let currentValue = coins[index]
            for target in stride(from: 0, through: amount, by: 1) {
                let notTake = dp[index - 1][target]
                let take: Int
                let diff = target - currentValue
                if diff >= 0 {
                    take = 1 + dp[index][diff]
                } else {
                    take = Int(1e9)
                }
                dp[index][target] = min(take, notTake)
            }
        }
        return dp[count - 1][amount] >= Int(1e9) ? -1 : dp[count - 1][amount]
    }

    func coinChangeSpace1(_ coins: [Int], _ amount: Int) -> Int {
        let count = coins.count
        if count == 1 && coins[0] != 0 && amount == 0 {
            return 0
        }
        if count == 1 {
            if amount % coins[0] != 0 {
                return -1
            }
            return  amount / coins[0]

        }
        var previous = [Int](repeating: 0, count: amount + 1)
        for index in stride(from: 0, through: amount, by: 1) {
            if index % coins[0] == 0 {
                previous[index] = index / coins[0]
            } else {
                previous[index] = Int(1e9)
            }

        }

        for index in stride(from: 1, through: count - 1, by: 1) {
            var current = previous
            let currentValue = coins[index]
            for target in stride(from: 0, through: amount, by: 1) {
                let notTake = previous[target]
                let take: Int
                let diff = target - currentValue
                if diff >= 0 {
                    take = 1 + current[diff]
                } else {
                    take = Int(1e9)
                }
                current[target] = min(take, notTake)
            }
            previous = current
        }
        return previous[amount] >= Int(1e9) ? -1 : previous[amount]
    }

    func coinChangeSpace2(_ coins: [Int], _ amount: Int) -> Int {
        let count = coins.count
        if count == 1 && coins[0] != 0 && amount == 0 {
            return 0
        }
        if count == 1 {
            if amount % coins[0] != 0 {
                return -1
            }
            return  amount / coins[0]
            
        }
        var previous = [Int](repeating: Int(1e9), count: amount + 1)
        previous[0] = 0
        
        for target in stride(from: 1, through: amount, by: 1) {
            for index in stride(from: 0, through: count - 1, by: 1) where target - coins[index] >= 0 {
                let notTake = previous[target]
                let take = 1 + previous[target - coins[index]]
                previous[target] = min(take, notTake)
            }
            
        }
        return previous[amount] >= Int(1e9) ? -1 : previous[amount]
    }

    /*
     Rod cutting problem
     */
    private func rodCutRecursion(nums: [Int], index: Int, n: Int) -> Int {
        if index == 0 {
            return n * nums[0]
        }
        let notTake = rodCutRecursion(nums: nums, index: index - 1, n: n)
        let take: Int
        let rodLength = index + 1
        if rodLength <= n {
            take = nums[index] + rodCutRecursion(nums: nums, index: index, n: n - rodLength)
        } else {
            take = Int.min
        }
        return max(take, notTake)
    }

    // TC - O(n ^ 2)
    // SC - O(n ^ 2) + O(n)
    private func rodCutRecursionMemo(nums: [Int], dp: inout [[Int]], index: Int, n: Int) -> Int {
        if index == 0 {
            return n * nums[0]
        }
        if dp[index][n] != -1 {
            return dp[index][n]
        }
        let notTake = rodCutRecursionMemo(nums: nums, dp: &dp, index: index - 1, n: n)
        let take: Int
        let rodLength = index + 1
        if rodLength <= n {
            take = nums[index] + rodCutRecursionMemo(nums: nums, dp: &dp, index: index, n: n - rodLength)
        } else {
            take = Int.min
        }
        dp[index][n] = max(take, notTake)
        return dp[index][n]
    }

    // TC - O(n ^ 2)
    // SC - O(n ^ 2)
    private func rodCutRecursionTabu(nums: [Int], n: Int) -> Int {
        let count = nums.count - 1
        var dp = [[Int]](repeating: [Int](repeating: 0, count: n + 1), count: count)
        for rodLength in stride(from: 0, through: n, by: 1) {
            dp[0][rodLength] = rodLength * nums[0]
        }

        for index in stride(from: 1, through: count - 1, by: 1) {

            for rodLength in stride(from: 0, through: n, by: 1) where index + 1 <= rodLength {
                let notTake = dp[index - 1][rodLength]
                let take = nums[index] + dp[index][index + 1 - rodLength]
                dp[index][rodLength] = max(take, notTake)
            }
        }
        return dp[count][n]
    }

    private func rodCutSpaceOpti1(nums: [Int], n: Int) -> Int {
        let count = nums.count - 1
        var previous = [Int](repeating: 0, count: n + 1)
        for rodLength in stride(from: 0, through: n, by: 1) {
            previous[rodLength] = rodLength * nums[0]
        }

        for index in stride(from: 1, through: count - 1, by: 1) {
            var current = previous
            for rodLength in stride(from: 0, through: n, by: 1) where index + 1 <= rodLength {
                let notTake = previous[rodLength]
                let take = nums[index] + current[index + 1 - rodLength]
                current[rodLength] = max(take, notTake)
            }
            previous = current
        }
        return previous[n]
    }

    private func rodCutSpaceOpti2(nums: [Int], n: Int) -> Int {
        let count = nums.count - 1
        var previous = [Int](repeating: 0, count: n + 1)
        for rodLength in stride(from: 0, through: n, by: 1) {
            previous[rodLength] = rodLength * nums[0]
        }

        for index in stride(from: 1, through: count - 1, by: 1) {
            for rodLength in stride(from: 0, through: n, by: 1) where index + 1 <= rodLength {
                let notTake = previous[rodLength]
                let take = nums[index] + previous[index + 1 - rodLength]
                previous[rodLength] = max(take, notTake)
            }
        }
        return previous[n]
    }

    /*
     Given an integer array nums, return the length of the longest strictly increasing subsequence.



     Example 1:

     Input: nums = [10,9,2,5,3,7,101,18]
     Output: 4
     Explanation: The longest increasing subsequence is [2,3,7,101], therefore the length is 4.
     Example 2:

     Input: nums = [0,1,0,3,2,3]
     Output: 4
     Example 3:

     Input: nums = [7,7,7,7,7,7,7]
     Output: 1


     Constraints:

     1 <= nums.length <= 2500
     -104 <= nums[i] <= 104

     */

    // TC - O(2 ^ n),
    // SC - O(n)
    func lengthOfLISRec(_ nums: [Int]) -> Int {
        lengthOfLISRecursion(nums: nums, index: 0, previousIndex: -1)
    }

    func lengthOfLISRecursion(nums: [Int], index: Int, previousIndex: Int) -> Int {
        if index == nums.count {
            return 0
        }
        var length: Int
        length = lengthOfLISRecursion(nums: nums, index: index + 1, previousIndex: previousIndex)
        if previousIndex == -1 || nums[index] > nums[previousIndex] {
            length = max(length, 1 + lengthOfLISRecursion(nums: nums, index: index + 1, previousIndex: index))
        }
        return length
    }

    // TC - O(n ^ 2),
    // SC - O(n ^ 2) + O(n)
    func lengthOfLISMemo(_ nums: [Int]) -> Int {
        var dp = [[Int]](repeating: [Int](repeating: -1, count: nums.count), count: nums.count + 1)
        return lengthOfLISMemoization(nums: nums, dp: &dp, index: 0, previousIndex: -1)
    }

    // TC - O(n ^ 2),
    // SC - O(2 * n)
    func lengthOfLISMemoization(nums: [Int], dp: inout [[Int]], index: Int, previousIndex: Int) -> Int {
        if index == nums.count {
            return 0
        }
        if dp[index][previousIndex + 1] != -1 {
            return dp[index][previousIndex + 1]
        }
        dp[index][previousIndex + 1] = lengthOfLISMemoization(nums: nums, dp: &dp, index: index + 1, previousIndex: previousIndex)
        if previousIndex == -1 || nums[index] > nums[previousIndex] {
            dp[index][previousIndex + 1] = max(dp[index][previousIndex + 1], 1 + lengthOfLISMemoization(nums: nums, dp: &dp, index: index + 1, previousIndex: index))
        }
        return dp[index][previousIndex + 1]
    }

    func lengthOfLISTabulation(_ nums: [Int]) -> Int {
        var dp = [[Int]](repeating: [Int](repeating: 0, count: nums.count + 1), count: nums.count + 1)
        for index in stride(from: nums.count - 1, through: 0, by: -1) {
            for previousIndex in stride(from: index - 1, through: -1, by: -1) {
                dp[index][previousIndex + 1] = dp[index + 1][previousIndex + 1]
                if previousIndex == -1 || nums[index] > nums[previousIndex] {
                    dp[index][previousIndex + 1] = max(dp[index][previousIndex + 1], 1 + dp[index + 1][index + 1])
                }
            }
        }
        return dp[0][0]
    }

    func lengthOfLISSpaceOpti1(_ nums: [Int]) -> Int {
        var ahead = [Int](repeating: 0, count: nums.count + 1)
        var current = [Int](repeating: 0, count: nums.count + 1)
        for index in stride(from: nums.count - 1, through: 0, by: -1) {
            for previousIndex in stride(from: index - 1, through: -1, by: -1) {
                current[previousIndex + 1] = ahead[previousIndex + 1]
                if previousIndex == -1 || nums[index] > nums[previousIndex] {
                    current[previousIndex + 1] = max(current[previousIndex + 1], 1 + ahead[index + 1])
                }
            }
            ahead = current
        }
        return ahead[0]
    }

    // TC - O(n ^ 2),
    // SC - O(n)
    func lengthOfLISTabulation2(_ nums: [Int]) -> Int {
        var dp = [Int](repeating: 1, count: nums.count)
        var maximum = Int.min
        for index in stride(from: 0, through: nums.count - 1, by: 1) {
            for previousIndex in stride(from: 0, through: index, by: 1) {
                if nums[previousIndex] < nums[index] {
                    dp[index] = max(dp[index], 1 + dp[previousIndex])
                }
            }
            maximum = max(maximum, dp[index])
        }
        return maximum
    }

    func printLISTabulation2(_ nums: [Int]) -> [Int] {
        var dp = [Int](repeating: 1, count: nums.count)
        var hash = [Int](repeating: 0, count: nums.count)
        var maximum = Int.min
        var lastIndex = 0
        for index in stride(from: 0, through: nums.count - 1, by: 1) {
            hash[index] = index
            for previousIndex in stride(from: 0, through: index - 1, by: 1) {
                if nums[previousIndex] < nums[index] && 1 + dp[previousIndex] > dp[index] {
                    dp[index] = 1 + dp[previousIndex]
                    hash[index] = previousIndex
                }
            }
            if dp[index] > maximum {
                maximum = dp[index]
                lastIndex = index
            }
        }

        var lis = [Int](repeating: 0, count: maximum)
        lis[maximum - 1] = nums[lastIndex]
        var lisIndex = maximum - 2
        while hash[lastIndex] != lastIndex {
            lastIndex = hash[lastIndex]
            lis[lisIndex] = nums[lastIndex]

            lisIndex -= 1
         }
        return lis
    }

    func lengthOfLISBS(_ nums: [Int]) -> Int {
        var temp = [Int]()
        temp.append(nums[0])
        for index in stride(from: 0, through: nums.count - 1, by: 1) {
            if nums[index] > temp.last! {
                temp.append(nums[index])
            } else {
                let index1 = lowerBound(nums: temp, target: nums[index])
                temp[index1] = nums[index]
            }
        }
        return temp.count
    }

    private func lowerBound(nums: [Int], target: Int) -> Int {
        var low = nums.startIndex
        var high = nums.endIndex
        var result = 0
        while low <= high {
            let mid = low + (high - low) / 2
            if nums[mid] >= target {
                result = mid
                high = mid - 1
            } else {
                low = mid + 1
            }
        }
        return result
    }

    /*
     Given a set of distinct positive integers nums, return the largest subset answer such that every pair (answer[i], answer[j]) of elements in this subset satisfies:

     answer[i] % answer[j] == 0, or
     answer[j] % answer[i] == 0
     If there are multiple solutions, return any of them.



     Example 1:

     Input: nums = [1,2,3]
     Output: [1,2]
     Explanation: [1,3] is also accepted.
     Example 2:

     Input: nums = [1,2,4,8]
     Output: [1,2,4,8]


     Constraints:

     1 <= nums.length <= 1000
     1 <= nums[i] <= 2 * 109
     All the integers in nums are unique.
     */

    func largestDivisibleSubset(_ nums: [Int]) -> [Int] {
        var array = nums
        array.sort()
        var dp = [Int](repeating: 1, count: array.count)
        var hash = [Int](repeating: 1, count: array.count)
        var maximum: Int = 1
        var lastIndex = 0
        for index in stride(from: 0, through: array.count - 1, by: 1) {
            hash[index] = index
            for previousIndex in stride(from: 0, through: index - 1, by: 1) {
                if array[index] % array[previousIndex] == 0 && 1 + dp[previousIndex] > dp[index] {
                    dp[index] = 1 + dp[previousIndex]
                    hash[index] = previousIndex
                }
            }
            if dp[index] > maximum {
                maximum = dp[index]
                lastIndex = index
            }
        }

        var lis = [Int](repeating: 0, count: maximum)
        lis[maximum - 1] = array[lastIndex]
        var lisIndex = maximum - 2
        while hash[lastIndex] != lastIndex {
            lastIndex = hash[lastIndex]
            lis[lisIndex] = array[lastIndex]
            lisIndex -= 1
        }
        return lis

    }

    /*
     Given an integer array nums, return the number of longest increasing subsequences.

     Notice that the sequence has to be strictly increasing.



     Example 1:

     Input: nums = [1,3,5,4,7]
     Output: 2
     Explanation: The two longest increasing subsequences are [1, 3, 4, 7] and [1, 3, 5, 7].
     Example 2:

     Input: nums = [2,2,2,2,2]
     Output: 5
     Explanation: The length of the longest increasing subsequence is 1, and there are 5 increasing subsequences of length 1, so output 5.


     Constraints:

     1 <= nums.length <= 2000
     -106 <= nums[i] <= 106
     The answer is guaranteed to fit inside a 32-bit integer.
     */

    func findNumberOfLIS(_ nums: [Int]) -> Int {
        let count = nums.count
        var dp = [Int](repeating: 1, count: count)
        var lisCount = [Int](repeating: 1, count: count)
        var maxi = 1
        for index in stride(from: 0, through: count - 1, by: 1) {
            for previousIndex in stride(from: 0, through: index - 1, by: 1) {
                if nums[previousIndex] < nums[index] && 1 + dp[previousIndex] > dp[index] {
                    dp[index] = 1 + dp[previousIndex]
                    lisCount[index] = lisCount[previousIndex]
                } else if nums[previousIndex] < nums[index] && 1 + dp[previousIndex] == dp[index] {
                    lisCount[index] += lisCount[previousIndex]
                }
            }
            maxi = max(maxi, dp[index])
        }
        var result = 0
        for i in stride(from: 0, through: count - 1, by: 1) {
            if dp[i] == maxi {
                result += lisCount[i]
            }
        }
        return result
    }

    /*
     MCM
     */

    func mcmRec(nums: [Int]) -> Int {
        mcmRecursion(nums: nums, i: 1, j: nums.count - 1)
    }

    func mcmRecursion(nums: [Int], i: Int, j: Int) -> Int {
        if i == j {
            return 0
        }
        var minimum = 0
        for index in stride(from: i, through: j - 1, by: 1) {
            let steps = nums[i - 1] * nums[index] * nums[j] + mcmRecursion(nums: nums, i: i, j: index) + mcmRecursion(nums: nums, i: index + 1, j: j)
            minimum = min(minimum, steps)
        }
        return minimum
    }

    // TC - O(n * n * n)
    // SC - O(n * n) + O(n)
    func mcmMemo(nums: [Int]) -> Int {
        var dp = [[Int]](repeating: [Int](repeating: -1, count: nums.count), count: nums.count)
        return mcmMemoization(nums: nums, dp: &dp, i: 1, j: nums.count - 1)
    }

    func mcmMemoization(nums: [Int], dp: inout [[Int]], i: Int, j: Int) -> Int {
        if i == j {
            return 0
        }
        if dp[i][j] != -1 {
            return dp[i][j]
        }
        var minimum = 0
        for index in stride(from: i, through: j - 1, by: 1) {
            let steps = nums[i - 1] * nums[index] * nums[j] + mcmRecursion(nums: nums, i: i, j: index) + mcmRecursion(nums: nums, i: index + 1, j: j)
            minimum = min(minimum, steps)
        }
        dp[i][j] = minimum
        return dp[i][j]
    }

    // TC - O(n * n * n)
    // SC - O(n * n)
    func mcmTabulation(nums: [Int]) -> Int {
        let count = nums.count
        var dp = [[Int]](repeating: [Int](repeating: 0, count: nums.count), count: count)
        for index in stride(from: 0, through: count - 1, by: 1) {
            dp[index][index] = 0
        }

        for i in stride(from: count - 1, through: 0, by: 1) {
            for j in stride(from: i + 1, through: count - 1, by: 1) {
                var minimum = Int.min
                for index in stride(from: i, through: j - 1, by: 1) {
                    let steps = nums[i - 1] * nums[index] * nums[j] + dp[i][index] + dp[index + 1][j]
                    minimum = min(minimum, steps)
                }
                dp[i][j] = minimum
            }
        }
        return dp[1][count - 1]
    }

    /*
     Given a wooden stick of length n units. The stick is labelled from 0 to n. For example, a stick of length 6 is labelled as follows:


     Given an integer array cuts where cuts[i] denotes a position you should perform a cut at.

     You should perform the cuts in order, you can change the order of the cuts as you wish.

     The cost of one cut is the length of the stick to be cut, the total cost is the sum of costs of all cuts. When you cut a stick, it will be split into two smaller sticks (i.e. the sum of their lengths is the length of the stick before the cut). Please refer to the first example for a better explanation.

     Return the minimum total cost of the cuts.



     Example 1:


     Input: n = 7, cuts = [1,3,4,5]
     Output: 16
     Explanation: Using cuts order = [1, 3, 4, 5] as in the input leads to the following scenario:

     The first cut is done to a rod of length 7 so the cost is 7. The second cut is done to a rod of length 6 (i.e. the second part of the first cut), the third is done to a rod of length 4 and the last cut is to a rod of length 3. The total cost is 7 + 6 + 4 + 3 = 20.
     Rearranging the cuts to be [3, 5, 1, 4] for example will lead to a scenario with total cost = 16 (as shown in the example photo 7 + 4 + 3 + 2 = 16).
     Example 2:

     Input: n = 9, cuts = [5,6,1,4,2]
     Output: 22
     Explanation: If you try the given cuts ordering the cost will be 25.
     There are much ordering with total cost <= 25, for example, the order [4, 6, 5, 2, 1] has total cost = 22 which is the minimum possible.


     Constraints:

     2 <= n <= 106
     1 <= cuts.length <= min(n - 1, 100)
     1 <= cuts[i] <= n - 1
     All the integers in cuts array are distinct.
     */

    // TC - Exponential
    func minCostRec(_ n: Int, _ cuts: [Int]) -> Int {
        var cuts = cuts
        cuts.sort()
        cuts.insert(0, at: 0)
        cuts.append(n)

        return minCostRecursion(cuts: cuts, i: 1, j: cuts.count - 2)
    }

    func minCostRecursion(cuts: [Int], i: Int, j: Int) -> Int {
        if i > j {
            return 0
        }
        var minimum = Int.max
        for index in stride(from: i, through: j, by: 1) {
            let result = cuts[j + 1] - cuts[i - 1] + minCostRecursion(cuts: cuts, i: i, j: index - 1) + minCostRecursion(cuts: cuts, i: index + 1, j: j)
            minimum = min(result, minimum)
        }
        return minimum
    }

    // TC - O(n ^ 3)
    // SC - O(n ^ 2) + O(n)
    func minCostMemo(_ n: Int, _ cuts: [Int]) -> Int {
        let count = cuts.count
        var cuts = cuts
        cuts.sort()
        cuts.insert(0, at: 0)
        cuts.append(n)
        var dp = [[Int]](repeating: [Int](repeating: -1, count: count + 1), count: count + 1)

        return minCostMemoization(cuts: cuts, dp: &dp, i: 1, j: cuts.count - 2)
    }

    func minCostMemoization(cuts: [Int], dp: inout [[Int]], i: Int, j: Int) -> Int {
        if i > j {
            return 0
        }
        if dp[i][j] != -1 {
            return dp[i][j]
        }
        var minimum = Int.max
        for index in stride(from: i, through: j, by: 1) {
            let result = cuts[j + 1] - cuts[i - 1] + minCostMemoization(cuts: cuts, dp: &dp, i: i, j: index - 1) + minCostMemoization(cuts: cuts, dp: &dp, i: index + 1, j: j)
            minimum = min(result, minimum)
        }
        dp[i][j] = minimum

        return dp[i][j]
    }

    func minCostTabulation(_ n: Int, _ cuts: [Int]) -> Int {
        let count = cuts.count
        var cuts = cuts
        cuts.sort()
        cuts.insert(0, at: 0)
        cuts.append(n)
        var dp = [[Int]](repeating: [Int](repeating: 0, count: count + 2), count: count + 2)
        
        for i in stride(from: count, through: 1, by: -1) {
            for j in stride(from: 1, through: count, by: 1) {
                if i > j {
                    continue
                }
                var minimum = Int.max
                for index in stride(from: i, through: j, by: 1) {
                    let result = cuts[j + 1] - cuts[i - 1] + dp[i][index - 1] + dp[index + 1][j]
                    minimum = min(result, minimum)
                }
                dp[i][j] = minimum
            }
        }
        
        return dp[1][count]
    }

    /*
     You are given n balloons, indexed from 0 to n - 1. Each balloon is painted with a number on it represented by an array nums. You are asked to burst all the balloons.

     If you burst the ith balloon, you will get nums[i - 1] * nums[i] * nums[i + 1] coins. If i - 1 or i + 1 goes out of bounds of the array, then treat it as if there is a balloon with a 1 painted on it.

     Return the maximum coins you can collect by bursting the balloons wisely.



     Example 1:

     Input: nums = [3,1,5,8]
     Output: 167
     Explanation:
     nums = [3,1,5,8] --> [3,5,8] --> [3,8] --> [8] --> []
     coins =  3*1*5    +   3*5*8   +  1*3*8  + 1*8*1 = 167
     Example 2:

     Input: nums = [1,5]
     Output: 10


     Constraints:

     n == nums.length
     1 <= n <= 300
     0 <= nums[i] <= 100
     */

    // TC - Exponential
    func maxCoinsRec(_ nums: [Int]) -> Int {
        let count = nums.count
        var nums1 = nums
        nums1.insert(1, at: 0)
        nums1.append(1)
        return maxCoinsRecursion(nums: nums1, i: 1, j: count)
    }

    func maxCoinsRecursion(nums: [Int], i: Int, j: Int) -> Int {
        if i > j {
            return 0
        }
        var maximum = -Int(1e9)
        for index in stride(from: i, through: j, by: 1) {
            let result = nums[i - 1] * nums[index] * nums[j + 1] + maxCoinsRecursion(nums: nums, i: i, j: index - 1) + maxCoinsRecursion(nums: nums, i: index + 1, j: j)
            maximum = max(result, maximum)
        }
        return maximum
    }

    // TC - O(n ^ 3)
    // SC - O(n ^ 2) + O(n)
    func maxCoinsMemo(_ nums: [Int]) -> Int {
        let count = nums.count
        var nums1 = nums
        nums1.insert(1, at: 0)
        nums1.append(1)
        var dp = [[Int]](repeating: [Int](repeating: -1, count: count + 1), count: count + 1)
        return maxCoinsMemoization(nums: nums1, dp: &dp, i: 1, j: count)
    }

    func maxCoinsMemoization(nums: [Int], dp: inout [[Int]], i: Int, j: Int) -> Int {
        if i > j {
            return 0
        }
        if dp[i][j] != -1 {
            return dp[i][j]
        }
        var maximum = -Int(1e9)
        for index in stride(from: i, through: j, by: 1) {
            let result = nums[i - 1] * nums[index] * nums[j + 1] + maxCoinsMemoization(nums: nums, dp: &dp, i: i, j: index - 1) + maxCoinsMemoization(nums: nums, dp: &dp, i: index + 1, j: j)
            maximum = max(result, maximum)
        }
        dp[i][j] = maximum
        return dp[i][j]
    }

    func maxCoinsTabulation(_ nums: [Int]) -> Int {
        let count = nums.count
        var nums1 = nums
        nums1.insert(1, at: 0)
        nums1.append(1)
        var dp = [[Int]](repeating: [Int](repeating: 0, count: count + 2), count: count + 2)
        for i in stride(from: count, through: 1, by: -1) {
            for j in stride(from: 1, through: count, by: 1) {
                if i > j {
                    continue
                }
                var maximum = -Int(1e9)
                for index in stride(from: i, through: j, by: 1) {
                    let result = nums1[i - 1] * nums1[index] * nums1[j + 1] + dp[i][index - 1] + dp[index + 1][j]
                    maximum = max(result, maximum)
                }
                dp[i][j] = maximum
            }
            
        }
        return dp[1][count]
    }

    /*
     A boolean expression is an expression that evaluates to either true or false. It can be in one of the following shapes:

     't' that evaluates to true.
     'f' that evaluates to false.
     '!(subExpr)' that evaluates to the logical NOT of the inner expression subExpr.
     '&(subExpr1, subExpr2, ..., subExprn)' that evaluates to the logical AND of the inner expressions subExpr1, subExpr2, ..., subExprn where n >= 1.
     '|(subExpr1, subExpr2, ..., subExprn)' that evaluates to the logical OR of the inner expressions subExpr1, subExpr2, ..., subExprn where n >= 1.
     Given a string expression that represents a boolean expression, return the evaluation of that expression.

     It is guaranteed that the given expression is valid and follows the given rules.



     Example 1:

     Input: expression = "&(|(f))"
     Output: false
     Explanation:
     First, evaluate |(f) --> f. The expression is now "&(f)".
     Then, evaluate &(f) --> f. The expression is now "f".
     Finally, return false.
     Example 2:

     Input: expression = "|(f,f,f,t)"
     Output: true
     Explanation: The evaluation of (false OR false OR false OR true) is true.
     Example 3:

     Input: expression = "!(&(f,t))"
     Output: true
     Explanation:
     First, evaluate &(f,t) --> (false AND true) --> false --> f. The expression is now "!(f)".
     Then, evaluate !(f) --> NOT false --> true. We return true.


     Constraints:

     1 <= expression.length <= 2 * 104
     expression[i] is one following characters: '(', ')', '&', '|', '!', 't', 'f', and ','.

     */

    func boolean(expression: String) -> Int {
        booleanExpressionRecursion(string: Array(expression), i: 0, j: expression.count - 1, isTrue: 1)
    }

    func booleanExpressionRecursion(string: [Character], i: Int, j: Int, isTrue: Int) -> Int {
        if i > j {
            return 0
        }
        if i == j {
            if isTrue == 1 {
                return string[i] == "T" ? 1 : 0
            }
            return string[i] == "F" ? 1 : 0
        }

        var ways = 0
        for index in stride(from: i + 1, through: j - 1, by: 2) {
            let leftTrue = booleanExpressionRecursion(string: string, i: i, j: index - 1, isTrue: 1)
            let leftFalse = booleanExpressionRecursion(string: string, i: i, j: index - 1, isTrue: 0)
            let rightTrue = booleanExpressionRecursion(string: string, i: index + 1, j: j, isTrue: 1)
            let rightFalse = booleanExpressionRecursion(string: string, i: index + 1, j: j, isTrue: 0)

            if string[index] == "&" {
                if isTrue == 1 {
                    ways += leftTrue * rightTrue
                } else {
                    ways += leftTrue * rightFalse + leftFalse * rightTrue + leftFalse * rightFalse
                }

            } else if string[index] == "|" {
                if isTrue == 1 {
                    ways += leftTrue * rightTrue + leftTrue * rightFalse + leftFalse * rightTrue
                } else {
                    ways += leftFalse * rightFalse
                }
            } else {
                if isTrue == 1 {
                    ways += leftTrue * rightFalse + leftFalse * rightTrue
                } else {
                    ways += leftTrue * rightTrue + leftFalse * rightFalse
                }
            }
        }
        return ways
    }

    /*
     Given a string s, partition s such that every substring of the partition is a palindrome.

     Return the minimum cuts needed for a palindrome partitioning of s.



     Example 1:

     Input: s = "aab"
     Output: 1
     Explanation: The palindrome partitioning ["aa","b"] could be produced using 1 cut.
     Example 2:

     Input: s = "a"
     Output: 0
     Example 3:

     Input: s = "ab"
     Output: 1


     Constraints:

     1 <= s.length <= 2000
     s consists of lowercase English letters only.
     */

    // TC - Exponential
    func minCutRec(_ s: String) -> Int {
        minCutRecusrsion(string: Array(s), i: 0, total: s.count) - 1
    }

    func minCutRecusrsion(string: [Character], i: Int, total: Int) -> Int {
        if i == total {
            return 0
        }
        var temp = [Character]()
        var minimum = Int.max
        for index in stride(from: i, through: total - 1, by: 1) {
            temp.append(string[index])
            if isPalindrome(string: temp) {
                let result = 1 + minCutRecusrsion(string: string, i: index + 1, total: total)
                minimum = min(minimum, result)
            }
        }
        return minimum
    }

    func isPalindrome(string: [Character]) -> Bool {
        var count = string.count
        var i = 0
        while i < count - 1 {
            if string[i] == string[count - 1] {
                i += 1
                count -= 1
            } else {
                return false
            }
        }
        return true
    }

    // TC - O(n) * o(n)
    // SC - O(n) * O(n)
    func minCutMemo(_ s: String) -> Int {
        var dp = [Int](repeating: -1, count: s.count)
        return minCutMemoization(string: Array(s), dp: &dp, i: 0, total: s.count) - 1
    }

    func minCutMemoization(string: [Character], dp: inout [Int], i: Int, total: Int) -> Int {
        if i == total {
            return 0
        }

        if dp[i] != -1 {
            return dp[i]
        }
        var minimum = Int.max
        for index in stride(from: i, through: total - 1, by: 1) {
            if isPalindrome(string: string, i: i, j: index) {
                let result = 1 + minCutMemoization(string: string, dp: &dp, i: index + 1, total: total)
                minimum = min(minimum, result)
            }
        }
        dp[i] = minimum
        return  dp[i]
    }

    func isPalindrome(string: [Character], i: Int, j: Int) -> Bool {
        var i = i
        var j = j
        while i < j {
            if string[i] == string[j] {
                i += 1
                j -= 1
            } else {
                return false
            }
        }
        return true
    }

    func minCutTabulation(_ s: String) -> Int {
        let string = Array(s)
        let count = string.count
        var dp = [Int](repeating: 0, count: count + 1)

        for i in stride(from: count - 1, through: 0, by: -1) {
            var minimum = Int.max
            for index in stride(from: i, through: count - 1, by: 1) {
                if isPalindrome(string: string, i: i, j: index) {
                    let result = 1 + dp[index + 1]
                    minimum = min(minimum, result)
                }
            }
            dp[i] = minimum
        }
        return dp[0] - 1
    }
    /*
     Given an integer array arr, partition the array into (contiguous) subarrays of length at most k. After partitioning, each subarray has their values changed to become the maximum value of that subarray.

     Return the largest sum of the given array after partitioning. Test cases are generated so that the answer fits in a 32-bit integer.



     Example 1:

     Input: arr = [1,15,7,9,2,5,10], k = 3
     Output: 84
     Explanation: arr becomes [15,15,15,9,10,10,10]
     Example 2:

     Input: arr = [1,4,1,5,7,3,6,1,9,9,3], k = 4
     Output: 83
     Example 3:

     Input: arr = [1], k = 1
     Output: 1


     Constraints:

     1 <= arr.length <= 500
     0 <= arr[i] <= 109
     1 <= k <= arr.length
     */
    func maxSumAfterPartitioningRec(_ arr: [Int], _ k: Int) -> Int {
        maxSumAfterPartitioningRecursion(nums: arr, index: 0, k: k)
    }

    func maxSumAfterPartitioningRecursion(nums: [Int], index: Int, k: Int) -> Int {
        if index == nums.count {
            return 0
        }
        var maximum = Int.min
        var answer = Int.min
        var length = 0
        for i in stride(from: index, through: min(nums.count - 1, index + k - 1), by: 1) {
            length += 1
            maximum = max(maximum, nums[i])
            let sum = maximum * length + maxSumAfterPartitioningRecursion(nums: nums, index: i + 1, k: k)
            answer = max(answer, sum)
        }
        return answer
    }

    // TC - O(n * k)
    // SC - O(n) + O(n) Auxillary stack space
    func maxSumAfterPartitioning(_ arr: [Int], _ k: Int) -> Int {
        var dp = [Int](repeating: -1, count: arr.count)
        return maxSumAfterPartitioningMemoization(nums: arr, dp: &dp, index: 0, k: k)
    }

    func maxSumAfterPartitioningMemoization(nums: [Int], dp: inout [Int], index: Int, k: Int) -> Int {
        if index == nums.count {
            return 0
        }
        if dp[index] != -1 {
            return dp[index]
        }
        var maximum = Int.min
        var answer = Int.min
        var length = 0
        for i in stride(from: index, through: min(nums.count - 1, index + k - 1), by: 1) {
            length += 1
            maximum = max(maximum, nums[i])
            let sum = maximum * length + maxSumAfterPartitioningMemoization(nums: nums, dp: &dp, index: i + 1, k: k)
            answer = max(answer, sum)
        }
        dp[index] = answer
        return dp[index]
    }

    // TC - O(n * k)
    // SC - O(n)
    func maxSumAfterPartitioningTabulation(_ arr: [Int], _ k: Int) -> Int {
        let count = arr.count
        var dp = [Int](repeating: 0, count: count + 1)
        for index in stride(from: count - 1, through: 0, by: -1) {
            var maximum = Int.min
            var answer = Int.min
            var length = 0
            for i in stride(from: index, through: min(arr.count - 1, index + k - 1), by: 1) {
                length += 1
                maximum = max(maximum, arr[i])
                let sum = maximum * length + dp[i + 1]
                answer = max(answer, sum)
            }
            dp[index] = answer
        }
        return dp[0]
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
        let rowCount = matrix.count
        let columnCount = matrix[0].count
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
     1277. Count Square Submatrices with All Ones
     Medium
     Topics
     conpanies icon
     Companies
     Hint
     Given a m * n matrix of ones and zeros, return how many square submatrices have all ones.



     Example 1:

     Input: matrix =
     [
       [0,1,1,1],
       [1,1,1,1],
       [0,1,1,1]
     ]
     Output: 15
     Explanation:
     There are 10 squares of side 1.
     There are 4 squares of side 2.
     There is  1 square of side 3.
     Total number of squares = 10 + 4 + 1 = 15.
     Example 2:

     Input: matrix =
     [
       [1,0,1],
       [1,1,0],
       [1,1,0]
     ]
     Output: 7
     Explanation:
     There are 6 squares of side 1.
     There is 1 square of side 2.
     Total number of squares = 6 + 1 = 7.


     Constraints:

     1 <= arr.length <= 300
     1 <= arr[0].length <= 300
     0 <= arr[i][j] <= 1

     */

    func countSquares(_ matrix: [[Int]]) -> Int {
        let rowCount = matrix.count
        let columnCount = matrix[0].count
        var dp = [[Int]](repeating: [Int](repeating: 0, count: columnCount), count: rowCount)
        for j in stride(from: 0, through: columnCount - 1, by: 1) {
            dp[0][j] = matrix[0][j]
        }
        for i in stride(from: 0, through: rowCount - 1, by: 1) {
            dp[i][0] = matrix[i][0]
        }
        for i in stride(from: 1, through: rowCount - 1, by: 1) {
            for j in stride(from: 1, through: columnCount - 1, by: 1) {
                if matrix[i][j] == 0 {
                    dp[i][j] = 0
                } else {
                    dp[i][j] = min(dp[i - 1][j - 1], dp[i - 1][j], dp[i][j - 1]) + 1
                }
            }
        }
        var sum = 0
        for i in stride(from: 0, through: rowCount - 1, by: 1) {
            for j in stride(from: 0, through: columnCount - 1, by: 1) {
                sum += dp[i][j]
            }
        }
        return sum
    }
    /*
     You are given an integer array nums of 2 * n integers. You need to partition nums into two arrays of length n to minimize the absolute difference of the sums of the arrays. To partition nums, put each element of nums into one of the two arrays.

     Return the minimum possible absolute difference.



     Example 1:

     example-1
     Input: nums = [3,9,7,3]
     Output: 2
     Explanation: One optimal partition is: [3,9] and [7,3].
     The absolute difference between the sums of the arrays is abs((3 + 9) - (7 + 3)) = 2.
     Example 2:

     Input: nums = [-36,36]
     Output: 72
     Explanation: One optimal partition is: [-36] and [36].
     The absolute difference between the sums of the arrays is abs((-36) - (36)) = 72.
     Example 3:

     example-3
     Input: nums = [2,-1,0,4,-2,-9]
     Output: 0
     Explanation: One optimal partition is: [2,4,-9] and [-1,0,-2].
     The absolute difference between the sums of the arrays is abs((2 + 4 + -9) - (-1 + 0 + -2)) = 0.


     Constraints:

     1 <= n <= 15
     nums.length == 2 * n
     -107 <= nums[i] <= 107
     */
}
