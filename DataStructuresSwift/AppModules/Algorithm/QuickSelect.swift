//
//  QuickSelect.swift
//  DataStructuresSwift
//
//  Created by Pranav Pravakar on 13/07/24.
//  Copyright © 2024 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation
struct QuickSelect {
    init() {
        print("---------> Quick Select")
        var a = [11, 15, 4, 2, 5, 6, 9, 10]
        print("2 smallest in \(a) is - \(search(array: &a, low: 0, high: a.count - 1, kthSmallest: 2))")
        var b = [14, 19, 8, 2, 3, 9, 6, 10]
        print("3 smallest in \(b) is - \(search(array: &b, low: 0, high: a.count - 1, kthSmallest: 3))")
        var c = [3, 3, 3, 6, 6, 6, 9, 9, 9]
        print("2 smallest in \(c) is - \(search(array: &c, low: 0, high: a.count - 1, kthSmallest: 2))")

        print("---------> Quick Select to find 3rd largest")
        var array1 = [ 11, 3, 2, 1, 15, 5, 4, 45, 88, 96, 50, 45 ]
        print("3 largest in \(array1) is - \(search(array: &array1, low: 0, high: array1.count - 1, kthSmallest: array1.count - 2))")

        print("---------> Quick Select Modified")
        var array = [ 11, 3, 2, 1, 15, 5, 4, 45, 88, 96, 50, 45 ]
        print("3 largest in \(array) is - \(searchKthLargestModified(array: &array, low: 0, high: array.count - 1, kthLargest: 3))")
    }
    
    func partition(array: inout [Int], low: Int, high: Int) -> Int {
        let pivot = array[high]
        var i = low
        for j in low...high {
            if array[j] < pivot {
                array.swapAt(i, j)
                i += 1
            }
        }
        array.swapAt(i, high)
        return i
    }

    func search(array: inout [Int], low: Int, high: Int, kthSmallest: Int) -> Int {
        let partition = partition(array: &array, low: low, high: high)
        if partition == kthSmallest - 1 {
            return array[partition]
        } else if partition < kthSmallest - 1 {
             return search(array: &array, low: partition + 1, high: high, kthSmallest: kthSmallest)
        } else {
            return search(array: &array, low: low, high: partition - 1, kthSmallest: kthSmallest)
        }
    }

    func partitionModifiedHigest(array: inout [Int], low: Int, high: Int) -> Int {
        let pivot = array[high]
        var i = low
        for j in low...high {
            if array[j] > pivot {
                array.swapAt(i, j)
                i += 1
            }
        }
        array.swapAt(i, high)
        return i
    }

    func searchKthLargestModified(array: inout [Int], low: Int, high: Int, kthLargest: Int) -> Int {
        let partition = partitionModifiedHigest(array: &array, low: low, high: high)
        if partition == kthLargest - 1 {
            return array[partition]
        } else if partition < kthLargest - 1 {
            return searchKthLargestModified(array: &array, low: partition + 1, high: high, kthLargest: kthLargest)
        } else {
            return searchKthLargestModified(array: &array, low: low, high: partition - 1, kthLargest: kthLargest)
        }
    }
}
