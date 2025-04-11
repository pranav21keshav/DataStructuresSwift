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

    // There a n stairs and initial position is 0. At a time only 1 or 2 steps can be climbed. Return number of distinct steps in which n steps can be climbed

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
            for i in 0..<2 {
                guard i != last else { continue }
                maximum = max(maximum, nums[day][last])
            }
            return maximum
        }
        var maximum = 0
        for i in 0..<2 {
            guard i != last else { continue }
            let point = nums[day][i] + ninjaMaximumPointsRecursion(nums: nums, day: day - i, last: i)
            maximum = max(maximum, point)
        }
        return maximum
    }

    func ninjaMaximumPointsMemoization(nums: [[Int]]) -> Int {
        let dpRow = [Int](repeating: -1, count: 3)
        var dp = [[Int]](repeating: dpRow, count: nums.count)

        return ninjaMaximumPointsMemoizationRecursion(nums: nums, day: nums.count - 1, last: 3, dp: &dp)
    }

    // TC - O(nx4x3)
    // SC - O(n) + O(Nx4)
    func ninjaMaximumPointsMemoizationRecursion(nums: [[Int]], day: Int, last: Int, dp: inout [[Int]]) -> Int {
        if day == 0 {
            var maximum = 0
            for i in 0..<2 {
                guard i != last else { continue }
                maximum = max(maximum, nums[day][i])
            }
            return maximum
        }
        guard dp[day][last] == -1 else { return dp[day][last] }
        var maximum = 0
        for i in 0..<2 {
            guard i != last else { continue }
            let point = nums[day][i] + ninjaMaximumPointsMemoizationRecursion(nums: nums, day: day, last: i, dp: &dp)
            maximum = max(maximum, point)
        }
        dp[day][last] = maximum
        return dp[day][last]
    }
}
