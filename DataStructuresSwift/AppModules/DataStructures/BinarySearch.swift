//
//  BinarySearch.swift
//  DataStructuresSwift
//
//  Created by Pranav pravakar on 28/07/25.
//  Copyright © 2025 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation
// swiftlint:disable file_length
struct BinarySearch<T: Comparable> {
    init() {
        let array = [2, 2]
        let target = 3
        print("Search in range - array - \(array), target - \(target) - \(searchRange(array, target))")

        var gasStations = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        print(" Min distance gas station - \(gasStations), with extra - \(9) is - \(minmaxGasDistPQ(gasStations, 9))")
        print(" Min distance gas station - \(gasStations), with extra - \(9) is - \(minmaxGasDistBS(gasStations, 9))")
    }

    // TC - O (log n)
    // Lower bound - Smallest Index where array[index] >= n
    func lowerBound(array: [T], target: T) -> Int {
        var low = array.startIndex
        var high = array.endIndex
        var result = -1
        while low <= high {
            let mid = low + (high - low) / 2
            if array[mid] >= target {
                result = mid
                high = mid - 1
            } else {
                low = mid + 1
            }
        }
        return result
    }

    // Upper bound - Smallest Index where array[index] > n
    // TC - O (log n)
    func upperBound(array: [T], target: T) -> Int {
        var low = array.startIndex
        var high = array.endIndex - 1
        var result = -1
        while low <= high {
            let mid = low + (high - low) / 2
            if array[mid] > target {
                result = mid
                high = mid - 1
            } else {
                low = mid + 1
            }
        }
        return result
    }

    // Search insert position - same as lower bound
    // floor and ceil in array - floor (largest number <= x), ceil (largest number >= x)
    // ceil - same as lower bound

    func floor(array: [T], target: T) -> T {
        var low = array.startIndex
        var high = array.endIndex - 1
        var result = -1
        while low <= high {
            let mid = low + (high - low) / 2
            if array[mid] <= target {
                result = mid
                low = mid + 1
            } else {
                high = mid - 1
            }
        }
        if result != -1 {
            return array[result]
        }
        return target
    }

    /*
     Given an array of integers nums sorted in non-decreasing order, find the starting and ending position of a given target value.

     If target is not found in the array, return [-1, -1].

     You must write an algorithm with O(log n) runtime complexity.



     Example 1:

     Input: nums = [5,7,7,8,8,10], target = 8
     Output: [3,4]
     Example 2:

     Input: nums = [5,7,7,8,8,10], target = 6
     Output: [-1,-1]
     Example 3:

     Input: nums = [], target = 0
     Output: [-1,-1]


     Constraints:

     0 <= nums.length <= 105
     -109 <= nums[i] <= 109
     nums is a non-decreasing array.
     -109 <= target <= 109
     */

