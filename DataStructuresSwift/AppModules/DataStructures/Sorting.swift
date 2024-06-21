//
//  Sorting.swift
//  DataStructuresSwift
//
//  Created by PRANAV PRAVAKAR on 02/04/20.
//  Copyright © 2020 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation
struct Sorting<T: Comparable> {

    // Time Complexity: O(N^2)
    // Stable
    // In place
    func bubbleSort(array: [T]) -> [T] {
        var array = array
        let count = array.count
        for i in 0..<count {
            var swapped = false
            for j in 0..<count - 1 - i {
                if array[j] > array[j + 1] {
                    let temp = array[j]
                    array[j] = array[j + 1]
                    array[j + 1] = temp
                    swapped = true
                }
            }
            if swapped == false {
                break
            }
        }
        return array
    }

    // Time Complexity: O(N^2)
    // Stable
    // In place
    func insertionSortPractice(_ array: [T]) -> [T] {
        var array = array
        for i in 1..<array.count {
            var j = i - 1
            let temp = array[i]
            while j >= 0 && array[j] > temp {
                array[j + 1] = array[j]
                j -= 1
            }
            array[j + 1] = temp
        }
        return array
    }

    func insertionSortGeneric(_ array: [T], _ isOrderedBefore: (T, T) -> Bool) -> [T] {
        var array = array
        for i in 1..<array.count {
            var j = i - 1
            let temp = array[i]
            while j > 0 && isOrderedBefore(temp, array[j - 1]) {
                array[j + 1] = array[j]
                j -= 1
            }
            array[j + 1] = temp
        }
        return array
    }
    
    func merge(array: inout [T], start: Int, middle: Int, end: Int) {
        let leftSubArray = Array(array[start...middle])
        let rightSubArray = Array(array[middle + 1...end])
        var leftIndex = 0
        var rightIndex = 0
        var index = start
        while leftIndex < leftSubArray.count && rightIndex < rightSubArray.count {
            if leftSubArray[leftIndex] < rightSubArray[rightIndex] {
                array[index] = leftSubArray[leftIndex]
                leftIndex += 1
            } else {
                array[index] = rightSubArray[rightIndex]
                rightIndex += 2
            }
            index += 1
        }
        while leftIndex < leftSubArray.count {
            array[index] = leftSubArray[leftIndex]
            leftIndex += 1
        }

        while rightIndex < rightSubArray.count {
            array[index] = rightSubArray[rightIndex]
            rightIndex += 1
        }
    }

    // O(n log n)
    func mergeSort(array: inout [T], start: Int, end: Int) {
        guard start >= end else { return }
        let middle = (start + end) / 2
        mergeSort(array: &array, start: start, end: middle)
        mergeSort(array: &array, start: middle + 1, end: end)
        merge(array: &array, start: start, middle: middle, end: end)
    }

    /*
    // O(n log n)
    func mergeSort(_ array: [T]) -> [T] {
        guard array.count > 1 else { return array }
        let mid = array.count / 2
        let left = mergeSort(Array(array[0..<mid]))
        let right = mergeSort(Array(array[mid..<array.count]))
        return merge(left: left, right: right)
    }
     */

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
