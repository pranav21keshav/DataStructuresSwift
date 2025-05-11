//
//  ArrayProblems.swift
//  DataStructuresSwift
//
//  Created by Pranav Pravakar on 21/06/24.
//  Copyright © 2024 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation
struct ArrayProblems {
    init() {
        print("\n ---------> Pair Count Unsorted Array <---------")
        let countPairs1 = [1, 5, 7, -1, 5]
        let countPairs2 = [1, 1, 1, 1]
        let countPairs3 = [10, 12, 10, 15, -1]
        countPairs(in: countPairs1, target: 6)
        countPairs(in: countPairs2, target: 2)
        countPairs(in: countPairs3, target: 125)
        print(" Subsets - [1, 2, 3] - ", subsets([1, 2, 3]))
        print(" Subsets - [1, 2, 3] - ", subsetsUsingPowerSet(array: [1, 2, 3]))
        print(" Subsequences [1, 2, 1] with sum 2 - ", subsequencesWithSumRecursionNested(nums: [1, 2, 1], sum: 2))
        print(" Subsequences [2, 3, 10, -5, 1, 4] with sum 5 - ", subsequencesWithSumRecursionNested(nums: [2, 3, 10, -5, 1, 4], sum: 5))
        print(" Subsequences current sum only positive [1, 2, 1] with sum 2 - ", subsequencesWithSumOnlyPositiveIntegers(nums: [1, 2, 1], sum: 2))
        print(" Subsequences current sum only positive [2, 3, 10, -5] with sum 5 - ", subsequencesWithSumOnlyPositiveIntegers(nums: [2, 3, 10, -5], sum: 5))
        print(" Subsequences without current sum [1, 2, 1] with sum 2 - ", subsequencesWithSumWithoutCurrentSum(nums: [1, 2, 1], sum: 2))
        print(" Subsequences without current sum [2, 3, 10, -5, 1, 4] with sum 5 - ", subsequencesWithSumWithoutCurrentSum(nums: [2, 3, 10, -5, 1, 4], sum: 5))
        print(" Anyone subsequence [1, 2, 1 with sum 2 - ", anyOneSubsequenceWithSumRecursion(nums: [1, 2, 1], sum: 2))
        print(" Subsequence count [1, 2, 1] with sum 2 - ", countSubsequencesWithSumRecusion(nums: [1, 2, 1], sum: 2))
        print(" Subsequences with postive repeating [2, 3, 6, 7] with sum 7 - ", subsequencesWithPositiveNumbersRepeating(nums: [2, 3, 6, 7], sum: 7))
        print(" Subsequences with repeating [2, 3, 6, 7] with sum 7 - ", subsequencesWithNumbersRepeating(nums: [2, 3, 6, 7], sum: 7))
        //        print(" Subsequences with positive repeating [2, 3, 6, 7, 14, -7] with sum 7 - ", subsequencesWithPositiveNumbersRepeating(nums: [2, 3, 6, 7, 14, -7], sum: 7))
        //        print(" Subsequences with numbers repeating [2, 3, 6, 7, 14, -7] with sum 7 - ", subsequencesWithNumbersRepeating(nums: [2, 3, 6, 7, 14, -7], sum: 7))
        print(" Subsequences with unique combination [1, 1, 1, 2, 2] with sum 4 - ", subsequenceUniqueCombinationsForGivenSumLoop(nums: [1, 1, 1, 2, 2], sum: 4))
        print(" Permutations recursoion - [1, 2, 3] - ", perumations(nums: [1, 2, 3]))
        print(" n queen optimal with board size 4 - ", nQueensOptimal(boardSize: 4))
        print(" 17th permutation in sequence 4 is - \(kthPermuationSequenceFor(number: 4, kth: 17))")
        print(" 80th permutation in sequence 6 is - \(kthPermuationSequenceFor(number: 6, kth: 80))")
    }
    func kthSmallestPriotityQueue() {}

    func kthLargestModifiedQuickSelect() {}
    /*
     Given an array arr[] of n integers and a target value, the task is to find the number of pairs of integers in the array whose sum is equal to target.

     Input: arr[] = {1, 5, 7, -1, 5}, target = 6
     Output:  3
     Explanation: Pairs with sum 6 are (1, 5), (7, -1) & (1, 5).


     Input: arr[] = {1, 1, 1, 1}, target = 2
     Output:  6
     Explanation: Pairs with sum 2 are (1, 1), (1, 1), (1, 1), (1, 1), (1, 1) and (1, 1).


     Input: arr[] = {10, 12, 10, 15, -1}, target = 125
     Output:  0

     */
    func countPairs(in array: [Int], target: Int) {
        var count = 0
        var frequency: [Int: Int] = [:]
        for element in array {
            let key = target - element
            //            if let value = frequency[key] {
            //                count += value
            //            }
            count += frequency[key] ?? 0
            frequency[element] = (frequency[element] ?? 0) + 1
        }

        print("Pairs count for \(target) in \(array): \(count)")
        print("Frequency: \(frequency)")
    }

