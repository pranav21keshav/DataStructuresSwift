//
//  BinarySearchTree.swift
//  DataStructuresSwift
//
//  Created by Pranav Pravakar on 12/06/24.
//  Copyright © 2024 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation
class BinarySearchTree<T: Comparable> {
    var root: TreeNode<T>?

    init(root: TreeNode<T>? = nil) {
        self.root = root
    }

    private func minValueNode(node: TreeNode<T>) -> TreeNode<T> {
        var current = node
        while current.left != nil {
            current = current.left!
        }

        return current
    }

    func insert(node: TreeNode<T>?, data: T) -> TreeNode<T> {
        if node == nil {
            let newNode = TreeNode<T>(value: data)
            return newNode
        }
        if data < node!.data {
            node?.left = insert(node: node?.left, data: data)
        } else {
            node?.right = insert(node: node?.right, data: data)
        }

        return node!
    }

    func search(node: TreeNode<T>?, data: T) -> TreeNode<T>? {
        if node == nil || node?.data == data {
            return node
        }

        if data < node!.data {
            return search(node: node?.left, data: data)
        }

        return search(node: node?.right, data: data)
    }

    /*
    func delete(node: TreeNode<T>?, data: T) -> TreeNode<T>? {
        if node == nil {
            return node
        }

        if data < node!.data {
            return delete(node: node, data: data)
        } else if data > node!.data {
            return delete(node: node, data: data)
        } else {
            if node?.left == nil {
                let temp = TreeNode(value: node?.data, )
            }
        }
    }*/
}
