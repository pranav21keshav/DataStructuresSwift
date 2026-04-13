//
//  LFUCache.swift
//  DataStructuresSwift
//
//  Created by Pranav pravakar on 12/10/25.
//  Copyright © 2025 PRANAV PRAVAKAR. All rights reserved.
//

class LFUCache {
    class Node {
        var key: Int
        var value: Int
        var count: Int
        var next: Node?
        var previous: Node?

        init(key: Int, value: Int, next: Node? = nil, previous: Node? = nil) {
            self.key = key
            self.value = value
            self.count = 1
            self.next = next
            self.previous = previous
        }
    }

    class List {
        var size: Int
        var head: Node?
        var tail: Node?
    
        init(head: Node? = nil, tail: Node? = nil) {
            self.size = 0
            self.head = head ?? Node(key: -1, value: 0)
            self.tail = tail ?? Node(key: -1, value: 0)
            self.head?.next = self.tail
            self.tail?.previous = self.head
        }

        func add(node: Node) {
            node.next = head?.next
            node.previous = head
            head?.next?.previous = node
            head?.next = node
            size += 1
        }

        func delete(node: Node) {
            node.previous?.next = node.next
            node.next?.previous = node.previous
            // node.next = nil
            // node.previous = nil
            size -= 1
        }
    }

    var keyNode = [Int: Node]()
    var frequencyList = [Int: List]()
    var minFrequency = 0
    var capacity: Int
    var currentSize: Int

    init(_ capacity: Int) {
        self.capacity = capacity
        currentSize = 0
    }

    func get(_ key: Int) -> Int {
        if let node = keyNode[key] {
            // let value = node.value
            updateFrequencyList(node: node)
            return node.value
        }
        return -1
    }

    func put(_ key: Int, _ value: Int) {
        guard capacity != 0 else { return }

        if let node = keyNode[key] {
            node.value = value
            updateFrequencyList(node: node)
            return
        }
        if capacity == currentSize {
            let list = frequencyList[minFrequency]
            keyNode[list!.tail!.previous!.key] = nil
            list!.delete(node: list!.tail!.previous!)
            frequencyList[minFrequency] = list
            currentSize -= 1
        }
        minFrequency = 1
        let newFrequencyList: List
        if let freqList = frequencyList[minFrequency], freqList.size != 0 {
            newFrequencyList = freqList
        } else {
            newFrequencyList = List()
        }
        let node = Node(key: key, value: value)
        keyNode[key] = node
        newFrequencyList.add(node: node)
        frequencyList[minFrequency] = newFrequencyList
        currentSize += 1
    }

    private func updateFrequencyList(node: Node) {
        // var node = node
        // keyNode[node.key] = nil
        frequencyList[node.count]?.delete(node: node)
        if node.count == minFrequency && (frequencyList[minFrequency] == nil || frequencyList[minFrequency]!.size == 0) {
            minFrequency += 1
        }
        node.count += 1
        let newFrequencyList: List
        if let freqList = frequencyList[node.count], freqList.size != 0 {
            newFrequencyList = freqList
        } else {
            newFrequencyList = List()
        }
        newFrequencyList.add(node: node)
        frequencyList[node.count] = newFrequencyList
        // keyNode[node.key] = node

    }
}

extension LFUCache.Node: Hashable, Equatable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(key)
        hasher.combine(value)
        hasher.combine(count)
        hasher.combine(next)
        hasher.combine(previous)
    }

    static func == (lhs: LFUCache.Node, rhs: LFUCache.Node) -> Bool {
        lhs === rhs
    }
}

extension LFUCache.List: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(size)
        hasher.combine(head)
        hasher.combine(tail)
    }

    static func == (lhs: LFUCache.List, rhs: LFUCache.List) -> Bool {
        lhs === rhs
    }
}