    func isTwoSumPresentInSortedArray(in array: [Int], target: Int) {
        var left = 0, right = array.count - 1
        var result = false
        while left < right {
            if array[left] + array[right] == target {
                result = true
                break
            }
            if array[left] + array[right] < target {
                left += 1
            } else {
                right -= 1
            }
        }
        if result {
            print("2 sum target - \(target) is present in array - \(array)")
        } else {
            print("2 sum target - \(target) is not present in array - \(array)")
        }
    }

    func isTwoSumPresentInSortedArrayUsingHashSet(in array: [Int], target: Int) {
        var hashSet: [Int] = []
        for element in array {
            if hashSet.contains(target - element) {
                print("2 sum target - \(target) is present in array - \(array)")
                break
            }
            hashSet.append(element)
        }
    }

    /*
     Given an array arr[] of non-negative integers, where each element arr[i] represents the height of the vertical lines, find the maximum amount of water that can be contained between any two lines, together with the x-axis.

     Examples :

     Input: arr[] = [1, 5, 4, 3]
     Output: 6
     Explanation: 5 and 3 are 2 distance apart. So the size of the base = 2. Height of container = min(5, 3) = 3. So total area = 3 * 2 = 6.


     Input: arr[] = [3, 1, 2, 4, 5]
     Output: 12
     Explanation: 5 and 3 are distance 4 apart. So the size of the base = 4. Height of container = min(5, 3) = 3. So total area = 4 * 3 = 12.


     Input: arr[] = [2, 1, 8, 6, 4, 6, 5, 5]
     Output: 25
     Explanation: 8 and 5 are 5 distance apart. So the size of the base = 5. Height of container = min(8, 5) = 5. So, total area = 5 * 5 = 12.
     */

    // Naive approach Water Trapped
    // Time - O(n^2)
    // Space - O(1)
    func maxWaterTrappedUsingNaiveApproach(in array: [Int]) {
        var maxWater = 0
        for i in 0..<array.count {
            for j in 1..<array.count {
                let trappedWater = min(array[i], array[j]) * (j - i)
                maxWater = max(maxWater, trappedWater)
            }
        }
        print("---> Max water that can be trapped inside the array - \(array) using naive approach is \(maxWater)")
    }

    // Efficient approach Water Trapped
    // Time - O(n)
    // Space - O(1)
    func maxWaterTrappedUsingEfficientApproach(array: [Int]) {
        var maxWater = 0
        var left = 0
        var right = array.count - 1
        while left < right {
            let trappedWater = min(array[left], array[right]) * (right - left)
            maxWater = max(maxWater, trappedWater)
            if array[left] < array[right] {
                left += 1
            } else {
                right -= 1
            }
        }
        print("---> Max water that can be trapped inside the array - \(array) using efficient approach is \(maxWater)")
    }

    func threeSumSorted(array: [Int]) -> [[Int]] {
        var sorted = array.sorted()
        var result = [[Int]]()
        var count = sorted.count
        for (index, element) in array.sorted().enumerated() {
            var left = index + 1
            var right = count - 1

            if index > 0 && element == sorted[index - 1] {
                continue
            }
            while left < right {
                let rightElement = sorted[right]
                if right < count - 1 && rightElement == sorted[right + 1] {
                    right -= 1
                    continue
                }
                let leftElement = sorted[left]
                let sum = element + leftElement + rightElement
                if sum == 0 {
                    result.append([element, leftElement, rightElement])
                    left += 1
                    right -= 1
                } else if sum < 0 {
                    left += 1
                } else {
                    right -= 1
                }
            }
        }
        return result
    }

    func threeSumDictionary(array: [Int], sum: Int) -> [[Int]] {
        var result = [[Int]]()
        let count = array.count
        for outerIndex in 0..<count - 2 {
            var dict = [Int: Int]()
            let first = array[outerIndex]
            let target = sum - first
            for innerIndex in outerIndex + 1..<count {
                let second = array[innerIndex]
                let diff = target - second
                if let value = dict[diff] {
                    result.append([first, second, value])
                    continue
                }
                dict[second] = innerIndex
            }
        }
        return result
    }

    // O(n*2^n - Time)
    func subsetsUsingPowerSet<T>(array: [T]) -> [[T]] {
        print("--- Subsets using power set---")
        var answer = [[T]]()
        let count = array.count
        for i in 0...(1 << count) - 1 {
            var temp = [T]()
            for j in 0..<count {
                if i & (1 << j) != 0 {
                    temp.append(array[j])
                }
            }
            answer.append(temp)
        }
        return answer
    }

    // MARK: Subsets
    func subsets(_ nums: [Int]) -> [[Int]] {
        print("--- Subsets Recursion ---")
        // Create the output array
        var subsets: [[Int]] = []

        // Add all subsets
        add(subsets: &subsets, nums: nums, index: 0, current: [])

        func add(subsets: inout [[Int]], nums: [Int], index: Int, current: [Int]) {
            if index == nums.count {
                subsets.append(current)
                return
            }
            var current = current
            current.append(nums[index])
            // Take
            add(subsets: &subsets, nums: nums, index: index + 1, current: current)
            // Not take
            current.remove(at: current.count - 1)
            add(subsets: &subsets, nums: nums, index: index + 1, current: current)

        }

        // And returns
        return subsets
    }

