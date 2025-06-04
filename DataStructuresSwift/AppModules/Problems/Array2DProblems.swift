//
//  Array2DProblems.swift
//  DataStructuresSwift
//
//  Created by Pranav pravakar on 02/06/25.
//  Copyright © 2025 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation
struct Array2DProblems {
    /*
    Given an m x n matrix, return all elements of the matrix in spiral order.



    Example 1:
    Input: matrix = [[1,2,3],[4,5,6],[7,8,9]]
    Output: [1,2,3,6,9,8,7,4,5]

    Example 2:
    Input: matrix = [[1,2,3,4],[5,6,7,8],[9,10,11,12]]
    Output: [1,2,3,4,8,12,11,10,9,5,6,7]

*/

    func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        var row = matrix.count
        var column = matrix[0].count
        var left = 0
        var right = column - 1
        var top = 0
        var bottom = row - 1
        var result = [Int]()
        while top <= bottom && left <= right {
            for i in stride(from: left, through: right, by: 1) {
                result.append(matrix[top][i])
            }
            top += 1
            for i in stride(from: top, through: bottom, by: 1) {
                result.append(matrix[i][right])
            }
            right -= 1
            if top <= bottom {
                for i in stride(from: right, through: left, by: -1) {
                    result.append(matrix[bottom][i])
                }
                bottom -= 1
            }
            if left <= right {
                for i in stride(from: bottom, through: top, by: -1) {
                    result.append(matrix[i][left])
                }
                left += 1
            }
            
        }
        return result
    }
}
