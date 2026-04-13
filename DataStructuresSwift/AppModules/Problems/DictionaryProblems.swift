//
//  DictionaryProblems.swift
//  DataStructuresSwift
//
//  Created by Pranav pravakar on 09/12/25.
//  Copyright © 2025 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation

struct DictionaryProblems {
    /*

     1570. Dot Product of Two Sparse Vectors
     Given two sparse vectors, compute their dot product.

     Implement class SparseVector:

     SparseVector(nums) Initializes the object with the vector nums
     dotProduct(vec) Compute the dot product between the instance of SparseVector and vec
     A sparse vector is a vector that has mostly zero values, you should store the sparse vector efficiently and compute the dot product between two SparseVector.

     Follow up: What if only one of the vectors is sparse?



     Example 1:

     Input: nums1 = [1,0,0,2,3], nums2 = [0,3,0,4,0]
     Output: 8
     Explanation: v1 = SparseVector(nums1) , v2 = SparseVector(nums2)
     v1.dotProduct(v2) = 1*0 + 0*3 + 0*0 + 2*4 + 3*0 = 8
     Example 2:

     Input: nums1 = [0,1,0,0,0], nums2 = [0,0,0,0,2]
     Output: 0
     Explanation: v1 = SparseVector(nums1) , v2 = SparseVector(nums2)
     v1.dotProduct(v2) = 0*0 + 1*0 + 0*0 + 0*0 + 0*2 = 0
     Example 3:

     Input: nums1 = [0,1,0,0,2,0,0], nums2 = [1,0,0,0,3,0,4]
     Output: 6


     Constraints:

     n == nums1.length == nums2.length
     1 <= n <= 10^5
     0 <= nums1[i], nums2[i] <= 100
     */
    // One approach traverse array and multiply
    // Another Store in hashmap
    class SparseVector {

        init(_ nums: [Int]) {

        }

        // Return the dotProduct of two sparse vectors
        func dotProduct(_ vec: SparseVector) -> Int {
            return 0
        }
    }

    /*
     * Your SparseVector object will be instantiated and called as such:
     * let v1 = SparseVector(nums1)
     * let v2 = SparseVector(nums2)
     * let ans = v1.dotProduct(v2)
    */

    /*
     398. Random Pick Index
     Given an integer array nums with possible duplicates, randomly output the index of a given target number. You can assume that the given target number must exist in the array.

     Implement the Solution class:

     Solution(int[] nums) Initializes the object with the array nums.
     int pick(int target) Picks a random index i from nums where nums[i] == target. If there are multiple valid i's, then each index should have an equal probability of returning.


     Example 1:

     Input
     ["Solution", "pick", "pick", "pick"]
     [[[1, 2, 3, 3, 3]], [3], [1], [3]]
     Output
     [null, 4, 0, 2]

     Explanation
     Solution solution = new Solution([1, 2, 3, 3, 3]);
     solution.pick(3); // It should return either index 2, 3, or 4 randomly. Each index should have equal probability of returning.
     solution.pick(1); // It should return 0. Since in the array only nums[0] is equal to 1.
     solution.pick(3); // It should return either index 2, 3, or 4 randomly. Each index should have equal probability of returning.


     Constraints:

     1 <= nums.length <= 2 * 104
     -231 <= nums[i] <= 231 - 1
     target is an integer from nums.
     At most 104 calls will be made to pick.
     */
}
