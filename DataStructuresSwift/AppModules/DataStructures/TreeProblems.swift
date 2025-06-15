//
//  TreeProblems.swift
//  DataStructuresSwift
//
//  Created by PRANAV PRAVAKAR on 08/04/20.
//  Copyright © 2020 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation

class TreeProblems {
    var solution = [[Int]]()

    init(solution: [[Int]] = [[Int]]()) {
        self.solution = solution
        var root: TreeNode<Int>? = createIntBinaryTree()
        print("Find Leaves - \(findLeaves(&root)), root - \(root)" )
    }

    public  func createIntBinaryTree() -> TreeNode<Int> {
        /*
                  1
                /   \
               2     3
              / \
             4   5
         */
        let treeNode1 = TreeNode(value: 1)
        treeNode1.left = TreeNode(value: 2)
        treeNode1.right = TreeNode(value: 3)
        treeNode1.left?.left = TreeNode(value: 4)
        treeNode1.left?.right = TreeNode(value: 5)

        return treeNode1
    }
    /*
     Given the root of a binary tree, return the average value of the nodes on each level in the form of an array. Answers within 10-5 of the actual answer will be accepted.


     Example 1:


     Input: root = [3,9,20,null,null,15,7]
     Output: [3.00000,14.50000,11.00000]
     Explanation: The average value of nodes on level 0 is 3, on level 1 is 14.5, and on level 2 is 11.
     Hence return [3, 14.5, 11].
     Example 2:


     Input: root = [3,9,20,15,7]
     Output: [3.00000,14.50000,11.00000]


     Constraints:

     The number of nodes in the tree is in the range [1, 104].
     -231 <= Node.val <= 231 - 1
     */
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
    /*
     Given the root of a binary tree and an integer targetSum, return true if the tree has a root-to-leaf path such that adding up all the values along the path equals targetSum.

     A leaf is a node with no children.



     Example 1:


     Input: root = [5,4,8,11,null,13,4,7,2,null,null,null,1], targetSum = 22
     Output: true
     Explanation: The root-to-leaf path with the target sum is shown.
     Example 2:


     Input: root = [1,2,3], targetSum = 5
     Output: false
     Explanation: There are two root-to-leaf paths in the tree:
     (1 --> 2): The sum is 3.
     (1 --> 3): The sum is 4.
     There is no root-to-leaf path with sum = 5.
     Example 3:

     Input: root = [], targetSum = 0
     Output: false
     Explanation: Since the tree is empty, there are no root-to-leaf paths.


     Constraints:

     The number of nodes in the tree is in the range [0, 5000].
     -1000 <= Node.val <= 1000
     -1000 <= targetSum <= 1000
     */

    func hasPathSum(_ root: TreeNode<Int>?, _ targetSum: Int) -> Bool {
        guard let root = root else {
            return false
        }
        let remaining = targetSum - root.data
        if remaining == 0 && root.left == nil && root.right == nil {
            return true
        }
        var left = false
        var right = false
        if root.left != nil {
            left = hasPathSum(root.left, remaining)
        }
        if root.right != nil {
            right = hasPathSum(root.right, remaining)
        }
        return left || right
    }

    /*
     Find Leaves of Binary Tree

    Given the root of a binary tree, collect a tree's nodes as if you were doing this:

    Collect all the leaf nodes.
    Remove all the leaf nodes.
    Repeat until the tree is empty.

     Input: root = [1,2,3,4,5]
     Output: [[4,5,3],[2],[1]]
     Explanation:
     [[3,5,4],[2],[1]] and [[3,4,5],[2],[1]] are also considered correct answers since per each level it does not matter the order on which elements are returned.
     Example 2:

     Input: root = [1]
     Output: [[1]]


     Constraints:

     The number of nodes in the tree is in the range [1, 100].
     -100 <= Node.val <= 100

     */

    func findLeaves(_ root: inout TreeNode<Int>?) -> [[Int]] {
        findHeight(root: &root)
        return solution
    }

    @discardableResult
    func findHeight(root: inout  TreeNode<Int>?) -> Int {
        if root == nil {
            return -1
        }

        let leftHeight = findHeight(root: &root!.left)
        let rightHeight = findHeight(root: &root!.right)

        let height = max(leftHeight, rightHeight) + 1
        if solution.count == height {
            solution.insert([Int](), at: height)
        }
        solution[height].append(root!.data)
        root = nil
        return height
    }
}
