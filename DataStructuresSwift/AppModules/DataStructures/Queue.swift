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
    private var head: Node<T>?
    private var tail: Node<T>?
    private var elementCount: Int = 0

    mutating func enqueue(_ element: T) {
        if head == nil {
            head = Node(value: element)
            tail = head
            elementCount += 1
            return
        }
        tail?.next = Node(value: element)
        tail = tail?.next
        elementCount += 1
    }

    mutating func dequeue() -> T? {
        let data = head?.data
        head = head?.next
        elementCount -= 1
        return data

    }

    func front() -> T? {
        return head?.data
    }

    func isEmpty() -> Bool {
        return head == nil
    }

    func count() -> Int {
        elementCount
    }
}