    func subsetsOutside(_ nums: [Int]) -> [[Int]] {
        print("--- Subsets Recursion ---")
        // Create the output array
        var subsets: [[Int]] = []

        // Add all subsets
        add(subsets: &subsets, nums: nums, index: 0, current: [])

        func add(subsets: inout [[Int]], nums: [Int], index: Int, current: [Int]) {
            if index == nums.count {
                subsets.append(current)
                return
            }
            var current = current
            current.append(nums[index])
            // Take
            add(subsets: &subsets, nums: nums, index: index + 1, current: current)
            // Not take
            current.remove(at: current.count - 1)
            add(subsets: &subsets, nums: nums, index: index + 1, current: current)

        }

        // And returns
        return subsets
    }

    func subsequencesWithSumRecusrsion(nums: [Int], sum: Int) -> [[Int]] {
        print("--- Subsequences using recursion---")
        var result = [[Int]]()

        subsequencesRecursion(subseq: &result, nums: nums, sum: sum, current: [], index: 0, currentSum: 0)
        return result
    }

    func subsequencesRecursion(subseq: inout [[Int]], nums: [Int], sum: Int, current: [Int], index: Int, currentSum: Int) {
        if index == nums.count {
            if sum == currentSum {
                subseq.append(current)
            }

            return
        }
        var current = current
        var currentSum = currentSum
        // take
        current.append(nums[index])
        currentSum += nums[index]
        subsequencesRecursion(subseq: &subseq, nums: nums, sum: sum, current: current, index: index + 1, currentSum: currentSum)
        // not take
        currentSum -= nums[index]
        current.remove(at: current.count - 1)
        subsequencesRecursion(subseq: &subseq, nums: nums, sum: sum, current: current, index: index + 1, currentSum: currentSum)
    }

    func subsequencesWithSumOnlyPositiveIntegers(nums: [Int], sum: Int) -> [[Int]] {
        //        print("--- Subsequences with only positive array---")
        var result = [[Int]]()

        subsequencesWithAllPositiveRecusrion(subseq: &result, nums: nums, sum: sum, index: 0, current: [])
        return result
    }

    func subsequencesWithAllPositiveRecusrion(subseq: inout [[Int]], nums: [Int], sum: Int, index: Int, current: [Int]) {
        if index == nums.count {
            if sum == 0 {
                subseq.append(current)
            }

            return
        }
        var current = current
        // take
        if sum >= nums[index] {
            current.append(nums[index])
            subsequencesWithAllPositiveRecusrion(subseq: &subseq, nums: nums, sum: sum - nums[index], index: index + 1, current: current)
            // not take
            current.remove(at: current.count - 1)
        }

        subsequencesWithAllPositiveRecusrion(subseq: &subseq, nums: nums, sum: sum, index: index + 1, current: current)
    }

    func subsequencesWithSumWithoutCurrentSum(nums: [Int], sum: Int) -> [[Int]] {
        //        print("--- Subsequences Without current sum---")
        var result = [[Int]]()

        subsequencesWithSumWithoutCurrentSumRecursion(subseq: &result, nums: nums, sum: sum, index: 0, current: [])
        return result
    }

    func subsequencesWithSumWithoutCurrentSumRecursion(subseq: inout [[Int]], nums: [Int], sum: Int, index: Int, current: [Int]) {
        if index == nums.count {
            if sum == 0 {
                subseq.append(current)
            }

            return
        }
        var current = current
        // take
        current.append(nums[index])
        subsequencesWithSumWithoutCurrentSumRecursion(subseq: &subseq, nums: nums, sum: sum - nums[index], index: index + 1, current: current)
        // not take
        current.remove(at: current.count - 1)
        subsequencesWithSumWithoutCurrentSumRecursion(subseq: &subseq, nums: nums, sum: sum, index: index + 1, current: current)
    }

    func subsequencesWithSumRecursionNested(nums: [Int], sum: Int) -> [[Int]] {
        //        print("--- Subsequences using recursion---")
        var result = [[Int]]()

        subsequences(index: 0, currentSum: 0, current: [])
        func subsequences(index: Int, currentSum: Int, current: [Int]) {
            if index == nums.count {
                if sum == currentSum {
                    result.append(current)
                }

                return
            }
            var current = current
            var currentSum = currentSum
            // take
            current.append(nums[index])
            currentSum += nums[index]
            subsequences(index: index + 1, currentSum: currentSum, current: current)
            // not take
            currentSum -= nums[index]
            current.remove(at: current.count - 1)
            subsequences(index: index + 1, currentSum: currentSum, current: current)
        }

        return result
    }

    func anyOneSubsequenceWithSumRecursion(nums: [Int], sum: Int) -> [[Int]] {
        //        print("---  Any one Subsequences using recursion---")
        var result = [[Int]]()

        subsequences(subseq: &result, nums: nums, sum: sum, index: 0, current: [], currentSum: 0)
        func subsequences(subseq: inout [[Int]], nums: [Int], sum: Int, index: Int, current: [Int], currentSum: Int) -> Bool {
            if index == nums.count {
                if sum == currentSum {
                    subseq.append(current)
                    return true
                }
                return false
            }
            var current = current
            var currentSum = currentSum
            current.append(nums[index])
            currentSum += nums[index]
            if subsequences(subseq: &subseq, nums: nums, sum: sum, index: index + 1, current: current, currentSum: currentSum) {
                return true
            }
            currentSum -= nums[index]
            current.remove(at: current.count - 1)
            if subsequences(subseq: &subseq, nums: nums, sum: sum, index: index + 1, current: current, currentSum: currentSum) {
                return true
            }
            return false
        }

        return result
    }

