//
//  KadaneAlgorithm.swift
//  DataStructuresSwift
//
//  Created by Pranav Pravakar on 21/06/24.
//  Copyright © 2024 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation

struct KadaneAlgorithm {
    func subset(array: [Int]) {
        var start = 0
        var end = 0
        var newStart = 0
        var maxSum = Int.min
        var currentSum = 0
        for i in 0..<array.count {
            currentSum += array[i]
            if maxSum < currentSum {
                maxSum = currentSum
                start = newStart
                end = i
            }
            if currentSum < 0 {
                currentSum = 0
                newStart = i + 1
            }
        }

        print("Max sum - \(maxSum), subset - \(array[start...end])")
    }
}
