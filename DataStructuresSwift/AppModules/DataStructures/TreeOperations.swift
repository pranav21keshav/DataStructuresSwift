//
//  TreeOperations.swift
//  DataStructuresSwift
//
//  Created by PRANAV PRAVAKAR on 01/04/20.
//  Copyright © 2020 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation
struct TreeOperations<T: Comparable & Equatable> {
    init() {
        var binaryTreeRoot: TreeNode<T> = createIntBinaryTree()
        let traversal = inorderTraversal(binaryTreeRoot)
        print("Traveral - \(traversal)")
        let binaryTreeRoot1 = createIntBinaryTreeBalanced()
        let traversal1 = inorderTraversalResult(binaryTreeRoot)
        print("Traveral Closure - \(traversal1)")
        print("preOrder Morris - \(preOrderMorrisTraversal(root: binaryTreeRoot1))")
    }
    public  func createIntBinaryTree()-> TreeNode<T> {
        /*
                 1
                / \
               2   3
              / \
             4   5
         */
        let treeNode1: TreeNode<Int> = TreeNode(value: 1)
        treeNode1.left = TreeNode(value: 2)
        treeNode1.right = TreeNode(value: 3)
        treeNode1.left?.left = TreeNode(value: 4)
        treeNode1.left?.right = TreeNode(value: 5)
        return treeNode1 as! TreeNode<T>
    }

    public  func createIntBinaryTreeBalanced()-> TreeNode<T> {
        /*
                  1
                /   \
               2     3
              / \   /  \
             4   5 6    7
         */
        let treeNode1 = TreeNode(value: 1)
        treeNode1.left = TreeNode(value: 2)
        treeNode1.right = TreeNode(value: 3)
        treeNode1.left?.left = TreeNode(value: 4)
        treeNode1.left?.right = TreeNode(value: 5)
        treeNode1.right?.left = TreeNode(value: 6)
        treeNode1.right?.right = TreeNode(value: 7)
        return treeNode1 as! TreeNode<T>
    }