    func countSubsequencesWithSumRecusion(nums: [Int], sum: Int) -> Int {
        print("---  Subsequences count using recursion---")
        let result = countSubsequencesRecursion(nums: nums, sum: sum, index: 0, currentSum: 0)

        return result
    }

    func countSubsequencesRecursion(nums: [Int], sum: Int, index: Int, currentSum: Int) -> Int {
        if index == nums.count {
            return sum == currentSum ? 1 : 0
        }

        var currentSum = currentSum
        currentSum += nums[index]
        let left = countSubsequencesRecursion(nums: nums, sum: sum, index: index + 1, currentSum: currentSum)

        currentSum -= nums[index]
        let right = countSubsequencesRecursion(nums: nums, sum: sum, index: index + 1, currentSum: currentSum)

        return left + right
    }

    // Given an array of distinct integers num and target sum, find all the unique combinations where the sum of the combination is target. Numbers may be repeated
    func subsequencesWithPositiveNumbersRepeating(nums: [Int], sum: Int) -> [[Int]] {
        var subsets = [[Int]]()
        subsequencesWithPositiveNumbersRepeatingRecursion(subsequences: &subsets, nums: nums, sum: sum, index: 0, current: [])
        return subsets
    }

    func subsequencesWithPositiveNumbersRepeatingRecursion(subsequences: inout [[Int]], nums: [Int], sum: Int, index: Int, current: [Int]) {
        if index == nums.count {
            if sum == 0 {
                subsequences.append(current)
            }
            return
        }

        var current = current
        if sum >= nums[index] {
            current.append(nums[index])
            subsequencesWithPositiveNumbersRepeatingRecursion(subsequences: &subsequences, nums: nums, sum: sum - nums[index], index: index, current: current)
            current.remove(at: current.count - 1)
        }
        subsequencesWithPositiveNumbersRepeatingRecursion(subsequences: &subsequences, nums: nums, sum: sum, index: index + 1, current: current)
    }

    // Not working with negative
    func subsequencesWithNumbersRepeating(nums: [Int], sum: Int) -> [[Int]] {
        var subsets = [[Int]]()
        subsequencesWithNumbersRepeatingRecursion(subsequences: &subsets, nums: nums, sum: sum, index: 0, current: [], currentSum: 0)
        return subsets
    }

    func subsequencesWithNumbersRepeatingRecursion(subsequences: inout [[Int]], nums: [Int], sum: Int, index: Int, current: [Int], currentSum: Int) {
        if index == nums.count {
            if sum == currentSum {
                subsequences.append(current)
            }
            return
        }
        if sum - currentSum >= nums[index] {
            var currentSum = currentSum
            var current = current
            current.append(nums[index])
            currentSum += nums[index]
            subsequencesWithNumbersRepeatingRecursion(subsequences: &subsequences, nums: nums, sum: sum, index: index, current: current, currentSum: currentSum)
            current.remove(at: current.count - 1)
            currentSum -= nums[index]
        }

        subsequencesWithNumbersRepeatingRecursion(subsequences: &subsequences, nums: nums, sum: sum, index: index + 1, current: current, currentSum: currentSum)
    }

    // Given an array of integers num and target sum, find all the unique combinations where the sum of the combination is target. Combinations should be unique
    /*
     1. Ex1 nums = [10, 1, 2, 7, 6, 1, 5], sum = 8
     Output - [
     [1, 1, 6],
     [1, 2, 5],
     [1, 7],
     [2, 6]
     ]
     2. Ex1 nums = [2, 5, 2, 1, 2], sum = 5
     Output - [
     [1, 2, 2],
     [5]
     ]
     3. nums = [1, 1, 1, 2, 2], sum = 4
     */
    // Brute force solution will be using using solution for repeating numbers and use set

    // TC - 2^n * k
    // SC - x * k(space for single subset)
    // For soring - nlogn
    func subsequenceUniqueCombinationsForGivenSumLoop(nums: [Int], sum: Int) -> [[Int]] {
        var result = [[Int]]()
        let nums = nums.sorted()
        subsequenceUniqueCombinationsForGivenSumLoopRecursion(result: &result, nums: nums, sum: sum, current: [], index: 0)
        return result

    }

    func subsequenceUniqueCombinationsForGivenSumLoopRecursion(result: inout [[Int]], nums: [Int], sum: Int, current: [Int], index: Int) {
        if sum == 0 {
            result.append(current)
            return
        }
        for i in index..<nums.count {
            if i > index && nums[i] == nums[i - 1] {
                continue
            }
            if nums[i] > sum {
                break
            }
            var current = current
            current.append(nums[i])
            subsequenceUniqueCombinationsForGivenSumLoopRecursion(result: &result, nums: nums, sum: sum - nums[i], current: current, index: i + 1)
            current.remove(at: current.count - 1)
        }
    }
    /*
     Given an array of n integers, print sum of all subsets in it. Output should be in increasing order
     nums = [2, 3]
     Output - [0, 2, 3, 5]
     */

