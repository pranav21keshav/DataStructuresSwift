//
//  Sorting.swift
//  DataStructuresSwift
//
//  Created by PRANAV PRAVAKAR on 02/04/20.
//  Copyright © 2020 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation
struct Sorting<T: Comparable> {
    func insertionSortPractice(_ array: [T]) -> [T] {
        var array = array
        for i in 1..<array.count {
            var j = i
            let temp = array[i]
            while j > 0 && temp < array[j - 1] {
                array[j] = array[j - 1]
                j -= 1
            }
            array[j] = temp
        }
        return array
    }
    func insertionSortGeneric(_ array: [T], _ isOrderedBefore: (T, T) -> Bool) -> [T] {
        var array = array
        for i in 1..<array.count {
            var j = i
            let temp = array[i]
            while j > 0 && isOrderedBefore(temp, array[j - 1]) {
                array[j] = array[j - 1]
                j -= 1
            }
            array[j] = temp
        }
        return array
    }
    
    func merge(left: [T], right: [T]) -> [T] {
        var leftIndex = 0, rightIndex = 0
        var orderedArray = [T]()
        while leftIndex < left.count && rightIndex < right.count {
            if left[leftIndex] < right[rightIndex] {
                orderedArray.append(left[leftIndex])
                leftIndex += 1
            } else if left[leftIndex] > right[rightIndex] {
                orderedArray.append(right[rightIndex])
                rightIndex += 1
            } else {
                orderedArray.append(left[leftIndex])
                orderedArray.append(right[rightIndex])
                leftIndex += 1
                rightIndex += 1
            }
        }
        return orderedArray
    }
    func mergeSort(_ array: [T]) -> [T] {
        guard array.count > 1 else { return array }
        let mid = array.count / 2
        let left = mergeSort(Array(array[0..<mid]))
        let right = mergeSort(Array(array[mid..<array.count]))
        return merge(left: left, right: right)
    }
    func merge(left: [T], right: [T], _ orderBy: (T, T) -> Bool) -> [T] {
        var leftIndex = 0, rightIndex = 0
        var orderedArray = [T]()
        while leftIndex < left.count && rightIndex < right.count {
            if orderBy(left[leftIndex], right[rightIndex]) {
                orderedArray.append(left[leftIndex])
                leftIndex += 1
            } else if !orderBy(left[leftIndex], right[rightIndex]) {
                orderedArray.append(right[rightIndex])
                rightIndex += 1
            } else {
                orderedArray.append(left[leftIndex])
                orderedArray.append(right[rightIndex])
                leftIndex += 1
                rightIndex += 1
            }
        }
        while leftIndex < left.count {
            orderedArray.append(left[leftIndex])
            leftIndex += 1
        }
        while rightIndex < right.count {
            orderedArray.append(right[rightIndex])
            rightIndex += 1
        }
        return orderedArray
    }
    func mergeSort(_ array: [T], _ orderBy: (T, T) -> Bool) -> [T] {
        guard array.count > 1 else { return array }
        let mid = array.count / 2
        let left = mergeSort(Array(array[0..<mid]), orderBy)
        let right = mergeSort(Array(array[mid..<array.count]), orderBy)
        return merge(left: left, right: right, orderBy)
    }
    func lomutoPartition(_ array: inout [T], low: Int, high: Int) -> Int {
        let pivot = array[high]
        var i = low
        for j in low..<high where array[j] <= pivot {
            array.swapAt(j, i)
            i += 1
        }
        array.swapAt(i, high)
        return i
    }
    func quicksortLomuto(_ array: inout [T], low: Int, high: Int) {
        if low < high {
            let p = lomutoPartition(&array, low: low, high: high)
            quicksortLomuto(&array, low: low, high: p - 1)
            quicksortLomuto(&array, low: p + 1, high: high)
        }
    }
}