    func inorderTraversal(_ root: TreeNode<T>?) -> [T] {

        var result: [T] = []
        inOrderTraversalTraversalRecursionResultINOUT(root: root, result: &result)
        return result
    }
    func inorderTraversalResult(_ root: TreeNode<T>?) -> [T] {

        var result: [T] = []
        inOrderTraversalTraversalRecursionResult(root: root) {
            result.append($0)
        }
        return result
    }
    /*
    extension TreeNode {

        /**
        Will be called recursively
        until the whole tree is traversed.
        */
        func traverseInOrder(_ visit: (Int) -> Void) {

            // In order starts at the left node
            left?.traverseInOrder(visit)

            // Then the current value
            visit(val)

            // And last the right node
            right?.traverseInOrder(visit)
        }
    }*/
    func inOrderTraversalTraversalRecursionResultINOUT(root: TreeNode<T>?, result: inout [T]) {
        guard let root = root else { return }
        inOrderTraversalTraversalRecursionResultINOUT(root: root.left, result: &result)
        result.append(root.data)
        inOrderTraversalTraversalRecursionResultINOUT(root: root.right, result: &result)
    }

    func inOrderTraversalTraversalRecursionResult(root: TreeNode<T>?, result: ((T) -> Void)) {
        guard let root = root else { return }
        inOrderTraversalTraversalRecursionResult(root: root.left, result: result)
        result(root.data)
        inOrderTraversalTraversalRecursionResult(root: root.right, result: result)
    }

    func inOrderTraversalUsingRecusrion(root: TreeNode<T>?) {
        guard let root = root else { return }
        inOrderTraversalUsingRecusrion(root: root.left)
        print(root.data)
        inOrderTraversalUsingRecusrion(root: root.right)
    }
    func preOrderTraversalUsingRecursion(root: TreeNode<T>?) {
        guard let root = root else { return }
        print(root.data)
        preOrderTraversalUsingRecursion(root: root.left)
        preOrderTraversalUsingRecursion(root: root.right)
    }
    func postOrderTraversalUsingRecursion(root: TreeNode<T>?) {
        guard let root = root else { return }
        postOrderTraversalUsingRecursion(root: root.left)
        postOrderTraversalUsingRecursion(root: root.right)
        print(root.data)
    }

    // Level Order Traversal Recursive
    func getHeightOfBinaryTree(rootNode: TreeNode<T>?) -> Int {
        guard let root = rootNode else { return 0 }
        let lheight = getHeightOfBinaryTree(rootNode: root.left)
        let rheight = getHeightOfBinaryTree(rootNode: root.right)
        return (lheight > rheight) ? lheight + 1 : rheight + 1
    }

    func printGivenLevelOfBinaryTree(level: Int, root: TreeNode<T>?) {
        guard let root = root else { return }
        if level == 1 {
            print(root.data)
        } else {
            printGivenLevelOfBinaryTree(level: level - 1, root: root.left)
            printGivenLevelOfBinaryTree(level: level - 1, root: root.right)
        }
    }

    func levelOrderTraversalUsingRecursion(root: TreeNode<T>) {
        for i in 1...getHeightOfBinaryTree(rootNode: root) {
            printGivenLevelOfBinaryTree(level: i, root: root)
        }
    }

    func inOrderTraversalUsingStack(root: TreeNode<T>) {
        var current: TreeNode? = root
        var stack = Stack<TreeNode<T>>()
        while current != nil || !stack.isEmpty() {
            //Reach left most node of current node
            while current != nil {
                stack.push(current!)
                current = current!.left
            }
            //At this point current is nil so pop from stack
            current = stack.pop()
            print(current!.data)
            //As the left subtree has already been travelled to travel right subtree
            current = current?.right
        }
    }

    func preOrderTraversal(root: TreeNode<T>) {
        let current: TreeNode<T>? = root
        var stack = Stack<TreeNode<T>>()
        stack.push(current!)
        while !stack.isEmpty() {
            let node = stack.pop()!
            print(node.data)
            if let right = node.right {
                stack.push(right)
            }
            if let left = node.right {
                stack.push(left)
            }
        }
    }

    func preOrderTraversal2(root: TreeNode<T>) {
        var current: TreeNode<T>? = root
        var stack = Stack<TreeNode<T>>()
        while current != nil {
            // Print the data, push the right on stack and move to left
            while current != nil {
                print(current!.data)
                if current?.right != nil {
                    stack.push(current!.right!)
                }
                current = current?.left
            }
            // Once extreme left is reached, right is popped
            if !stack.isEmpty() {
                current = stack.pop()
            }
        }
    }

    func postOrderTraversal(root: TreeNode<T>) {
        var current: TreeNode<T>? = root
        var tempStack = Stack<TreeNode<T>>()
        var orderedStack = Stack<TreeNode<T>>()
        tempStack.push(current!)
        while !tempStack.isEmpty() {
            current = tempStack.pop()
            orderedStack.push(current!)

            if let right = current?.right {
                tempStack.push(right)
            }

            if let left = current?.left {
                tempStack.push(left)
            }
        }
    }

    func inorderMorrisTraversal(root: TreeNode<T>?) -> [T] {
        var result = [T]()
        var current = root
        if current == nil {
            return result
        }
        while current != nil {
            if current?.left == nil {
                result.append(current!.data)
                current = current?.right
            } else {
                var pred = current?.left
                while pred?.right != nil && pred?.right !== current {
                    pred = pred?.right
                }
                if pred?.right === current {
                    result.append(current!.data)
                    pred?.right = nil
                    current = current?.right
                } else {
                    pred?.right = current
                    current = current?.left
                }
            }
        }
        return result

    }
    func preOrderMorrisTraversal(root: TreeNode<T>?) {
        var current: TreeNode<T>? = root
        if root == nil {
            return
        }

        while current != nil {
            if current?.left == nil {
                print(current?.data)
                current = current?.right
            } else {
                var pred = current?.left
                while pred?.right != nil && pred?.right !== current {
                    pred = pred?.right
                }
                if pred?.right === current {
                    pred?.right = nil
                    current = current?.right
                } else {
                    print(current?.data)
                    pred?.right = current
                    current = current?.left
                }
            }
        }

    }

    func levelOrderTraversalUsingQueue(root: TreeNode<T>?) {
        guard let root = root else { return }
        var queue = Queue<TreeNode<T>>()
        queue.enqueue(root)
        while !queue.isEmpty() {
            let element = queue.dequeue()!
            print(element.data, separator: ", ")
            if let left = root.left {
                queue.enqueue(left)
            }
            if let right = root.right {
                queue.enqueue(right)
            }
        }
    }
}