    // TC - 2^n + 2^n log (2^n) + recursive calls

    func subsequencesSum(nums: [Int]) {
        var result = [Int]()
        subsequencesSumRecursion(result: &result, nums: nums, index: 0, currentSum: 0)
    }

    func subsequencesSumRecursion(result: inout [Int], nums: [Int], index: Int, currentSum: Int) {
        if index == nums.count {
            result.append(currentSum)
            return
        }

        // Pick
        subsequencesSumRecursion(result: &result, nums: nums, index: index + 1, currentSum: currentSum + nums[index])
        // Not pick
        subsequencesSumRecursion(result: &result, nums: nums, index: index + 1, currentSum: currentSum)
    }

    /*
     Given an array of n integers that may contain duplicates, return all possible subsets(power set). Subsets should not contain any duplicate.
     Solution can be in any order
     nums = [1, 2, 2]
     Output - [[], [1], [2], [1, 2], [2, 2], [1, 2, 2]
     */

    // TC - 2^n * n(Adding subsets in result)
    // SC - 2^n * k (avg length of subset)
    // Auxillary space complexity (n)
    func subsequencesUniqueCombinationsLoop(nums: [Int]) {
        let nums = nums.sorted()
        var result = [[Int]]()
        subsequencesUniqueCombinationsLoopRecursion(result: &result, nums: nums, index: 0, current: [])
    }

    func subsequencesUniqueCombinationsLoopRecursion(result: inout [[Int]], nums: [Int], index: Int, current: [Int]) {
        result.append(current)

        for i in index..<nums.count {
            if i > index && nums[i] == nums[i - 1] {
                continue
            }
            var current = current
            current.append(nums[i])
            subsequencesUniqueCombinationsLoopRecursion(result: &result, nums: nums, index: i + 1, current: current)
            current.remove(at: current.count - 1)
        }
    }

    /*
     Given an array of n distinct integers , return all possible permutations.
     Solution can be in any order
     nums = [1, 2, 3]
     Output - [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]

     nums = [0, 1]
     Output - [[0, 1], [1, 0]]

     nums = [1]
     Output - [1]
     */

    // TC - n * n!
    // SC - n + n
    func perumationMap(nums: [Int]) {
        var result = [[Int]]()
        permuationRecursionMap(result: &result, nums: nums, current: [], frequency: [Int: Bool]())
    }

    func permuationRecursionMap(result: inout [[Int]], nums: [Int], current: [Int], frequency: [Int: Bool]) {
        if current.count == nums.count {
            result.append(current)
            return
        }

        for i in 0..<nums.count {
            if frequency[i] == false {
                var frequency = frequency
                var current = current
                current.append(nums[i])
                frequency[i] = true
                permuationRecursionMap(result: &result, nums: nums, current: current, frequency: frequency)
                frequency[i] = false
                current.remove(at: current.count - 1)
            }
        }
    }

    // TC - n * n!
    // SC - n
    func perumations(nums: [Int]) -> [[Int]] {
        var result = [[Int]]()
        var nums = nums
        permuationRecursion(result: &result, nums: nums, index: 0, current: [])
        return result
    }

