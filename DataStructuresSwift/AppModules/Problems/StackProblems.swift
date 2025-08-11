//
//  StackProblems.swift
//  DataStructuresSwift
//
//  Created by Pranav pravakar on 10/08/25.
//  Copyright © 2025 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation
struct StackProblems {
    init() {
        var values = [2, 1, 5, 6, 2, 3]
        print("NSE \(values) - \(nextSmallerElements(array: values))")
        print("PSE \(values) - \(previousSmallerElements(array: values))")
        print("NSE Index \(values) - \(nextSmallerElementsIndex(array: values))")
        print("PSE Index \(values) - \(previousSmallerElementsIndex(array: values))")
        print("largestRectangleArea - \(values) - \(largestRectangleArea(values))")
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
    func largestRectangleArea(_ heights: [Int]) -> Int {
        let nse = nextSmallerElementsIndex(array: heights)
        let pse = previousSmallerElementsIndex(array: heights)
        var maximum = 0
        for index in stride(from: 0, through: heights.count - 1, by: 1) {
            maximum = max(maximum, heights[index] * (nse[index] - pse[index] - 1))
        }
        return maximum
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

    // TC - O(2N)
    // SC - O(N)
    func largestRectangleAreaOpti(_ heights: [Int]) -> Int {
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
}
