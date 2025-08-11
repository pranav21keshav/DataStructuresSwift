//
//  TreeProblems.swift
//  DataStructuresSwift
//
//  Created by PRANAV PRAVAKAR on 08/04/20.
//  Copyright © 2020 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation

class TreeProblems<T: Comparable & Hashable> {

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

    var solution = [[Int]]()

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

    func diameterOfTree(root: TreeNode<Int>?) -> Int {
        var max = 0
        widthOfTree(root: root, maximum: &max)
        return max
    }

    @discardableResult
    func widthOfTree(root: TreeNode<Int>?, maximum: inout Int) -> Int {
        guard let root = root else { return 0 }

        let lh = widthOfTree(root: root.left, maximum: &maximum)
        let rh = widthOfTree(root: root.right, maximum: &maximum)

        maximum = max(maximum, lh + rh)

        return 1 + max(lh, rh)
    }

    func isSameTree(p: TreeNode<T>?, q: TreeNode<T>?) -> Bool {
        if p == nil && q == nil {
            return true
        }
        if p == nil || q == nil {
            return false
        }

        if p?.data != q?.data {
            return false
        }

        return isSameTree(p: p?.left, q: q?.left) && isSameTree(p: p?.right, q: q?.right)

    }

    func zigzagLevelOrder(_ root: TreeNode<Int>?) -> [[Int]] {
        var result = [[Int]]()
        guard let root = root else { return result }
        var queue = [TreeNode<Int>]()
        queue.append(root)
        var leftToRight = true
        while !queue.isEmpty {
            let size = queue.count
            var currentRow = Array(repeating: -1, count: size)
            for i in 0..<size {
                let node = queue.removeFirst()
                let index = leftToRight ? i : size - i - 1
                currentRow[index] = node.data
                if let left = node.left {
                    queue.append(left)
                }
                if let right = node.right {
                    queue.append(right)
                }
            }
            result.append(currentRow)
            leftToRight.toggle()
        }
        return result

    }

    /*
     The boundary of a binary tree is the concatenation of the root, the left boundary, the leaves ordered from left-to-right, and the reverse order of the right boundary.

     The left boundary is the set of nodes defined by the following:

     The root node's left child is in the left boundary. If the root does not have a left child, then the left boundary is empty.
     If a node in the left boundary and has a left child, then the left child is in the left boundary.
     If a node is in the left boundary, has no left child, but has a right child, then the right child is in the left boundary.
     The leftmost leaf is not in the left boundary.
     The right boundary is similar to the left boundary, except it is the right side of the root's right subtree. Again, the leaf is not part of the right boundary, and the right boundary is empty if the root does not have a right child.

     The leaves are nodes that do not have any children. For this problem, the root is not a leaf.

     Given the root of a binary tree, return the values of its boundary.



     Example 1:


     Input: root = [1,null,2,3,4]
     Output: [1,3,4,2]
     Explanation:
     - The left boundary is empty because the root does not have a left child.
     - The right boundary follows the path starting from the root's right child 2 -> 4.
       4 is a leaf, so the right boundary is [2].
     - The leaves from left to right are [3,4].
     Concatenating everything results in [1] + [] + [3,4] + [2] = [1,3,4,2].
     Example 2:


     Input: root = [1,2,3,4,5,6,null,null,null,7,8,9,10]
     Output: [1,2,4,7,8,9,10,6,3]
     Explanation:
     - The left boundary follows the path starting from the root's left child 2 -> 4.
       4 is a leaf, so the left boundary is [2].
     - The right boundary follows the path starting from the root's right child 3 -> 6 -> 10.
       10 is a leaf, so the right boundary is [3,6], and in reverse order is [6,3].
     - The leaves from left to right are [4,7,8,9,10].
     Concatenating everything results in [1] + [2] + [4,7,8,9,10] + [6,3] = [1,2,4,7,8,9,10,6,3].


     Constraints:

     The number of nodes in the tree is in the range [1, 104].
     -1000 <= Node.val <= 1000
     */
    func boundaryOfBinaryTree(_ root: TreeNode<T>?) -> [T] {
        if root == nil {
            return []
        }
        var result = [T]()
        if root?.isLeaf == false {
            result.append(root!.data)
        }
        addLeftBoundary(root: root?.left, result: &result)
        addLeaves(root: root!, result: &result)
        addRightBoundary(root: root?.right, result: &result)

        return result

    }

