//
//  Heap.swift
//  DataStructuresSwift
//
//  Created by Pranav pravakar on 09/06/25.
//  Copyright © 2025 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation
struct Heap<T: Comparable> {
    var elements: [T]
    let priority: (T, T) -> Bool

    init(priority: @escaping (T, T) -> Bool) {
        self.priority = priority
        self.elements = [T]()
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

    func isRoot(_ index: Int) -> Bool {
      return (index == 0)
    }

    func leftChildIndex(of index: Int) -> Int {
      return (2 * index) + 1
    }

    func rightChildIndex(of index: Int) -> Int {
      return (2 * index) + 2
    }

    func parentIndex(of index: Int) -> Int {
      return (index - 1) / 2
    }

    func isHigherPriority(at firstIndex: Int, than secondIndex: Int) -> Bool {
      return priority(elements[firstIndex], elements[secondIndex])
    }
}

struct MinHeap<T: Comparable> {
    var elements: [T]

    var isEmpty: Bool {
        return elements.isEmpty
    }

    var count: Int {
        return elements.count
    }

    func peek() -> T? {
      return elements.first
    }

    func isRoot(_ index: Int) -> Bool {
      return (index == 0)
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

    let capacity: Int
    private var size: Int

    init(capacity: Int) {
        self.capacity = capacity
        elements = [T]()
        size = 0
    }

    func getMin() -> T? {
        elements.first
    }

    /*
     -  Insert the key on the last index. Insert on last level on the left most side. If last level is full, insert on next level. This helps to maintain complete binary tree
     -  Check if parent is more than the inserted node. If yes then min heap property is violated. Swap the node's value with it's parent unless parent is less
     -  TC - O (log N)
     */
    mutating func insert(key: T) {
        if size == capacity {
            return
        }
        elements.append(key)
        size += 1

//        var k = size - 1
        var k = elements.count - 1
        while k > 0 && elements[k] < elements[parent(index: k)] {
            elements.swapAt(k, parent(index: k))
            k = parent(index: k)
        }
    }

    /*
     -  Update the value at a given key or index
     -  As the new values is less, min heap property of child is not violated but for parent it can be
     -  Compare the value of current node with parent and keep on replacing till it is lesser than parent
     -  TC - O (log N)
     */
    mutating func decrease(value: T, index: Int) {
        if index >= size {
            return
        }
        elements[index] = value
        var k = index
        while k != 0 && elements[k] < elements[parent(index: k)] {
            elements.swapAt(k, parent(index: k))
            k = parent(index: k)
        }
    }

    /*
     -  Restore the heap at given node
     -  Find the minimum between left and right child for given index
     -  If left is minimum, swap the node wih left and call heapify again on left
     -  If right is minimum, swap the node with right and call heapify again on right
     -  TC - O (log N)
     */
    mutating private func heapify(index: Int) {
        let leftIndex = left(index: index)
        let rightIndex = right(index: index)
        var smallest = index
        if leftIndex < elements.count && elements[leftIndex] < elements[smallest] {
            smallest = leftIndex
        }
        if rightIndex < elements.count && elements[rightIndex] < elements[smallest] {
            smallest = rightIndex
        }

        if smallest != index {
            elements.swapAt(smallest, index)
            heapify(index: smallest)
        }
    }

    /*
     -  Removes the minimum value
     -  Take the value at node and replace it with last value, decrease size by 1
     -  Call heapify at 0
     */
    mutating func remove() -> T? {
        if elements.isEmpty {
            return nil
        }
        if elements.count == 1 {
            size -= 1
            return elements.removeLast()
        }
        let element = elements[0]
        elements[0] = elements[size - 1]
        elements.removeLast()
//        elements[0] = elements[elements.count - 1]
        size -= 1
        heapify(index: 0)

        return element
    }

    mutating func delete(key: T) {
        var indexToDelete = -1
        for (index, value) in elements.enumerated() where value == key {
            indexToDelete = index
            break
        }
        if indexToDelete == -1 {
            return
        }
        elements[indexToDelete] = elements[size - 1]
        size -= 1
        heapify(index: indexToDelete)
    }
}

struct MaxHeap<T: Comparable> {
    var elements: [T]

    var isEmpty: Bool {
        return elements.isEmpty
    }

    var count: Int {
        return elements.count
    }

    func peek() -> T? {
      return elements.first
    }

    func isRoot(_ index: Int) -> Bool {
      return (index == 0)
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

    let capacity: Int
    var size = 0

    init(capacity: Int, initialValue: T) {
        self.capacity = capacity
        elements = [T](repeating: initialValue, count: capacity)
    }

    func getMax() -> T? {
        elements.first
    }

    mutating func insert(key: T) {
        if size == capacity {
            return
        }
        elements[size] = key
        size += 1

        var k = size - 1
        while k > 0 && elements[k] > elements[parent(index: k)] {
            elements.swapAt(k, parent(index: k))
            k = parent(index: k)
        }
    }

    mutating func increase(value: T, index: Int) {
        if index >= size {
            return
        }
        elements[index] = value
        var k = index
        while k != 0 && elements[k] > elements[parent(index: k)] {
            elements.swapAt(k, parent(index: k))
            k = parent(index: k)
        }
    }

    mutating private func heapify(index: Int) {
        let leftIndex = left(index: index)
        let rightIndex = right(index: index)
        var largest = index
        if leftIndex < size && elements[leftIndex] > elements[largest] {
            largest = leftIndex
        }
        if rightIndex < size && elements[rightIndex] > elements[largest] {
            largest = rightIndex
        }

        if largest != index {
            elements.swapAt(largest, index)
            heapify(index: largest)
        }
    }

    mutating func extractMax() -> T? {
        if elements.isEmpty {
            return nil
        }
        if elements.count == 1 {
            size -= 1
            return elements[size]
        }
        let element = elements[0]
        elements[0] = elements[size - 1]
        size -= 1
        heapify(index: 0)

        return element
    }

    mutating func delete(key: T) {
        var indexToDelete = -1
        for (index, value) in elements.enumerated() {
            if value == key {
                indexToDelete = index
                break
            }
        }
        if indexToDelete == -1 {
            return
        }
        elements[indexToDelete] = elements[size - 1]
        size -= 1
        heapify(index: indexToDelete)
    }
}
