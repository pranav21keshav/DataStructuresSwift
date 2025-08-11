//
//  BinarySearch.swift
//  DataStructuresSwift
//
//  Created by Pranav pravakar on 28/07/25.
//  Copyright © 2025 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation
struct BinarySearch<T: Comparable> {
    init() {
        var array = [2, 2]
        var target = 3
        print("Search in range - array - \(array), target - \(target) - \(searchRange(array, target))")
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
}