    func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
        let lowerBound = lowerBound(nums: nums, target: target)
        if lowerBound == nums.count || nums[lowerBound] != target {
            return [-1, -1]
        }
        let uppperBound = upperBound(nums: nums, target: target)
        return [lowerBound, uppperBound - 1]

    }

    func lowerBound(nums: [Int], target: Int) -> Int {
        var result = nums.count
        var low = nums.startIndex
        var high = nums.endIndex - 1
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

    func upperBound(nums: [Int], target: Int) -> Int {
        var result = nums.count
        var low = nums.startIndex
        var high = nums.endIndex - 1
        while low <= high {
            let mid = low + (high - low) / 2
            if nums[mid] > target {
                result = mid
                high = mid - 1
            } else {
                low = mid + 1
            }
        }
        return result
    }

    /*

     278. First Bad Version
    
     You are a product manager and currently leading a team to develop a new product. Unfortunately, the latest version of your product fails the quality check. Since each version is developed based on the previous version, all the versions after a bad version are also bad.

     Suppose you have n versions [1, 2, ..., n] and you want to find out the first bad one, which causes all the following ones to be bad.

     You are given an API bool isBadVersion(version) which returns whether version is bad. Implement a function to find the first bad version. You should minimize the number of calls to the API.



     Example 1:

     Input: n = 5, bad = 4
     Output: 4
     Explanation:
     call isBadVersion(3) -> false
     call isBadVersion(5) -> true
     call isBadVersion(4) -> true
     Then 4 is the first bad version.
     Example 2:

     Input: n = 1, bad = 1
     Output: 1


     Constraints:

     1 <= bad <= n <= 231 - 1


     */

    /*
     34. Find First and Last Position of Element in Sorted Array

     Given an array of integers nums sorted in non-decreasing order, find the starting and ending position of a given target value.

     If target is not found in the array, return [-1, -1].

     You must write an algorithm with O(log n) runtime complexity.



     Example 1:

     Input: nums = [5,7,7,8,8,10], target = 8
     Output: [3,4]
     Example 2:

     Input: nums = [5,7,7,8,8,10], target = 6
     Output: [-1,-1]
     Example 3:

     Input: nums = [], target = 0
     Output: [-1,-1]


     Constraints:

     0 <= nums.length <= 105
     -109 <= nums[i] <= 109
     nums is a non-decreasing array.
     -109 <= target <= 109
     */
    func searchRangeBS(_ nums: [Int], _ target: Int) -> [Int] {
        var range1 = -1
        var low = nums.startIndex
        var high = nums.endIndex - 1
        while low <= high {
            let mid = low + (high - low) / 2
            if nums[mid] == target {
                range1 = mid
                high = mid - 1
                
            } else if nums[mid] < target {
                low = mid + 1
            } else {
                high = mid - 1
            }
        }
        if range1 == -1 {
            return [-1, -1]
        }
        low = nums.startIndex
        high = nums.endIndex - 1
        var range2 = -1
        while low <= high {
            let mid = low + (high - low) / 2
            if nums[mid] == target {
                range2 = mid
                low = mid + 1
                
            } else if nums[mid] < target {
                low = mid + 1
            } else {
                high = mid - 1
            }
        }
        return [range1, range2]
    }

    /*
     33. Search in Rotated Sorted Array

     There is an integer array nums sorted in ascending order (with distinct values).

     Prior to being passed to your function, nums is possibly left rotated at an unknown index k (1 <= k < nums.length) such that the resulting array is [nums[k], nums[k+1], ..., nums[n-1], nums[0], nums[1], ..., nums[k-1]] (0-indexed). For example, [0,1,2,4,5,6,7] might be left rotated by 3 indices and become [4,5,6,7,0,1,2].

     Given the array nums after the possible rotation and an integer target, return the index of target if it is in nums, or -1 if it is not in nums.

     You must write an algorithm with O(log n) runtime complexity.



     Example 1:

     Input: nums = [4,5,6,7,0,1,2], target = 0
     Output: 4
     Example 2:

     Input: nums = [4,5,6,7,0,1,2], target = 3
     Output: -1
     Example 3:

     Input: nums = [1], target = 0
     Output: -1


     Constraints:

     1 <= nums.length <= 5000
     -104 <= nums[i] <= 104
     All values of nums are unique.
     nums is an ascending array that is possibly rotated.
     -104 <= target <= 104
     */

    func searchRotatedSorted(_ nums: [Int], _ target: Int) -> Int {
        var low = 0
        var high = nums.count - 1
        while low <= high {
            let mid = low + (high - low) / 2
            if nums[mid] == target {
                return mid
            }
            if nums[low] <= nums[mid] {
                if nums[low] <= target && target <= nums[mid] {
                    high = mid - 1
                } else {
                    low = mid + 1
                }
            } else {
                if nums[mid] <= target && target <= nums[high] {
                    low = mid + 1
                } else {
                    high = mid - 1
                }
            }
        }
        return -1
    }

    /*
     81. Search in Rotated Sorted Array II

     There is an integer array nums sorted in non-decreasing order (not necessarily with distinct values).

     Before being passed to your function, nums is rotated at an unknown pivot index k (0 <= k < nums.length) such that the resulting array is [nums[k], nums[k+1], ..., nums[n-1], nums[0], nums[1], ..., nums[k-1]] (0-indexed). For example, [0,1,2,4,4,4,5,6,6,7] might be rotated at pivot index 5 and become [4,5,6,6,7,0,1,2,4,4].

     Given the array nums after the rotation and an integer target, return true if target is in nums, or false if it is not in nums.

     You must decrease the overall operation steps as much as possible.



     Example 1:

     Input: nums = [2,5,6,0,0,1,2], target = 0
     Output: true
     Example 2:

     Input: nums = [2,5,6,0,0,1,2], target = 3
     Output: false


     Constraints:

     1 <= nums.length <= 5000
     -104 <= nums[i] <= 104
     nums is guaranteed to be rotated at some pivot.
     -104 <= target <= 104


     Follow up: This problem is similar to Search in Rotated Sorted Array, but nums may contain duplicates. Would this affect the runtime complexity? How and why?
     */
    func searchRotatedSortedII(_ nums: [Int], _ target: Int) -> Bool {
        var low = 0
        var high = nums.count - 1
        while low <= high {
            let mid = low + (high - low) / 2
            if nums[mid] == target {
                return true
            }
            if nums[low] == nums[mid] && nums[mid] == nums[high] {
                low += 1
                high -= 1
                continue
            }
            if nums[low] <= nums[mid] {
                if nums[low] <= target && target <= nums[mid] {
                    high = mid - 1
                } else {
                    low = mid + 1
                }
            } else {
                if nums[mid] <= target && target <= nums[high] {
                    low = mid + 1
                } else {
                    high = mid - 1
                }
            }
        }
        return false
    }

    /*
     153. Find Minimum in Rotated Sorted Array

     Suppose an array of length n sorted in ascending order is rotated between 1 and n times. For example, the array nums = [0,1,2,4,5,6,7] might become:

     [4,5,6,7,0,1,2] if it was rotated 4 times.
     [0,1,2,4,5,6,7] if it was rotated 7 times.
     Notice that rotating an array [a[0], a[1], a[2], ..., a[n-1]] 1 time results in the array [a[n-1], a[0], a[1], a[2], ..., a[n-2]].

     Given the sorted rotated array nums of unique elements, return the minimum element of this array.

     You must write an algorithm that runs in O(log n) time.



     Example 1:

     Input: nums = [3,4,5,1,2]
     Output: 1
     Explanation: The original array was [1,2,3,4,5] rotated 3 times.
     Example 2:

     Input: nums = [4,5,6,7,0,1,2]
     Output: 0
     Explanation: The original array was [0,1,2,4,5,6,7] and it was rotated 4 times.
     Example 3:

     Input: nums = [11,13,15,17]
     Output: 11
     Explanation: The original array was [11,13,15,17] and it was rotated 4 times.


     Constraints:

     n == nums.length
     1 <= n <= 5000
     -5000 <= nums[i] <= 5000
     All the integers of nums are unique.
     nums is sorted and rotated between 1 and n times.
     */

    func findMinRotatedSortedArray(_ nums: [Int]) -> Int {
        var low = 0
        var high = nums.count - 1
        while low < high {
            if nums[low] < nums[high] {
                return nums[low]
            }
            let mid = (low + high) / 2
            if nums[mid] > nums[high] {
                low = mid + 1
            } else {
                high = mid
            }
        }
        return nums[low]
    }

    func findMinRotatedSortedArrayII(_ nums: [Int]) -> Int {
        var low = 0
        var high = nums.count - 1
        var answer = Int.max
        while low <= high {
            if nums[low] <= nums[high] {
                return min(answer, nums[low])
            }
            let mid = (low + high) / 2
            if nums[low] <= nums[mid] {
                answer = min(answer, nums[low])
                low = mid + 1
            } else {
                answer = min(answer, nums[mid])
                high = mid - 1
            }
        }
        return answer
    }

    /*
     540. Single Element in a Sorted Array

     You are given a sorted array consisting of only integers where every element appears exactly twice, except for one element which appears exactly once.

     Return the single element that appears only once.

     Your solution must run in O(log n) time and O(1) space.



     Example 1:

     Input: nums = [1,1,2,3,3,4,4,8,8]
     Output: 2
     Example 2:

     Input: nums = [3,3,7,7,10,11,11]
     Output: 10


     Constraints:

     1 <= nums.length <= 105
     0 <= nums[i] <= 105
     */

    func singleNonDuplicate(_ nums: [Int]) -> Int {
        if nums.count == 1 {
            return nums[0]
        }
        if nums[0] != nums[1] {
            return nums[0]
        }
        let count = nums.count
        if nums[count - 2] != nums[count - 1] {
            return nums[count - 1]
        }
        var low = 1
        var high = count - 2
        while low <= high {
            let mid = low + (high - low) / 2
            if nums[mid - 1] != nums[mid] && nums[mid] != nums[mid + 1] {
                return nums[mid]
            }
            if (mid % 2 == 0 && nums[mid] == nums[mid + 1]) || (mid % 2 == 1 && nums[mid] == nums[mid - 1]) {
                low = mid + 1
            } else {
                high = mid - 1
            }
        }
        return -1
    }

    /*
     162. Find Peak Element
     A peak element is an element that is strictly greater than its neighbors.

     Given a 0-indexed integer array nums, find a peak element, and return its index. If the array contains multiple peaks, return the index to any of the peaks.

     You may imagine that nums[-1] = nums[n] = -∞. In other words, an element is always considered to be strictly greater than a neighbor that is outside the array.

     You must write an algorithm that runs in O(log n) time.



     Example 1:

     Input: nums = [1,2,3,1]
     Output: 2
     Explanation: 3 is a peak element and your function should return the index number 2.
     Example 2:

     Input: nums = [1,2,1,3,5,6,4]
     Output: 5
     Explanation: Your function can return either index number 1 where the peak element is 2, or index number 5 where the peak element is 6.


     Constraints:

     1 <= nums.length <= 1000
     -231 <= nums[i] <= 231 - 1
     nums[i] != nums[i + 1] for all valid i.
     */

    func findPeakElement(_ nums: [Int]) -> Int {
        let count = nums.count
        if count == 1 {
            return 0
        }
        if nums[0] > nums[1] {
            return 0
        }
        if nums[count - 2] < nums[count - 1] {
            return count - 1
        }
        var low = 1
        var high = count - 2
        while low <= high {
            let mid = low + (high - low) / 2
            if nums[mid - 1] < nums[mid] && nums[mid] > nums[mid + 1] {
                return mid
            } else if nums[mid] > nums[mid - 1] {
                low = mid + 1
            } else {
                high = mid - 1
            }
        }
        return -1
    }

    /*
     69. Sqrt(x)
     Given a non-negative integer x, return the square root of x rounded down to the nearest integer. The returned integer should be non-negative as well.

     You must not use any built-in exponent function or operator.

     For example, do not use pow(x, 0.5) in c++ or x ** 0.5 in python.


     Example 1:

     Input: x = 4
     Output: 2
     Explanation: The square root of 4 is 2, so we return 2.
     Example 2:

     Input: x = 8
     Output: 2
     Explanation: The square root of 8 is 2.82842..., and since we round it down to the nearest integer, 2 is returned.


     Constraints:

     0 <= x <= 231 - 1
     */
    func mySqrt(_ x: Int) -> Int {
        if x == 1 {
            return 1
        }
        var low = 1
        var high = x / 2
        
        while low <= high {
            let mid = low + (high - low) / 2
            if mid * mid <= x {
                low = mid + 1
            } else {
                high = mid - 1
            }
            
        }
        return high
        
    }

    /*
     875. Koko Eating Bananas

     Koko loves to eat bananas. There are n piles of bananas, the ith pile has piles[i] bananas. The guards have gone and will come back in h hours.

     Koko can decide her bananas-per-hour eating speed of k. Each hour, she chooses some pile of bananas and eats k bananas from that pile. If the pile has less than k bananas, she eats all of them instead and will not eat any more bananas during this hour.

     Koko likes to eat slowly but still wants to finish eating all the bananas before the guards return.

     Return the minimum integer k such that she can eat all the bananas within h hours.



     Example 1:

     Input: piles = [3,6,7,11], h = 8
     Output: 4
     Example 2:

     Input: piles = [30,11,23,4,20], h = 5
     Output: 30
     Example 3:

     Input: piles = [30,11,23,4,20], h = 6
     Output: 23


     Constraints:

     1 <= piles.length <= 104
     piles.length <= h <= 109
     1 <= piles[i] <= 109
     */

    func minEatingSpeed(_ piles: [Int], _ h: Int) -> Int {
        var low = 0
        var high = 0
        for num in piles {
            high = max(high, num)
        }
        var answer = high
        while low <= high {
            let mid = low + (high - low) / 2
            // let hours = totalHour(nums: piles, rate: mid)
            var hours: Double = 0
            for num in piles {
                hours += ceil(Double(num) / Double(mid))
                if hours > Double(h) {
                    break
                }
            }
            if hours <= Double(h) {
                high = mid - 1
                answer = mid
            } else {
                low = mid + 1
            }
        }
        return answer
    }

    /*
     1482. Minimum Number of Days to Make m Bouquets

     You are given an integer array bloomDay, an integer m and an integer k.

     You want to make m bouquets. To make a bouquet, you need to use k adjacent flowers from the garden.

     The garden consists of n flowers, the ith flower will bloom in the bloomDay[i] and then can be used in exactly one bouquet.

     Return the minimum number of days you need to wait to be able to make m bouquets from the garden. If it is impossible to make m bouquets return -1.



     Example 1:

     Input: bloomDay = [1,10,3,10,2], m = 3, k = 1
     Output: 3
     Explanation: Let us see what happened in the first three days. x means flower bloomed and _ means flower did not bloom in the garden.
     We need 3 bouquets each should contain 1 flower.
     After day 1: [x, _, _, _, _]   // we can only make one bouquet.
     After day 2: [x, _, _, _, x]   // we can only make two bouquets.
     After day 3: [x, _, x, _, x]   // we can make 3 bouquets. The answer is 3.
     Example 2:

     Input: bloomDay = [1,10,3,10,2], m = 3, k = 2
     Output: -1
     Explanation: We need 3 bouquets each has 2 flowers, that means we need 6 flowers. We only have 5 flowers so it is impossible to get the needed bouquets and we return -1.
     Example 3:

     Input: bloomDay = [7,7,7,7,12,7,7], m = 2, k = 3
     Output: 12
     Explanation: We need 2 bouquets each should have 3 flowers.
     Here is the garden after the 7 and 12 days:
     After day 7: [x, x, x, x, _, x, x]
     We can make one bouquet of the first three flowers that bloomed. We cannot make another bouquet from the last three flowers that bloomed because they are not adjacent.
     After day 12: [x, x, x, x, x, x, x]
     It is obvious that we can make two bouquets in different ways.


     Constraints:

     bloomDay.length == n
     1 <= n <= 105
     1 <= bloomDay[i] <= 109
     1 <= m <= 106
     1 <= k <= n
     */

    // TC - O(n) * O(log (max - min + 1))
    func minDays(_ bloomDay: [Int], _ m: Int, _ k: Int) -> Int {
        if bloomDay.count < m * k {
            return -1
        }
        var low = 0
        var high = 0

        for num in bloomDay {
            low = min(num, low)
            high = max(num, high)
        }
        var result = Int(1e9)
        while low <= high {
            let mid = low + (high - low) / 2
            if isPossible(nums: bloomDay, day: mid, m: m, k: k) {
                result = min(mid, result)
                high = mid - 1
            } else {
                low = mid + 1
            }
        }
        return result

    }

    func isPossible(nums: [Int], day: Int, m: Int, k: Int) -> Bool {
        var bouquets = 0
        var count = 0
        for num in nums {
            if num <= day {
                count += 1
            } else {
                bouquets += count / k
                count = 0
            }
        }
        bouquets += count / k
        return bouquets >= m
    }

    /*
     1283. Find the Smallest Divisor Given a Threshold

     Given an array of integers nums and an integer threshold, we will choose a positive integer divisor, divide all the array by it, and sum the division's result. Find the smallest divisor such that the result mentioned above is less than or equal to threshold.

     Each result of the division is rounded to the nearest integer greater than or equal to that element. (For example: 7/3 = 3 and 10/2 = 5).

     The test cases are generated so that there will be an answer.



     Example 1:

     Input: nums = [1,2,5,9], threshold = 6
     Output: 5
     Explanation: We can get a sum to 17 (1+2+5+9) if the divisor is 1.
     If the divisor is 4 we can get a sum of 7 (1+1+2+3) and if the divisor is 5 the sum will be 5 (1+1+1+2).
     Example 2:

     Input: nums = [44,22,33,11,1], threshold = 5
     Output: 44


     Constraints:

     1 <= nums.length <= 5 * 104
     1 <= nums[i] <= 106
     nums.length <= threshold <= 106
     */

    func smallestDivisor(_ nums: [Int], _ threshold: Int) -> Int {
        var low = 1
        var high = 0
        for num in nums {
            high = max(num, high)
        }
        while low <= high {
            let mid = low + (high - low) / 2
            if isLessThanThreshold(nums: nums, threshold: threshold, divisor: mid) {
                high = mid - 1
            } else {
                low = mid + 1
            }
        }
        return low
    }

    func isLessThanThreshold(nums: [Int], threshold: Int, divisor: Int) -> Bool {
        var result = 0
        for num in nums {
            result += Int(ceil(Double(num) / Double(divisor)))
        }
        return result <= threshold
    }

    /*
     1011. Capacity To Ship Packages Within D Days

     A conveyor belt has packages that must be shipped from one port to another within days days.

     The ith package on the conveyor belt has a weight of weights[i]. Each day, we load the ship with packages on the conveyor belt (in the order given by weights). We may not load more weight than the maximum weight capacity of the ship.

     Return the least weight capacity of the ship that will result in all the packages on the conveyor belt being shipped within days days.



     Example 1:

     Input: weights = [1,2,3,4,5,6,7,8,9,10], days = 5
     Output: 15
     Explanation: A ship capacity of 15 is the minimum to ship all the packages in 5 days like this:
     1st day: 1, 2, 3, 4, 5
     2nd day: 6, 7
     3rd day: 8
     4th day: 9
     5th day: 10

     Note that the cargo must be shipped in the order given, so using a ship of capacity 14 and splitting the packages into parts like (2, 3, 4, 5), (1, 6, 7), (8), (9), (10) is not allowed.
     Example 2:

     Input: weights = [3,2,2,4,1,4], days = 3
     Output: 6
     Explanation: A ship capacity of 6 is the minimum to ship all the packages in 3 days like this:
     1st day: 3, 2
     2nd day: 2, 4
     3rd day: 1, 4
     Example 3:

     Input: weights = [1,2,3,1,1], days = 4
     Output: 3
     Explanation:
     1st day: 1
     2nd day: 2
     3rd day: 3
     4th day: 1, 1


     Constraints:

     1 <= days <= weights.length <= 5 * 104
     1 <= weights[i] <= 500
     */

    func shipWithinDays(_ weights: [Int], _ days: Int) -> Int {
        var low = 0
        var high = 0
        var answer = Int(1e9)
        for weight in weights {
            low = max(low, weight)
            high += weight
        }

        while low <= high {
            let mid = low + (high - low) / 2
            if findDaysWithCapacity(nums: weights, capacity: mid) <= days {
                high = mid - 1
                answer = min(mid, answer)
            } else {
                low = mid + 1
            }
        }
        return answer

    }

    func findDaysWithCapacity(nums: [Int], capacity: Int) -> Int {
        var days = 1
        var load = 0
        for num in nums {
            if num + load > capacity {
                days += 1
                load = num
            } else {
                load += num
            }
        }
        return days
    }

    /*
     1539. Kth Missing Positive Number

     Given an array arr of positive integers sorted in a strictly increasing order, and an integer k.

     Return the kth positive integer that is missing from this array.



     Example 1:

     Input: arr = [2,3,4,7,11], k = 5
     Output: 9
     Explanation: The missing positive integers are [1,5,6,8,9,10,12,13,...]. The 5th missing positive integer is 9.
     Example 2:

     Input: arr = [1,2,3,4], k = 2
     Output: 6
     Explanation: The missing positive integers are [5,6,7,...]. The 2nd missing positive integer is 6.


     Constraints:

     1 <= arr.length <= 1000
     1 <= arr[i] <= 1000
     1 <= k <= 1000
     arr[i] < arr[j] for 1 <= i < j <= a
     */
    func findKthPositive(_ arr: [Int], _ k: Int) -> Int {
        /*
        var k = k
        for num in arr {
            if num <= k {
                k += 1
            } else {
                break
            }
        }
        return k
         */
        var low = 0
        var high = arr.count - 1
        while low <= high {
            let mid = low + (high - low) / 2
            if arr[mid] - (mid + 1) < k {
                low = mid + 1
            } else {
                high = mid - 1
            }
        }
        return low + k

    }

    /*
      cows placement( aggressive cows - for search)
     */

    func canPlaceCows(array: [Int], distance: Int, numberOfCows: Int) -> Bool {
        var count = 1
        var last = array[0]
        for i in stride(from: 1, through: array.count - 1, by: 1) {
            if array[i] - last >= distance {
                count += 1
                last = array[i]
            }
            if count >= numberOfCows {
                return true
            }
        }
        return false
    }

    func cowsPlacement(array: [Int], numberOfCows: Int) -> Int {
        var sortedArray = array.sorted()
        var low = 1
        var high = array[array.count - 1] - array[0]
        while low <= high {
            let mid = low + (high - low) / 2
            if canPlaceCows(array: array, distance: mid, numberOfCows: numberOfCows) {
                low = mid + 1
            } else {
                high = mid - 1
            }

        }
        return high
    }

    /*
     allocate pages to students
     */

    func totalStudentCount(array: [Int], maxPageCount: Int) -> Int {
        var studentCount = 1
        var pageCount = 0
        for page in array {
            if page + pageCount <= maxPageCount {
                pageCount += page
            } else {
                studentCount += 1
                pageCount = page
            }
        }
        return studentCount
    }

    // Olog(max - sum + 1) * O(n)
    func pageAllocation(array: [Int], studentCount: Int) -> Int {
        var low = array.max()!
        var high = array.reduce(0, +)
        var answer = 0
        while low <= high {
            let mid = low + (high - low) / 2
            let numberOfStudents = totalStudentCount(array: array, maxPageCount: mid)
            if numberOfStudents > studentCount {
                low = mid + 1
            } else {
                high = mid - 1
                answer = min(answer, mid)
            }

        }
        return answer
    }

    /*
     410. Split Array Largest Sum
     Given an integer array nums and an integer k, split nums into k non-empty subarrays such that the largest sum of any subarray is minimized.

     Return the minimized largest sum of the split.

     A subarray is a contiguous part of the array.



     Example 1:

     Input: nums = [7,2,5,10,8], k = 2
     Output: 18
     Explanation: There are four ways to split nums into two subarrays.
     The best way is to split it into [7,2,5] and [10,8], where the largest sum among the two subarrays is only 18.
     Example 2:

     Input: nums = [1,2,3,4,5], k = 2
     Output: 9
     Explanation: There are four ways to split nums into two subarrays.
     The best way is to split it into [1,2,3] and [4,5], where the largest sum among the two subarrays is only 9.


     Constraints:

     1 <= nums.length <= 1000
     0 <= nums[i] <= 106
     1 <= k <= min(50, nums.length)
     */

    /*
     774. Minimize Max Distance to Gas Station

     You are given an integer array stations that represents the positions of the gas stations on the x-axis. You are also given an integer k.

     You should add k new gas stations. You can add the stations anywhere on the x-axis, and not necessarily on an integer position.

     Let penalty() be the maximum distance between adjacent gas stations after adding the k new stations.

     Return the smallest possible value of penalty(). Answers within 10-6 of the actual answer will be accepted.



     Example 1:

     Input: stations = [1,2,3,4,5,6,7,8,9,10], k = 9
     Output: 0.50000
     Example 2:

     Input: stations = [23,24,36,39,46,56,57,65,84,98], k = 1
     Output: 14.00000


     Constraints:

     10 <= stations.length <= 2000
     0 <= stations[i] <= 108
     stations is sorted in a strictly increasing order.
     1 <= k <= 106
     */

    // Time Limit Exceedes
    // TC - O(n * k) + O(n)
    func minmaxGasDist(_ stations: [Int], _ k: Int) -> Double {
        let count = stations.count
        var sections = [Int](repeating: 0, count: count - 1)
        for _ in stride(from: 1, through: k, by: 1) {
            var maxSectionLength: Double = -1
            var maxSectionIndex = -1
            for i in stride(from: 0, through: count - 2, by: 1) {
                let distance = Double(stations[i + 1] - stations[i])
                let sectionLength = distance / Double(sections[i] + 1)
                if sectionLength > maxSectionLength {
                    maxSectionLength = sectionLength
                    maxSectionIndex = i
                }
            }
            sections[maxSectionIndex] += 1
        }

        var result: Double = -1
        for i in stride(from: 0, through: count - 2, by: 1) {
            let distance = Double(stations[i + 1] - stations[i])
            let sectionLength = distance / Double(sections[i] + 1)
            result = max(result, sectionLength)
        }
        return result
    }

    // TC - O(n * logn) + O(k * log k)
    // SC - O(n - 1)
    func minmaxGasDistPQ(_ stations: [Int], _ k: Int) -> Double {
        let count = stations.count
        var sections = [Int](repeating: 0, count: count - 1)
        var pq = PriorityQueueHeap<PriorityQueueHeapItem<Double, Int>>(capacity: count - 1)
        for i in stride(from: 0, through: count - 2, by: 1) {
            let distance = Double(stations[i + 1] - stations[i])
            pq.insert(value: PriorityQueueHeapItem<Double, Int>(x: distance, y: i))
        }
        print(pq)
        for _ in stride(from: 1, through: k, by: 1) {
            let top = pq.remove()!
            let sectionIndex = top.y
            sections[sectionIndex] += 1
            let diff = stations[sectionIndex + 1] - stations[sectionIndex]
            let sectionLength = Double(diff) / Double(sections[sectionIndex] + 1)
            pq.insert(value: PriorityQueueHeapItem<Double, Int>(x: sectionLength, y: sectionIndex))
        }

        print(pq)
        return pq.top()!.x
    }

    func minmaxGasDistBS(_ stations: [Int], _ k: Int) -> Double {
        var low = 0.0
        var high = 0.0
        for i in stride(from: 1, through: stations.count - 1, by: 1) {
            high = max(high, Double(stations[i] - stations[i - 1]))
        }
        var answer = 0.0
        while high - low > 1e-6 {
            let mid = low + (high - low) / 2.0
            print("Mid - \(mid)")
            let stations = numberOfGasStations(distance: mid, array: stations)
            if stations > k {
                low = mid
            } else {
                high = mid
                answer = mid
            }
        }
        return answer
    }

    func numberOfGasStations(distance: Double, array: [Int]) -> Int {
        var result = 0
        for i in stride(from: 1, through: array.count - 1, by: 1) {
            var length = Int(Double(array[i] - array[i - 1]) / distance)
            print("Length - \(length), distance - \(distance), check - \(Double(array[i] - array[i - 1]) / distance == Double(length) * distance)")
            if  Double(array[i] - array[i - 1]) == Double(length) * distance {
                print("Length - \(length), distance - \(distance), check - \(Double(array[i] - array[i - 1]) / distance == Double(length) * distance)")
                length -= 1
            }
            result += length
        }
        return result
    }

    /*
     4. Median of Two Sorted Arrays

     Given two sorted arrays nums1 and nums2 of size m and n respectively, return the median of the two sorted arrays.

     The overall run time complexity should be O(log (m+n)).



     Example 1:

     Input: nums1 = [1,3], nums2 = [2]
     Output: 2.00000
     Explanation: merged array = [1,2,3] and median is 2.
     Example 2:

     Input: nums1 = [1,2], nums2 = [3,4]
     Output: 2.50000
     Explanation: merged array = [1,2,3,4] and median is (2 + 3) / 2 = 2.5.


     Constraints:

     nums1.length == m
     nums2.length == n
     0 <= m <= 1000
     0 <= n <= 1000
     1 <= m + n <= 2000
     -106 <= nums1[i], nums2[i] <= 106
     */

    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        let n1 = nums1.count
        let n2 = nums2.count
        let left = (n1 + n2 + 1) / 2
        let total = n1 + n2
        var low = 0
        var high = n1 <= n2 ? n1: n2
        while low <= high {
            let mid1 = low + ((high - low) / 2)
            let mid2 = left - mid1
            var l1 = Int.min
            var l2 = Int.min
            var r1 = Int.max
            var r2 = Int.max
            if n1 <= n2 {
                if mid1 < n1 {
                    r1 = nums1[mid1]
                }
                if mid2 < n2 {
                    r2 = nums2[mid2]
                }
                if mid1 - 1 >= 0 {
                    l1 = nums1[mid1 - 1]
                }
                if mid2 - 1 >= 0 {
                    l2 = nums2[mid2 - 1]
                }
            } else {
                if mid1 < n2 {
                    r1 = nums2[mid1]
                }
                if mid2 < n1 {
                    r2 = nums1[mid2]
                }
                if mid1 - 1 >= 0 {
                    l1 = nums2[mid1 - 1]
                }
                if mid2 - 1 >= 0 {
                    l2 = nums1[mid2 - 1]
                }
            }
            if l1 <= r2 && l2 <= r1 {
                if total & 1 == 1 {
                    return Double(max(l1, l2))
                }
                return Double(max(l1, l2) + min(r1, r2)) / 2.0
            } else if l1 > r2 {
                high = mid1 - 1
            } else {
                low = mid1 + 1
            }
        }
        return 0
    }

    /*

     Code
     Testcase
     Test Result
     Test Result
     74. Search a 2D Matrix

     You are given an m x n integer matrix matrix with the following two properties:

     Each row is sorted in non-decreasing order.
     The first integer of each row is greater than the last integer of the previous row.
     Given an integer target, return true if target is in matrix or false otherwise.

     You must write a solution in O(log(m * n)) time complexity.



     Example 1:


     Input: matrix = [[1,3,5,7],[10,11,16,20],[23,30,34,60]], target = 3
     Output: true
     Example 2:


     Input: matrix = [[1,3,5,7],[10,11,16,20],[23,30,34,60]], target = 13
     Output: false


     Constraints:

     m == matrix.length
     n == matrix[i].length
     1 <= m, n <= 100
     -104 <= matrix[i][j], target <= 104
     */

    func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
        var low = 0
        let rowCount = matrix.count
        let columnCount = matrix[0].count
        var high = rowCount * columnCount - 1
        while low <= high {
            let mid = low + (high - low) / 2
            let row = mid / columnCount
            let column = mid % columnCount
            if matrix[row][column] == target {
                return true
            }
            if matrix[row][column] > target {
                high = mid - 1
            } else {
                low = mid + 1
            }
        }
        return false
    }

    /*
     240. Search a 2D Matrix II
    
     Write an efficient algorithm that searches for a value target in an m x n integer matrix matrix. This matrix has the following properties:

     Integers in each row are sorted in ascending from left to right.
     Integers in each column are sorted in ascending from top to bottom.


     Example 1:


     Input: matrix = [[1,4,7,11,15],[2,5,8,12,19],[3,6,9,16,22],[10,13,14,17,24],[18,21,23,26,30]], target = 5
     Output: true
     Example 2:


     Input: matrix = [[1,4,7,11,15],[2,5,8,12,19],[3,6,9,16,22],[10,13,14,17,24],[18,21,23,26,30]], target = 20
     Output: false


     Constraints:

     m == matrix.length
     n == matrix[i].length
     1 <= n, m <= 300
     -109 <= matrix[i][j] <= 109
     All the integers in each row are sorted in ascending order.
     All the integers in each column are sorted in ascending order.
     -109 <= target <= 109
     */

    func searchMatrixII(_ matrix: [[Int]], _ target: Int) -> Bool {
        var rowCount = matrix.count
        var columnCount = matrix[0].count
        var row = 0
        var column = columnCount - 1
        while row < rowCount && column >= 0 {
            if matrix[row][column] == target {
                return true
            }
            if matrix[row][column] > target {
                column -= 1
            } else {
                row += 1
            }
        }
        return false
    }

    /*
     1901. Find a Peak Element II
     Medium
     Topics
     conpanies icon
     Companies
     Hint
     A peak element in a 2D grid is an element that is strictly greater than all of its adjacent neighbors to the left, right, top, and bottom.

     Given a 0-indexed m x n matrix mat where no two adjacent cells are equal, find any peak element mat[i][j] and return the length 2 array [i,j].

     You may assume that the entire matrix is surrounded by an outer perimeter with the value -1 in each cell.

     You must write an algorithm that runs in O(m log(n)) or O(n log(m)) time.



     Example 1:



     Input: mat = [[1,4],[3,2]]
     Output: [0,1]
     Explanation: Both 3 and 4 are peak elements so [1,0] and [0,1] are both acceptable answers.
     Example 2:



     Input: mat = [[10,20,15],[21,30,14],[7,16,32]]
     Output: [1,1]
     Explanation: Both 30 and 32 are peak elements so [1,1] and [2,2] are both acceptable answers.


     Constraints:

     m == mat.length
     n == mat[i].length
     1 <= m, n <= 500
     1 <= mat[i][j] <= 105
     No two adjacent cells are equal.
     */

    func findPeakGrid(_ mat: [[Int]]) -> [Int] {
        let rowCount = mat.count
        let columnCount = mat[0].count
        var low = 0
        var high = rowCount - 1
        while low <= high {
            let mid = low + (high - low) / 2
            let column = findMax(nums: mat[mid])
            let top = mid > 0 ? mat[mid - 1][column] : -1
            let bottom = mid < rowCount - 1 ? mat[mid + 1][column] : -1
            if mat[mid][column] > top && mat[mid][column] > bottom {
                return [mid, column]
            }
            if mat[mid][column] < top {
                high = mid - 1
            } else {
                low = mid + 1
            }
        }
        return [-1, -1]
    }
    
    func findMax(nums: [Int]) -> Int {
        var result = Int.min
        var resultIndex = -1
        for (index, num) in nums.enumerated() {
            if num > result {
                result = num
                resultIndex = index
            }
        }
        return resultIndex
    }
}
