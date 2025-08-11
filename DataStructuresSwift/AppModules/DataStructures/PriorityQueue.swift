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

    // O(n)
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

    // O(1)
    mutating func enqueue(item: PriorityQueueArrayItem<T>) {
        items.append(item)
    }

    // O(n)
    mutating func dequeue() -> PriorityQueueArrayItem<T>? {
        let index = peek()
        if index != -1 {
            return items.remove(at: peek())
        }
        return nil
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
    var head: PriorityQueueNodeItem<T>?
    
    func peek() -> T? {
        head?.data
    }

    //O(n)
    mutating func push(data: T, priority: Int) {
        let newNode = PriorityQueueNodeItem(data: data, priority: priority, next: nil)

        if head == nil {
            head = newNode
        } else if head!.priority < priority {
            newNode.next = head
            head = newNode
        } else {
            var start = head
            while start?.next != nil && start!.next!.priority >= priority {
                start = start?.next
            }
            newNode.next = start?.next
            start?.next = newNode
        }

    }

    // O(1)
    mutating func pop() -> T? {
        let data = head?.data
        head = head?.next
        return data

    }
}