    private func addLeftBoundary(root: TreeNode<T>?, result: inout [T]) {
        var current = root
        while current != nil {
            if current?.isLeaf == false {
                result.append(current!.data)
            }

            current = current?.left ?? current?.right
        }
    }

    private func addLeaves(root: TreeNode<T>, result: inout [T]) {
        if root.isLeaf {
            result.append(root.data)
        }
        if let left = root.left {
            addLeaves(root: left, result: &result)
        }
        if let right = root.right {
            addLeaves(root: right, result: &result)
        }
    }

    private func addRightBoundary(root: TreeNode<T>?, result: inout [T]) {
        var temp = [T]()
        var current = root
        while current != nil {
            if current?.isLeaf == false {
                temp.append(current!.data)
            }
            current = current?.right ?? current?.left
        }
        for i in stride(from: temp.count - 1, through: 0, by: -1) {
            result.append(temp[i])
        }
    }

    /*
     Given the root of a binary tree, calculate the vertical order traversal of the binary tree.

     For each node at position (row, col), its left and right children will be at positions (row + 1, col - 1) and (row + 1, col + 1) respectively.
     The root of the tree is at (0, 0).

     The vertical order traversal of a binary tree is a list of top-to-bottom orderings for each column index starting from the leftmost column and ending on the rightmost column. There may be multiple nodes in the same row and same column. In such a case, sort these nodes by their values.

     Return the vertical order traversal of the binary tree.

     Example 1:


     Input: root = [3,9,20,null,null,15,7]
     Output: [[9],[3,15],[20],[7]]
     Explanation:
     Column -1: Only node 9 is in this column.
     Column 0: Nodes 3 and 15 are in this column in that order from top to bottom.
     Column 1: Only node 20 is in this column.
     Column 2: Only node 7 is in this column.
     Example 2:


     Input: root = [1,2,3,4,5,6,7]
     Output: [[4],[2],[1,5,6],[3],[7]]
     Explanation:
     Column -2: Only node 4 is in this column.
     Column -1: Only node 2 is in this column.
     Column 0: Nodes 1, 5, and 6 are in this column.
               1 is at the top, so it comes first.
               5 and 6 are at the same position (2, 0), so we order them by their value, 5 before 6.
     Column 1: Only node 3 is in this column.
     Column 2: Only node 7 is in this column.
     Example 3:


     Input: root = [1,2,3,4,6,5,7]
     Output: [[4],[2],[1,5,6],[3],[7]]
     Explanation:
     This case is the exact same as example 2, but with nodes 5 and 6 swapped.
     Note that the solution remains the same since 5 and 6 are in the same location and should be ordered by their values.

     Example 4:

     Input: root =[3,1,4,0,2,2]
     Output: [[0],[1],[3,2,2],[4]]


     */
    var maxColumn = 0
    var minColumn = 0

    func verticalTraversal(_ root: TreeNode<T>?) -> [[T]] {
        guard let root = root else { return [[T]]() }

        var result = [[T]]()
        let levels = bfs(root: root)
        for i in stride(from: minColumn, through: maxColumn, by: 1) {
            var levelData = levels[i]!
            levelData.sort { $0.first!.key == $1.first!.key ? $0.first!.value < $1.first!.value : $0.first!.key < $1.first!.key }
            var levelInfo = [T]()
            for data in levelData {
                levelInfo.append(data.values.first!)
            }
            result.append(levelInfo)
        }
        return result

    }

    func bfs(root: TreeNode<T>) -> [Int: [[Int: T]]] {
        var verticalInfo = [Int: [[Int: T]]]()
        var queue = [[TreeNode<T>: [Int: Int]]]()
        var row = 0
        var column = 0
        queue.append([root: [column: row]])

        while !queue.isEmpty {
            let data = queue.removeFirst()
            let node = data.keys.first!
            column = data.values.first!.keys.first!
            row = data.values.first!.values.first!
            if verticalInfo[column] == nil {
                verticalInfo[column] = [[Int: T]]()
            }
            verticalInfo[column]!.append([row: node.data])
            maxColumn = max(column, maxColumn)
            minColumn = min(column, minColumn)

            if let left = node.left {
                queue.append([left: [column - 1: row + 1]])
            }
            if let right = node.right {
                queue.append([right: [column + 1: row + 1]])
            }
        }
        return verticalInfo
    }

