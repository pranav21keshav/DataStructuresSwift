//
//  Permuation.swift
//  DataStructuresSwift
//
//  Created by Pranav Pravakar on 16/06/24.
//  Copyright © 2024 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation

public final class Permuation {

    func permute(string: inout String, start: Int, end: Int) {
        if start == end {
            print("---------------> \(string)")
        } else {
            for i in start...end {

                swap(string: &string, start: start, end: i)
                permute(string: &string, start: (start + 1), end: end)
                swap(string: &string, start: start, end: i)
            }
        }
    }

    func swap(string: inout String, start: Int, end: Int) {
        let temp = string[start]
        string[start] = string[end]
        string[end] = temp
    }

    func swapReturn(string: String, start: Int, end: Int) -> String {
        var tempString = string
        let temp = string[start]
        tempString[start] = string[end]
        tempString[end] = temp
        return tempString
    }
}

extension String {
    subscript(idx: Int) -> String {
        get {
            String(self[index(startIndex, offsetBy: idx)])
        }
        set {
            let index = index(startIndex, offsetBy: idx)
            replaceSubrange(index...index, with: newValue)
        }
    }
}