    /*
     Before first swap - i - 0, index - 0, nums - [1, 2, 3]
     After first swap - i - 0, index - 0, nums - [1, 2, 3]
     Before first swap - i - 1, index - 1, nums - [1, 2, 3]
     After first swap - i - 1, index - 1, nums - [1, 2, 3]
     Before first swap - i - 2, index - 2, nums - [1, 2, 3]
     After first swap - i - 2, index - 2, nums - [1, 2, 3]
     Index  num same - [1, 2, 3]
     Before second swap - i - 2, index - 2, nums - [1, 2, 3]
     After second swap - i - 2, index - 2, nums - [1, 2, 3]
     Before second swap - i - 1, index - 1, nums - [1, 2, 3]
     After second swap - i - 1, index - 1, nums - [1, 2, 3]
     Before first swap - i - 2, index - 1, nums - [1, 2, 3]
     After first swap - i - 2, index - 1, nums - [1, 3, 2]
     Before first swap - i - 2, index - 2, nums - [1, 3, 2]
     After first swap - i - 2, index - 2, nums - [1, 3, 2]
     Index  num same - [1, 3, 2]
     Before second swap - i - 2, index - 2, nums - [1, 3, 2]
     After second swap - i - 2, index - 2, nums - [1, 3, 2]
     Before second swap - i - 2, index - 1, nums - [1, 3, 2]
     After second swap - i - 2, index - 1, nums - [1, 2, 3]
     Before second swap - i - 0, index - 0, nums - [1, 2, 3]
     After second swap - i - 0, index - 0, nums - [1, 2, 3]
     Before first swap - i - 1, index - 0, nums - [1, 2, 3]
     After first swap - i - 1, index - 0, nums - [2, 1, 3]
     Before first swap - i - 1, index - 1, nums - [2, 1, 3]
     After first swap - i - 1, index - 1, nums - [2, 1, 3]
     Before first swap - i - 2, index - 2, nums - [2, 1, 3]
     After first swap - i - 2, index - 2, nums - [2, 1, 3]
     Index  num same - [2, 1, 3]
     Before second swap - i - 2, index - 2, nums - [2, 1, 3]
     After second swap - i - 2, index - 2, nums - [2, 1, 3]
     Before second swap - i - 1, index - 1, nums - [2, 1, 3]
     After second swap - i - 1, index - 1, nums - [2, 1, 3]
     Before first swap - i - 2, index - 1, nums - [2, 1, 3]
     After first swap - i - 2, index - 1, nums - [2, 3, 1]
     Before first swap - i - 2, index - 2, nums - [2, 3, 1]
     After first swap - i - 2, index - 2, nums - [2, 3, 1]
     Index  num same - [2, 3, 1]
     Before second swap - i - 2, index - 2, nums - [2, 3, 1]
     After second swap - i - 2, index - 2, nums - [2, 3, 1]
     Before second swap - i - 2, index - 1, nums - [2, 3, 1]
     After second swap - i - 2, index - 1, nums - [2, 1, 3]
     Before second swap - i - 1, index - 0, nums - [2, 1, 3]
     After second swap - i - 1, index - 0, nums - [1, 2, 3]
     Before first swap - i - 2, index - 0, nums - [1, 2, 3]
     After first swap - i - 2, index - 0, nums - [3, 2, 1]
     Before first swap - i - 1, index - 1, nums - [3, 2, 1]
     After first swap - i - 1, index - 1, nums - [3, 2, 1]
     Before first swap - i - 2, index - 2, nums - [3, 2, 1]
     After first swap - i - 2, index - 2, nums - [3, 2, 1]
     Index  num same - [3, 2, 1]
     Before second swap - i - 2, index - 2, nums - [3, 2, 1]
     After second swap - i - 2, index - 2, nums - [3, 2, 1]
     Before second swap - i - 1, index - 1, nums - [3, 2, 1]
     After second swap - i - 1, index - 1, nums - [3, 2, 1]
     Before first swap - i - 2, index - 1, nums - [3, 2, 1]
     After first swap - i - 2, index - 1, nums - [3, 1, 2]
     Before first swap - i - 2, index - 2, nums - [3, 1, 2]
     After first swap - i - 2, index - 2, nums - [3, 1, 2]
     Index  num same - [3, 1, 2]
     Before second swap - i - 2, index - 2, nums - [3, 1, 2]
     After second swap - i - 2, index - 2, nums - [3, 1, 2]
     Before second swap - i - 2, index - 1, nums - [3, 1, 2]
     After second swap - i - 2, index - 1, nums - [3, 2, 1]
     Before second swap - i - 2, index - 0, nums - [3, 2, 1]
     After second swap - i - 2, index - 0, nums - [1, 2, 3]
     Permutations recursoion - [1, 2, 3] -  [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 2, 1], [3, 1, 2]]
     */
    func permuationRecursion(result: inout [[Int]], nums: [Int], index: Int, current: [Int]) {
        if index == nums.count {
            print(" Index  num same - \(nums)")
            result.append(nums)
            return
        }

        for i in index..<nums.count {
            var nums = nums
            print("Before first swap - i - \(i), index - \(index), nums - \(nums)")
            nums.swapAt(i, index)
            print("After first swap - i - \(i), index - \(index), nums - \(nums)")
            permuationRecursion(result: &result, nums: nums, index: index + 1, current: [])
            print("Before second swap - i - \(i), index - \(index), nums - \(nums)")
            nums.swapAt(i, index)
            print("After second swap - i - \(i), index - \(index), nums - \(nums)")
        }
    }

    // Place N queens on a n x n chessboard such that no two queens attack each othwe
    // Given an integer n, return all distinct solutions to the n-queens puzzle
    // Input n=4
    // Output: [[".Q..", "...Q", "Q...", "..Q."], ["..Q.", "Q...", "...Q", ..Q.]

    func nQueensNotOptimal(boardSize: Int) {
        var initialRowData = [String](repeating: ".", count: 4)
        var board = [[String]](repeating: initialRowData, count: 4)
        var result = [[String]]()
    }

    //Time Complexity: O(n*n!)
    //Auxiliary Space: O(n2)
    func solveNQueensRecursionNotOptimal(result: inout [[String]], board: inout [[String]], column: Int) {
        if column == board.count {
            result.append(contentsOf: board)
            return
        }
        for row in 0..<board.count {
            if isQueenSafeNotOptimal(board: &board, row: row, column: column) {
                board[row][column] = "Q"
                solveNQueensRecursionNotOptimal(result: &result, board: &board, column: column + 1)
                board[row][column] = "."
            }
        }
    }

