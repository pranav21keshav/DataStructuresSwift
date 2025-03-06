//
//  PriorityQueue.swift
//  DataStructuresSwift
//
//  Created by Pranav Pravakar on 21/07/24.
//  Copyright © 2024 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation
struct PriorityQueueArrayItem<T> {
    var value: T
    var priority: Int
}

struct PriorityQueueArray<T: Comparable> {
    private var items = [PriorityQueueArrayItem<T>]()

    func peek() -> Int {
        var highestPriority = Int.min
        var elementIndex: Int = -1
        for i in 0..<items.count {
            if highestPriority < items[i].priority {
                highestPriority = items[i].priority
                elementIndex = i
            } else if highestPriority == items[i].priority && elementIndex > -1 && items[elementIndex].value < items[i].value {
                elementIndex = i
            }
        }
        return elementIndex
    }

    mutating func enqueue(item: PriorityQueueArrayItem<T>) {
        items.append(item)
    }

    mutating func dequeue() -> PriorityQueueArrayItem<T> {
        return items.remove(at: peek())
    }
}

class PriorityQueueNodeItem<T> {
    var data: T
    var priority: Int
    var next: PriorityQueueNodeItem<T>?

    init(data: T, priority: Int, next: PriorityQueueNodeItem<T>? = nil) {
        self.data = data
        self.priority = priority
        self.next = next
    }
}

struct PriorityQueueLinkedList<T> {
    func peek(node: PriorityQueueNodeItem<T>) -> T {
        node.data
    }

    func push(head: PriorityQueueNodeItem<T>, data: T, priority: Int) -> PriorityQueueNodeItem<T> {
        var start = head
        var head = head
        let newNode = PriorityQueueNodeItem(data: data, priority: priority, next: nil)
        if start.priority < priority {
            newNode.next = head
            head = newNode
        } else {
            while start.next != nil && start.next!.priority >= priority {
                start = start.next!
            }
            newNode.next = start.next
            start.next = newNode
        }
        return head
    }

    func pop() {}
}
