//
//  Searching.swift
//  DataStructuresSwift
//
//  Created by Pranav Pravakar on 03/06/24.
//  Copyright © 2024 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation
struct Searching<T: Comparable> {

    //Worst Case: O(log N)
    func binarySearch(array: [Int], value: Int) -> Int? {
        guard !array.isEmpty else { return nil }
        var low = array.startIndex
        var high = array.endIndex

        while low <= high {
            let mid = low + (high - low) / 2
            if array[mid] == value {
                return mid
            }

            if array[mid] < value {
                low = mid + 1
            } else {
                high = mid - 1
            }
        }

        // Element not found
        return nil
    }

    func binarySearchRecursive(array: [Int], low: Int, high: Int, value: Int) -> Int? {
        var low = low
        var high = high

        if low <= high {
            let mid = low + (high - low) / 2
            if array[mid] == value {
                return mid
            }

            if array[mid] < value {
                low = mid + 1
                return binarySearchRecursive(array: array, low: low, high: high, value: value)
            } else {
                high = mid - 1
                return binarySearchRecursive(array: array, low: low, high: high, value: value)
            }
        }

        // Element not found
        return nil
    }
}
