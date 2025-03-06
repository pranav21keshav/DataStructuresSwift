//
//  KMP.swift
//  DataStructuresSwift
//
//  Created by Pranav Pravakar on 22/06/24.
//  Copyright © 2024 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation
// Knuth Morris Pratt
struct KMP {
    init() {
        print("---------> Bitwise")
        search(string: "I am a disco dancer", pattern: "disco")
        search(string: "onionion", pattern: "onions")
        search(string: "unknownstring", pattern: "unavailable")
        search(string: "aaaabaa", pattern: "aa")
    }

    private func lps(pattern: String) -> [Int] {
        let patternLength = pattern.count
        var lps = [Int](repeating: 0, count: patternLength)
        var length = 0
        lps[0] = 0
        var counter = 1
        while counter < patternLength {
            if pattern[counter] == pattern[length] {
                length += 1
                lps[counter] = length
                counter += 1
            } else {
                if length != 0 {
                    length = lps[length - 1]
                } else {
                    lps[counter] = length
                    counter += 1
                }
            }
        }
        print("Pattern - \(pattern), lps - \(lps)")
        return lps
    }

    func search(string: String, pattern: String) {
        let stringLength = string.count
        let patternLength = pattern.count
        let lps = lps(pattern: pattern)
        var stringCounter = 0
        var patternCounter = 0
        while stringLength - stringCounter >= patternLength - patternCounter {
            if string[stringCounter] == pattern[patternCounter] {
                stringCounter += 1
                patternCounter += 1
            } else {
                if patternCounter != 0 {
                    patternCounter = lps[patternCounter - 1]
                } else {
                    stringCounter += 1
                }
            }

            if patternCounter == patternLength {
                print("pattern - \"\(pattern)\" in string - \"\(string)\", found at index - \(stringCounter - patternCounter)")
                patternCounter = lps[patternCounter - 1]
            }
        }
    }
}
