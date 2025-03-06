//
//  TreeProblems.swift
//  DataStructuresSwift
//
//  Created by PRANAV PRAVAKAR on 08/04/20.
//  Copyright © 2020 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation

struct TreeProblems {
    func averageOfLevels(_ root: TreeNode<Int>?) -> [Double] {
        var queue = Queue<TreeNode<Int>>()
        guard let current = root else { return [] }
        var avg = [Double]()
        queue.enqueue(current)
        while !queue.isEmpty() {
            var count: Double = 0
            var sum: Double = 0
            var temp = Queue<TreeNode<Int>>()
            while !queue.isEmpty() {
                let node = queue.dequeue()!
                sum += Double(node.data)
                count += 1
                if let left = node.left {
                    temp.enqueue(left)
                }
                if let right = node.right {
                    temp.enqueue(right)
                }
            }
            queue = temp
            avg.append(sum / count)
        }
        return avg
    }

    func bstFromPreorder(_ preorder: [Int]) -> TreeNode<Int>? {
        guard !preorder.isEmpty else { return nil }
        let node = TreeNode<Int>(value: preorder[0])
        for i in 1..<preorder.count {
            insert(value: preorder[i], node: node)
        }
        return node
    }

    func insert(value: Int, node: TreeNode<Int>) {
        if value < node.data {
            if let left = node.left {
                insert(value: value, node: left)
            } else {
                node.left = TreeNode(value: value)
            }
        } else {
            if let right = node.right {
                insert(value: value, node: right)
            } else {
                node.right = TreeNode(value: value)
            }
        }
    }
}
