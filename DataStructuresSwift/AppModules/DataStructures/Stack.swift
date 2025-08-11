//
//  Stack.swift
//  DataStructuresSwift
//
//  Created by PRANAV PRAVAKAR on 31/03/20.
//  Copyright © 2020 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation
// MARK: - Practical Applications
// 1. Undo, redo
// 2. Most recent feature
// 3. Web page navigation
// 4. Parenthesis check
// 5. Expression evaluation, infix, postfix, prefix expressions
// MARK: - Disadvantages
// 1. Not suitable for random search
// 2. Not suitable for large data sets
struct Stack<T> {
    private var elements = [T]()
    
    mutating func push(_ element: T) {
        elements.append(element)
    }
    mutating func pop() -> T? {
        return elements.popLast()
    }
    func peek() -> T? {
        return elements.last
    }
    func isEmpty() -> Bool {
        return elements.isEmpty
    }
    func count() -> Int {
        return elements.count
    }
}

struct StackLL<T> {
    private var top: Node<T>?
    private var count: Int = 0

    init(top: Node<T>? = nil) {
        self.top = top
    }

    mutating func push(_ element: T) {
        let node = Node(value: element)
        node.next = top
        top = node
        count += 1
    }

    mutating func pop() -> T? {
        if top == nil {
            return nil
        }
        count -= 1
        let node = top?.data
        top = top?.next
        return node
    }

    func peek() -> T? {
        top?.data
    }

}