    // not optimal
    func isQueenSafeNotOptimal(board: inout [[String]], row: Int, column: Int) -> Bool {
        var  duplicateColumn = column
        var duplicateRow = row

        // Check upper diagonal
        while duplicateColumn >= 0 && duplicateRow >= 0 {
            if board[duplicateRow][duplicateColumn] == "Q" {
                return false
            }
            duplicateColumn -= 1
            duplicateRow -= 1
        }

        // Check horizontal
        duplicateColumn = column
        duplicateRow = row

        while duplicateColumn >= 0 {
            if board[duplicateRow][duplicateColumn] == "Q" {
                return false
            }
            duplicateColumn -= 1
        }

        // Check upper diagonal
        duplicateColumn = column
        duplicateRow = row

        while duplicateColumn >= 0 && duplicateRow < board.count {
            if board[duplicateRow][duplicateColumn] == "Q" {
                return false
            }
            duplicateColumn -= 1
            duplicateRow += 1
        }

        return true
    }

    //Time Complexity: O(n!)
    //Auxiliary Space: O(n)
    // Input n=4
    // Output: [[".Q..", "...Q", "Q...", "..Q."], ["..Q.", "Q...", "...Q", ..Q.]
    func nQueensOptimal(boardSize: Int) -> [[String]] {
        var initialRowData = [String](repeating: ".", count: 4)
        var board = [[String]](repeating: initialRowData, count: 4)
        var result = [[String]]()
        var leftRow = [Bool](repeating: false, count: boardSize)
        var lowerDiagonal = [Bool](repeating: false, count: 2 * boardSize - 1)
        var upperDiagonal = [Bool](repeating: false, count: 2 * boardSize - 1)
        solveNQueensRecursion(result: &result, board: &board, column: 0, leftRow: &leftRow, lowerDiagonal: &lowerDiagonal, upperDiagonal: &upperDiagonal)
        return result
    }

    func solveNQueensRecursion(
        result: inout [[String]],
        board: inout [[String]],
        column: Int,
        leftRow: inout [Bool],
        lowerDiagonal: inout [Bool],
        upperDiagonal: inout [Bool]
    ) {
        if column == board.count {
            result.append(contentsOf: board)
            return
        }
        for row in 0..<board.count {
            if !leftRow[row] && !lowerDiagonal[row + column] && !upperDiagonal[board.count - 1 + column - row] {
                board[row][column] = "Q"
                leftRow[row] = true
                lowerDiagonal[row + column] = true
                upperDiagonal[board.count - 1 + column - row] = true
                solveNQueensRecursion(
                    result: &result,
                    board: &board,
                    column: column,
                    leftRow: &leftRow,
                    lowerDiagonal: &lowerDiagonal,
                    upperDiagonal: &upperDiagonal
                )
                board[row][column] = "."
                leftRow[row] = false
                lowerDiagonal[row + column] = false
                upperDiagonal[board.count - 1 + column - row] = false
            }
        }
    }

    // The set [1, 2, ..n] contains n! unique permutations
    // Given n and k, return kth permuation sequence
    // Ex - 1, Input n = 3, k = 3, Output - "213"
    // Ex - 2, Input n = 4, k = 9, Output - "2314"
    // Ex - 3, Input n = 3, k = 1, Output - "123"

    // Check it's time complexity
    // SC - O(n)
    func kthPermuationSequenceFor(number: Int, kth: Int) -> Int {
        var fact = 1
        var numbers = [Int]()
        for i in 1..<number {
            fact *= i
            numbers.append(i)
        }
        numbers.append(number)
        var kth = kth - 1
        let multiplier = 10
        var result: Int = 0
        while true {
            let index = kth / fact
            result = (result * multiplier) + numbers[index]
            numbers.remove(at: index)
            if numbers.isEmpty {
                break
            }
            kth = kth % fact
            fact /= numbers.count
        }
        return result
    }

    /*
     Consider a rat placed at position (0, 0) in an n x n square matrix mat. The rat's goal is to reach the destination at position (n-1, n-1). The rat can move in four possible directions: 'U'(up), 'D'(down), 'L' (left), 'R' (right).

     The matrix contains only two possible values:

     0: A blocked cell through which the rat cannot travel.
     1: A free cell that the rat can pass through.
     Note: In a path, no cell can be visited more than one time. If the source cell is 0, the rat cannot move to any other cell. In case of no path, return an empty list.+

     The task is to find all possible paths the rat can take to reach the destination, starting from (0, 0) and ending at (n-1, n-1), under the condition that the rat cannot revisit any cell along the same path. Furthermore, the rat can only move to adjacent cells that are within the bounds of the matrix and not blocked.

     Return the final result vector in lexicographically smallest order.

     Examples:

     Input: mat[][] = [[1, 0, 0, 0], [1, 1, 0, 1], [1, 1, 0, 0], [0, 1, 1, 1]]
     Output: ["DDRDRR", "DRDDRR"]
     Explanation: The rat can reach the destination at (3, 3) from (0, 0) by two paths - DRDDRR and DDRDRR, when printed in sorted order we get DDRDRR DRDDRR.
     Input: mat[][] = [[1, 0], [1, 0]]
     Output: []
     */

    func ratInMaze(maze: inout [[Int]]) {

        let xDirection = [0, -1, 1, 0]
        let yDirection = [1, 0, 0, -1]
    }