    // TC - O(n)
    // SC - O(n)
    func topView(root: TreeNode<T>?) -> [T] {
        guard let root = root else { return [T]() }
        var result = [T]()
        var minColumn = 0
        var maxColumn = 0
        var topViewInfo = [Int: T]()
        var queue = [[TreeNode<T>: Int]]()
        queue.append([root: 0])
        while !queue.isEmpty {
            let columnData = queue.removeFirst()
            let node = columnData.first!.key
            let column = columnData.first!.value

            if topViewInfo[column] == nil {
                topViewInfo[column] = node.data
            }
            minColumn = min(minColumn, column)
            maxColumn = max(maxColumn, column)
            if let left = node.left {
                queue.append([left: column - 1])
            }
            if let right = node.right {
                queue.append([right: column + 1])
            }
        }
        for i in stride(from: minColumn, through: maxColumn, by: 1) {
            result.append(topViewInfo[i]!)
        }

        return result
    }

    func bottomView(root: TreeNode<T>?) -> [T] {
        guard let root = root else {
            return [T]()
        }
        var result = [T]()
        var bottomViewInfo = [Int: T]()
        var minColumn = 0
        var maxColumn = 0
        var queue = [[root: 0]]
        while !queue.isEmpty {
            let columnData = queue.removeFirst()
            let node = columnData.first!.key
            let column = columnData.first!.value
            bottomViewInfo[column] = node.data
            maxColumn = max(maxColumn, column)
            minColumn = min(minColumn, column)
            if let left = root.left {
                queue.append([left: column - 1])
            }
            if let right = root.right {
                queue.append([right: column + 1])
            }
        }
        for i in stride(from: minColumn, through: maxColumn, by: 1) {
            result.append(bottomViewInfo[i]!)
        }
        return result

    }

    func rightView(root: TreeNode<T>?) -> [T] {
        if root == nil {
            return [T]()
        }
        var result = [T]()
        rightViewDFS(root: root, level: 0, result: &result)
        return result
    }

    private func rightViewDFS(root: TreeNode<T>?, level: Int, result: inout [T]) {
        guard let root = root else {
             return
        }
        if level == result.count {
            result.append(root.data)
        }
        if let right = root.right {
            rightViewDFS(root: root, level: level + 1, result: &result)
        }
        if let left = root.left {
            rightViewDFS(root: root, level: level + 1, result: &result)
        }

    }

    func leftView(root: TreeNode<T>?) -> [T] {
        if root == nil {
            return [T]()
        }
        var result = [T]()
        leftViewDFS(root: root, level: 0, result: &result)
        return result
    }

    private func leftViewDFS(root: TreeNode<T>?, level: Int, result: inout [T]) {
        guard let root = root else { return }

        if result.count == level {
            result.append(root.data)
        }
        if let left = root.left {
            leftViewDFS(root: root, level: level + 1, result: &result)
        }
        if let right = root.right {
            leftViewDFS(root: root, level: level + 1, result: &result)
        }

    }

    func isTreeSymmetrical(root: TreeNode<T>?) -> Bool {
        guard let root = root else { return true }
        return isTreeSymmetrical(left: root.left, right: root.right)
    }

    private func isTreeSymmetrical(left: TreeNode<T>?, right: TreeNode<T>?) -> Bool {
        if left == nil || right == nil {
            return left == right
        }
        if left?.data != right?.data {
            return false
        }
        return isTreeSymmetrical(left: left?.left, right: right?.right) && isTreeSymmetrical(left: left?.right, right: right?.left)
    }

    func findRootToNodePath(root: TreeNode<T>?, destination: T) -> [T] {
        guard let root = root else { return [T]() }
        var result = [T]()
        getPath(root: root, path: &result, destination: destination)
        return result
    }

