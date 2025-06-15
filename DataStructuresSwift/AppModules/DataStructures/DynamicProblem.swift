//
//  DP.swift
//  DataStructuresSwift
//
//  Created by Pranav Pravakar on 10/03/25.
//  Copyright © 2025 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation
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
     */

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
}