    func ratInMazeRecursuion(
        maze: inout [[Int]],
        answer: inout [String],
        current: String,
        visited: inout [[Bool]],
        row: Int,
        column: Int,
        xDirection: [Int],
        yDirection: [Int]
    ) {
        let maxRowCount = maze.count
        let maxColumnCount = maze[row].count
        if row == maxRowCount - 1 && column == maxColumnCount - 1 {
            answer.append(current)
            return
        }
        let order = "DLRU"
        for index in 0..<4 {
            let nextRow = row + xDirection[index]
            let nextColum = column + yDirection[index]
            if (0..<maxRowCount).contains(nextRow) &&
                (0..<maxColumnCount).contains(nextColum) &&
                !visited[nextRow][nextColum] &&
                maze[nextRow][nextColum] == 1 {
                visited[row][column] = true
                let currentOrder = current + order[index]
                ratInMazeRecursuion(
                    maze: &maze,
                    answer: &answer,
                    current: currentOrder,
                    visited: &visited,
                    row: nextRow,
                    column: nextColum,
                    xDirection: xDirection,
                    yDirection: yDirection
                )
                visited[row][column] = false
            }
        }

    }

    /*
     You are given an integer array nums and a positive integer k.

     Return the number of subarrays where the maximum element of nums appears at least k times in that subarray.

     A subarray is a contiguous sequence of elements within an array.

      

     Example 1:

     Input: nums = [1,3,2,3,3], k = 2
     Output: 6
     Explanation: The subarrays that contain the element 3 at least 2 times are: [1,3,2,3], [1,3,2,3,3], [3,2,3], [3,2,3,3], [2,3,3] and [3,3].
     Example 2:

     Input: nums = [1,4,2,1], k = 3
     Output: 0
     Explanation: No subarray contains the element 4 at least 3 times.
      

     Constraints:

     1 <= nums.length <= 105
     1 <= nums[i] <= 106
     1 <= k <= 105
     */
    
    // O(n^2)
    func countSubarraysUnoptimized(nums: [Int], k: Int) -> Int {
        let count = nums.count
        var result = 0
        let max = nums.max()
        
        
        for i in 0..<count  {
            var maxCount = 0
            if nums[i] == max {
                maxCount += 1
            }
            if maxCount == k {
                result += count - i
                continue
            }
            for j in i + 1..<count {
                if nums[j] == max {
                    maxCount += 1
                }
                if maxCount == k {
                    result += count - j
                    break
                }
            }
        }
        return result
    }
    
    // O(n)
    func countSubarraysOptimized(nums: [Int], k: Int) -> Int {
        let count = nums.count
        var result = 0
        let max = nums.max()
        var left = 0
        var right = 0
        var maxCount = 0
        while right  < count {
            if nums[right] == max {
                maxCount += 1
            }
            while maxCount == k {
                if nums[left] == max {
                    maxCount -= 1
                }
                left += 1
            }
            result += left
            right += 1
        }
        
        
        return result
    }
    
    /*
    Y ou are given an array of 0s and 1s in random order. Segregate 0s on left side and 1s on right side of the array [Basically you have to sort the array]. Traverse array only once.

     Input :  [0, 1, 0, 1, 0, 0, 1, 1, 1, 0]
     Output :  [0, 0, 0, 0, 0, 1, 1, 1, 1, 1]


     Input :  [0, 1, 0]
     Output :  [0, 0, 1]


     Input :  [1, 1]
     Output :  [1, 1]


     Input :  [0]
     Output :  [0]
     */
    func sortZerosAndOnes(nums: inout [Int]) {
        var left = 0
        var right = nums.count - 1
        
        while left < right {
            while nums[left] == 0 {
                left += 1
            }
            while nums[right] == 1 {
                right -= 1
            }
            if left < right {
                nums.swapAt(left, right)
                left += 1
                right -= 1
            }
        }
        
    }
    // Count inversions in array
    // Given an array of integers find numbers of pairs where left is greater than right
    // Example - [5, 3, 2, 4, 1]
    // Answer - [[5,3], [5, 2], [5, 4], [5, 1], [3, 2], [3, 1], [4, 1]]
    // Brute force using two loops O(N^2)

    // Reverse pairs
    // Maximum product subarray
    
    /*
     Given an array nums with n objects colored red, white, or blue, sort them in-place so that objects of the same color are adjacent, with the colors in the order red, white, and blue.

     We will use the integers 0, 1, and 2 to represent the color red, white, and blue, respectively.

     You must solve this problem without using the library's sort function.

      

     Example 1:

     Input: nums = [2,0,2,1,1,0]
     Output: [0,0,1,1,2,2]
     Example 2:

     Input: nums = [2,0,1]
     Output: [0,1,2]
      

     Constraints:

     n == nums.length
     1 <= n <= 300
     nums[i] is either 0, 1, or 2.
      

     Follow up: Could you come up with a one-pass algorithm using only constant extra space?
     */
    
    // O(n), Naive approach sorting O(nlogn)
    func sortColors(_ nums: inout [Int]) {
        var low = 0
        var mid = 0
        var high = nums.count - 1
        while mid <= high {
            if nums[mid] == 0 {
                nums.swapAt(mid, low)
                mid += 1
                low += 1
            } else if nums[mid] == 1 {
                mid += 1
            } else {
                nums.swapAt(mid, high)
                mid += 1
                high -= 1
            }
        }
    }
}
