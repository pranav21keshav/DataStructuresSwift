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
        var missingPositive1 = [1, 2, 0]
        var missingPositive2 = [3, 4, -1, 1]
        var missingPositive3 = [7, 8, 9, 11, 12]
        print("missing postive visible array - \(missingPositive1) - \(firstMissingPositiveExtraArray(nums: missingPositive1))")
        print("missing postive visible array - \(missingPositive2) - \(firstMissingPositiveExtraArray(nums: missingPositive2))")
        print("missing postive visible array - \(missingPositive3) - \(firstMissingPositiveExtraArray(nums: missingPositive3))")
        print("missing postive cycle sort - \(missingPositive1) - \(firstMissingPositiveCycleSort(nums: &missingPositive1))")
        print("missing postive cycle sort - \(missingPositive2) - \(firstMissingPositiveCycleSort(nums: &missingPositive2))")
        print("missing postive cycle sort - \(missingPositive3) - \(firstMissingPositiveCycleSort(nums: &missingPositive3))")
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
        
        for i in 0..<count {
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
        while right < count {
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

    /*
     Given an integer array nums, return an array answer such that answer[i] is equal to the product of all the elements of nums except nums[i].

     The product of any prefix or suffix of nums is guaranteed to fit in a 32-bit integer.

     You must write an algorithm that runs in O(n) time and without using the division operation.



     Example 1:

     Input: nums = [1,2,3,4]
     Output: [24,12,8,6]
     Example 2:

     Input: nums = [-1,1,0,-3,3]
     Output: [0,0,9,0,0]


     Constraints:

     2 <= nums.length <= 105
     -30 <= nums[i] <= 30
     The input is generated such that answer[i] is guaranteed to fit in a 32-bit integer.

     */

    func productExceptSelf(_ nums: [Int]) -> [Int] {
        var result = Array(repeating: 0, count: nums.count)
        var zeroes = 0
        var index = -1
        var product = 1
        for i in 0..<nums.count {
            if nums[i] == 0 {
                zeroes += 1
                index = i
                if zeroes > 1 {
                    return result
                }
                
            } else {
                product *= nums[i]
            }
        }
        
        if zeroes == 1 {
            result[index] = product
        } else {
            for i in 0..<nums.count {
                result[i] = product / nums[i]
            }
        }
        
        return result
        
    }

    /*
     Given an integer array nums, rotate the array to the right by k steps, where k is non-negative.
     The time complexity of the solution should be O(n)


     Example 1:

     Input: nums = [1,2,3,4,5,6,7], k = 3
     Output: [5,6,7,1,2,3,4]
     Explanation:
     rotate 1 steps to the right: [7,1,2,3,4,5,6]
     rotate 2 steps to the right: [6,7,1,2,3,4,5]
     rotate 3 steps to the right: [5,6,7,1,2,3,4]
     Example 2:

     Input: nums = [-1,-100,3,99], k = 2
     Output: [3,99,-1,-100]
     Explanation:
     rotate 1 steps to the right: [99,-1,-100,3]
     rotate 2 steps to the right: [3,99,-1,-100]


     Constraints:

     1 <= nums.length <= 105
     -231 <= nums[i] <= 231 - 1
     0 <= k <= 105
     */

    // TC - O(n)
    // SC - O(1)
    func rotateReverse(_ nums: inout [Int], _ k: Int) {
        let count = nums.count
        let k = k % count
        guard k != 0 else {
            return
        }
        reverse(nums: &nums, start: 0, end: count - 1)
        reverse(nums: &nums, start: 0, end: k - 1)
        reverse(nums: &nums, start: k, end: count - 1)

    }

    func reverse(nums: inout [Int], start: Int, end: Int) {
        var left = start
        var right = end
        while left < right {
            let temp = nums[left]
            nums[left] = nums[right]
            nums[right] = temp
            left += 1
            right -= 1
        }
    }

    func rotate(_ nums: inout [Int], _ k: Int) {
        
        let count = nums.count
        let k = k % count
        let cycles = gcd(a: count, b: k)
        guard cycles != 0 else {
            return
        }
        for i in 0..<cycles {
            var currentIndex = i
            var currentElement = nums[i]
            var nextIndex: Int
            while true {
                nextIndex = (currentIndex + k) % count
                let nextElement = nums[nextIndex]
                nums[nextIndex] = currentElement
                currentElement = nextElement
                currentIndex = nextIndex
                if nextIndex == i {
                    break
                }
            }
        }
        
    }
    
    func gcd(a: Int, b: Int) -> Int {
        var b = b
        var a = a
        while b != 0 {
            let temp = b
            b = a % b
            a = temp
        }
        return a
    }

    /*
     Given an unsorted integer array nums. Return the smallest positive integer that is not present in nums.

     You must implement an algorithm that runs in O(n) time and uses O(1) auxiliary space.



     Example 1:

     Input: nums = [1,2,0]
     Output: 3
     Explanation: The numbers in the range [1,2] are all in the array.
     Example 2:

     Input: nums = [3,4,-1,1]
     Output: 2
     Explanation: 1 is in the array but 2 is missing.
     Example 3:

     Input: nums = [7,8,9,11,12]
     Output: 1
     Explanation: The smallest positive integer 1 is missing.


     Constraints:

     1 <= nums.length <= 105
     -231 <= nums[i] <= 231 - 1

     Solution:
     1.
     Brute Force - sort and check -
     TC - O(n Log n)
     SC - O(1) is input array is used other wise O(1)

     2. Use visible array to store which number from 1 to n is present using flag
     TC - O(n)
     SC - O(n)

     3. Use cycle sort to modify array in place
     TC - O(n)
     SC - O(1)

     */
    func firstMissingPositiveExtraArray(nums: [Int]) -> Int {
        let count = nums.count
        var visibleArray = Array(repeating: false, count: count)
        for num in nums {
            if num > 0 && num <= count {
                visibleArray[num - 1] = true
            }
        }
        for i in 1...count {
            if !visibleArray[i - 1] {
                return i
            }
        }
        return count + 1

    }

    func firstMissingPositiveCycleSort(nums: inout [Int]) -> Int {
        let count = nums.count
        var loopCounter = 1
        while loopCounter < count {
            let correctIndex = nums[loopCounter] - 1
            if nums[loopCounter] > 0 && nums[loopCounter] <= count && nums[loopCounter] != nums[correctIndex] {
                nums.swapAt(loopCounter, correctIndex)
            } else {
                loopCounter += 1
            }
        }
        for i in 1...count {
            if nums[i - 1] != i {
                return i
            }
        }
        return count + 1

    }
}
