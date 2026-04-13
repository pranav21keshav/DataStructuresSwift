//
//  LRUCache.swift
//  DataStructuresSwift
//
//  Created by Pranav pravakar on 05/10/25.
//  Copyright © 2025 PRANAV PRAVAKAR. All rights reserved.
//

class LRUCache {
    class Node {
        var key: Int
        var value: Int
        var next: Node?
        var previous: Node?

        init(key: Int, value: Int, next: Node? = nil, previous: Node? = nil) {
            self.key = key
            self.value = value
            self.next = next
            self.previous = previous
        }
    }

    var head: Node?
    var tail: Node?
    let capacity: Int
    var map = [Int: Node]()

    init(_ capacity: Int) {
        self.capacity = capacity
        head = Node(key: -1, value: -1, next: nil, previous: nil)
        tail = Node(key: -1, value: -1, next: nil, previous: nil)
        head?.next = tail
        tail?.previous = head
    }

    func get(_ key: Int) -> Int {
        guard let node = map[key] else {
            return -1
        }
        delete(node: node)
        insert(node: node)
        return node.value
    }

    func put(_ key: Int, _ value: Int) {
        if let node = map[key] {
            delete(node: node)
            node.value = value
            insert(node: node)
        } else if map.count == capacity {
            delete(node: tail!.previous!)
            let node = Node(key: key, value: value, next: nil, previous: nil)
            insert(node: node)
        } else {
            let node = Node(key: key, value: value, next: nil, previous: nil)
            insert(node: node)
        }
    }

    private func delete(node: Node) {
        let previous = node.previous
        let next = node.next
        previous?.next = next
        next?.previous = previous
        node.next = nil
        node.previous = nil
        map[node.key] = nil
    }

    private func insert(node: Node) {
        let next = head?.next
        node.next = next
        node.previous = head
        next?.previous = node
        head?.next = node
        map[node.key] = node
    }
}

extension LRUCache.Node: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(key)
        hasher.combine(value)
        hasher.combine(next)
        hasher.combine(previous)
    }
}

extension LRUCache.Node: Equatable {
    static func == (lhs: LRUCache.Node, rhs: LRUCache.Node) -> Bool {
        lhs === rhs
    }
}
