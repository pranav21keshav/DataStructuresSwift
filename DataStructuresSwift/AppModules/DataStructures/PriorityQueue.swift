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

struct PriorityQueueHeapItem<T: Hashable & Comparable, U: Hashable & Comparable> {
    var x: T
    var y: U
}

extension PriorityQueueHeapItem: Comparable {
    static func < (lhs: PriorityQueueHeapItem<T, U>, rhs: PriorityQueueHeapItem<T, U>) -> Bool {
        if lhs.x == rhs.x {
            return lhs.y < rhs.y
        }
        return lhs.x < rhs.x
    }
}

extension PriorityQueueHeapItem: Hashable {}

struct PriorityQueueHeap<T: Hashable & Comparable> {
    private let capacity: Int
    private var elements: [T]
    var size = 0

    init(capacity: Int) {
        self.capacity = capacity
        elements = [T]()
    }

    func left(index: Int) -> Int {
        (2 * index) + 1
    }

    func right(index: Int) -> Int {
        (2 * index) + 2
    }

    func parent(index: Int) -> Int {
        (index - 1) / 2
    }

    var isEmpty: Bool {
        return elements.isEmpty
    }

    var count: Int {
        return elements.count
    }

    func peek() -> T? {
      return elements.first
    }

    mutating func insert(value: T) {
        if size == capacity {
            return
        }
        elements.append(value)
        var k = size
        size += 1
        while k > 0 && elements[k] >= elements[parent(index: k)] {
            elements.swapAt(k, parent(index: k))
            k = parent(index: k)
        }
    }

    mutating private func heapify(index: Int) {
        let leftIndex = left(index: index)
        let rightIndex = right(index: index)
        var maxIndex = index
        if leftIndex < size && elements[leftIndex] < elements[maxIndex] {
            maxIndex = leftIndex
        }
        if rightIndex < size && elements[rightIndex] < elements[maxIndex] {
            maxIndex = rightIndex
        }

        if maxIndex != index {
            elements.swapAt(maxIndex, index)
            heapify(index: maxIndex)
        }
    }

    mutating func shiftDown(index: Int) {
        var maxIndex = index
        let left = left(index: index)
        let right = right(index: index)
        if left < size && elements[left] > elements[maxIndex] {
            maxIndex = left
        }

        if right < size && elements[right] > elements[maxIndex] {
            maxIndex = right
        }
        if maxIndex != index {
            elements.swapAt(maxIndex, index)
            shiftDown(index: maxIndex)
        }
    }

    mutating func remove() -> T? {
        if size == 0 {
            return nil
        }
        if size == 1 {
            size -= 1
            return elements.removeLast()
        }
        let element = elements[0]
        elements[0] = elements[size - 1]
        elements.removeLast()
        size -= 1
//        shiftDown(index: 0)
        heapify(index: 0)
        return element
    }

    func top() -> T? {
        elements.first
    }
}
