//
//  StringProblems.swift
//  DataStructuresSwift
//
//  Created by Pranav Pravakar on 21/06/24.
//  Copyright © 2024 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation

struct StringProblems {
    func findSubsrtingNaive(string: String, pattern: String) {
        let stringLength = string.count
        let patternLength = pattern.count
        for i in 0..<stringLength - patternLength - 1 {
            var counter: Int = 0
            while counter < patternLength {
                if string[i + counter] != pattern[counter] {
                    break
                }
                counter += 1
            }
            if counter == patternLength {
                print("Found at index - \(i)")
            }
        }
    }
}
