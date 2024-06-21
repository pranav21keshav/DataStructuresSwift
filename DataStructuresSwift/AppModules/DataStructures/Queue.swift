//
//  Queue.swift
//  DataStructuresSwift
//
//  Created by PRANAV PRAVAKAR on 04/04/20.
//  Copyright © 2020 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation
// MARK: - Practical Applications
// 1. Processing interrupts in OS
// 2. Job scheduling
// 3. Shared resources

// MARK: - Disadvantages
// 1. Random access is not allowed
// 2. Not suitable for large data sets
struct Queue<T> {
    private var elements = [T]()
    
    mutating func enqueue(_ element: T) {
        elements.append(element)
    }
    mutating func dequeue() -> T? {
        if elements.isEmpty {
            return nil
        } else {
            return elements.removeFirst()
        }
    }
    func front() -> T? {
        return elements.first
    }
    func isEmpty() -> Bool {
        return elements.isEmpty
    }
    func count() -> Int {
        return elements.count
    }
}