    private func getPath(root: TreeNode<T>?, path: inout [T], destination: T) -> Bool {
        guard let root = root else { return false }

        path.append(root.data)
        if root.data == destination {
            return true
        }
        let result = getPath(root: root, path: &path, destination: destination)
        if !result {
            path.removeLast()
        }
        return result
    }

    func lowestCommonAncestorBinaryTree(root: TreeNode<T>?, p: TreeNode<T>?, q: TreeNode<T>?) -> TreeNode<T>? {
        if root == nil || root === p || root === q {
            return root
        }

        let left = lowestCommonAncestorBinaryTree(root: root?.left, p: p, q: q)
        let right = lowestCommonAncestorBinaryTree(root: root?.right, p: p, q: q)
        if left == nil {
            return right
        }
        if right == nil {
            return left
        }
        return root
    }

    func lowestCommonAncestorBSTRecursion(_ root: TreeNode<T>?, _ p: TreeNode<T>?, _ q: TreeNode<T>?) -> TreeNode<T>? {
        guard let node = root else { return nil }
        let rootValue = node.data
        let pValue = p!.data
        let qValue = q!.data
        if pValue > rootValue && qValue > rootValue {
            return lowestCommonAncestorBSTRecursion(node.right, p, q)
        } else if pValue < rootValue && qValue < rootValue {
            return lowestCommonAncestorBSTRecursion(node.left, p, q)
        } else {
            return node
        }
    }

    func lowestCommonAncestorBSTIterative(_ root: TreeNode<T>?, _ p: TreeNode<T>?, _ q: TreeNode<T>?) -> TreeNode<T>? {
        var node = root

        let pValue = p!.data
        let qValue = q!.data
        while node != nil {
            let rootValue = node!.data
            if pValue > rootValue && qValue > rootValue {
                node = node?.right
            } else if pValue < rootValue && qValue < rootValue {
                node = node?.left
            } else {
                return node
            }
        }
        return nil
    }

    /*
     Given the root of a binary tree, return the maximum width of the given tree.

     The maximum width of a tree is the maximum width among all levels.

     The width of one level is defined as the length between the end-nodes (the leftmost and rightmost non-null nodes), where the null nodes between the end-nodes that would be present in a complete binary tree extending down to that level are also counted into the length calculation.

     It is guaranteed that the answer will in the range of a 32-bit signed integer.



     Example 1:


     Input: root = [1,3,2,5,3,null,9]
     Output: 4
     Explanation: The maximum width exists in the third level with length 4 (5,3,null,9).


     Example 2:


     Input: root = [1,3,2,5,null,null,9,6,null,7]
     Output: 7
     Explanation: The maximum width exists in the fourth level with length 7 (6,null,null,null,null,null,7).


     Example 3:


     Input: root = [1,3,2,5]
     Output: 2
     Explanation: The maximum width exists in the second level with length 2 (3,2).

     Example 4:

     Input: root = [0,0,0,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null,null,0,0,null]

     Output: 2

     Constraints:

     The number of nodes in the tree is in the range [1, 3000].
     -100 <= Node.val <= 100


     */
    func widthOfBinaryTree(_ root: TreeNode<T>?) -> Int {
        guard let root = root else {
            return 0
        }
        var queue = [[TreeNode<T>: Int]]()
        queue.append([root: 0])
        var result = 0
        while !queue.isEmpty {
            let size = queue.count
            // var first = 0
            // var last = 0
            let min = queue.first!.first!.value
            var nodeInfo: [TreeNode<T>: Int]?
            for _ in stride(from: 0, through: size - 1, by: 1) {
                nodeInfo = queue.removeFirst()
                let current = nodeInfo!.first!.value - min
                let node = nodeInfo!.first!.key
                // if i == 0 {
                //     first = current
                // }
                // if i == size - 1 {
                //     last = current
                // }
                if let left = node.left {
                    queue.append([left: 2 * current ])
                }
                if let right = node.right {
                    queue.append([right: 2 * current + 1])
                }

            }
            result = max(result, nodeInfo!.first!.value - min + 1)

        }
        return result
    }

    /*
     Children sum property in a binary tree
     
     */
}
