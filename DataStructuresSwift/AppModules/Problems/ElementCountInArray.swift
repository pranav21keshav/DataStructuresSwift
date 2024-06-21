//
//  ElementCountInArray.swift
//  DataStructuresSwift
//
//  Created by Pranav Pravakar on 05/02/24.
//  Copyright © 2024 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation
/*
 Find the count of each element in an array and number of unique elements
 */

class ElementCountInArray {
    public func elementCountIn(array: [Int]) {
        var elementCount = [Int: Int]()

        for element in array {
            if let value = elementCount[element] {
                elementCount[element] = value + 1
            } else {
                elementCount[element] = 1
            }
        }

        print("Total Number of Unique Elements - ", elementCount.count)
        print("Element Counts - ", elementCount)
    }
}
