//
//  TreeProblems.swift
//  DataStructuresSwift
//
//  Created by PRANAV PRAVAKAR on 08/04/20.
//  Copyright © 2020 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation

// swiftlint:disable file_length
class TreeProblems<T: Comparable & Hashable> {

    init(solution: [[Int]] = [[Int]]()) {
        self.solution = solution
        var root: TreeNode<Int>? = createIntBinaryTree()
        print("Find Leaves - \(findLeaves(&root)), root - \(root)" )
        var root2: TreeNode<Int>? = createIntBinaryTree2()
        print(countNodes(root2))
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

    public  func createIntBinaryTree2() -> TreeNode<Int> {
        /*
                  1
                /   \
               2     3
              / \   / \
             4   5  6  7
         */
        let treeNode1 = TreeNode(value: 1)
        treeNode1.left = TreeNode(value: 2)
        treeNode1.right = TreeNode(value: 3)
        treeNode1.left?.left = TreeNode(value: 4)
        treeNode1.left?.right = TreeNode(value: 5)
        treeNode1.right?.left = TreeNode(value: 6)
        treeNode1.right?.right = TreeNode(value: 7)

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

     Input: root = [3,9,20,15,7, 11, 13]
     Output: [3.00000,14.50000, 11.5]
     3
   /   \
  9     20
 / \    / \
15   7  11   13

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
     Given the root of a binary tree and an integer targetSum, return true if the tree has a root-to-leaf path such that adding up all the values along the path
     equals targetSum.

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
            // If two nodes are in same row and column then sorts it on the basis of value
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
        // Vertical - Level - Node
        var verticalInfo = [Int: [[Int: T]]]()
        // Node - Vertical - Level
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
        if root.right != nil {
            rightViewDFS(root: root, level: level + 1, result: &result)
        }
        if root.left != nil {
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
        let result = getPath(root: root.left, path: &path, destination: destination) || getPath(root: root.right, path: &path, destination: destination)
        if !result {
            path.removeLast()
        }
        return result
    }

    /*
     257. Binary Tree Paths
     Solved
     Easy
     Topics
     conpanies icon
     Companies
     Given the root of a binary tree, return all root-to-leaf paths in any order.

     A leaf is a node with no children.



     Example 1:


     Input: root = [1,2,3,null,5]
     Output: ["1->2->5","1->3"]
     Example 2:

     Input: root = [1]
     Output: ["1"]


     Constraints:

     The number of nodes in the tree is in the range [1, 100].
     -100 <= Node.val <= 100
     */

    func binaryTreePaths(_ root: TreeNode<String>?) -> [String] {
        guard let root = root else {
            return []
        }
        var result = [String]()
        var currentPath = ""
        binaryTreePathsRecursion(root: root, currentPath: currentPath, result: &result)
        return result

    }

    private func binaryTreePathsRecursion(root: TreeNode<String>?, currentPath: String, result: inout [String]) {
        guard let root = root else {
            return
        }
        var currentPath = currentPath
        if currentPath.isEmpty {
            currentPath.append("\(root.data)")
        } else {
            currentPath.append("->\(root.data)")
        }
        if root.left == nil && root.right == nil {
            result.append(currentPath)
        } else {
            binaryTreePathsRecursion(root: root.left, currentPath: currentPath, result: &result)
            binaryTreePathsRecursion(root: root.right, currentPath: currentPath, result: &result)
        }

    }

    /*
         Lowest Common Ancestor of Binary Tree
         236. Lowest Common Ancestor of a Binary Tree
         Medium
         Topics
         conpanies icon
         Companies
         Given a binary tree, find the lowest common ancestor (LCA) of two given nodes in the tree.

         According to the definition of LCA on Wikipedia: “The lowest common ancestor is defined between two nodes p and q as the lowest node in T that has both p and q as descendants (where we allow a node to be a descendant of itself).”



         Example 1:


         Input: root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 1
         Output: 3
         Explanation: The LCA of nodes 5 and 1 is 3.
         Example 2:


         Input: root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 4
         Output: 5
         Explanation: The LCA of nodes 5 and 4 is 5, since a node can be a descendant of itself according to the LCA definition.
         Example 3:

         Input: root = [1,2], p = 1, q = 2
         Output: 1


         Constraints:

         The number of nodes in the tree is in the range [2, 105].
         -109 <= Node.val <= 109
         All Node.val are unique.
         p != q
         p and q will exist in the tree.
         */

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
     Problem Statement: Given a Binary Tree, convert the value of its nodes to follow the Children Sum Property. The Children Sum Property in a binary tree states that for every node, the sum of its children's values (if they exist) should be equal to the node's value. If a child is missing, it is considered as having a value of 0.

     Note:

     The node values can be increased by any positive integer any number of times, but decrementing any node value is not allowed.
     A value for a NULL node can be assumed as 0.
     We cannot change the structure of the given binary tree.

     */

    func changeTree(root: inout TreeNode<Int>?) {
        if root == nil {
            return
        }
        var child = 0
        if let left = root?.left {
            child += left.data
        }
        if let right = root?.right {
            child += right.data
        }
        if child > root!.data {
            root?.data = child
        } else {
            if root?.left != nil {
                root?.left?.data = child
            }
            if root?.right != nil {
                root?.right?.data = child
            }
        }
        var left = root?.left
        var right = root?.right
        changeTree(root: &left)
        changeTree(root: &right)

        var total = 0
        if let data = root?.left?.data {
            total += data
        }
        if let data = root?.right?.data {
            total += data
        }
        if root?.left != nil || root?.right != nil {
            root?.data = total
        }
    }

    /*
     863. All Nodes Distance K in Binary Tree
    
     Given the root of a binary tree, the value of a target node target, and an integer k, return an array of the values of all nodes that have a distance k from the target node.

     You can return the answer in any order.



     Example 1:


     Input: root = [3,5,1,6,2,0,8,null,null,7,4], target = 5, k = 2
     Output: [7,4,1]
     Explanation: The nodes that are a distance 2 from the target node (with value 5) have values 7, 4, and 1.
     Example 2:

     Input: root = [1], target = 1, k = 3
     Output: []


     Constraints:

     The number of nodes in the tree is in the range [1, 500].
     0 <= Node.val <= 500
     All the values Node.val are unique.
     target is the value of one of the nodes in the tree.
     0 <= k <= 1000
     */

    private func parentTrack(root: TreeNode<Int>) -> [TreeNode<Int>: TreeNode<Int>] {
        var result = [TreeNode<Int>: TreeNode<Int>]()
        var queue = [TreeNode<Int>]()
        queue.append(root)
        while !queue.isEmpty {
            var current = queue.removeFirst()
            if let left = current.left {
                queue.append(left)
                result[left] = current
            }
            if let right = current.right {
                queue.append(right)
                result[right] = current
            }
        }
        return result
    }

    func distanceK(_ root: TreeNode<Int>?, _ target: TreeNode<Int>?, _ k: Int) -> [Int] {
        guard let root = root, let target = target  else { return [] }

        var parentMatch = parentTrack(root: root)
        var visible = [TreeNode<Int>: Bool]()
        var queue = [TreeNode<Int>]()
        var result = [Int]()
        queue.append(target)
        visible[target] = true
        var level = 0
        while !queue.isEmpty {
            if level == k {
                break
            }
            level += 1
            let size = queue.count
            for i in stride(from: 0, through: size - 1, by: 1) {
                let current = queue.removeFirst()
                if let left = current.left, visible[left] == nil {
                    queue.append(left)
                    visible[left] = true

                }
                if let right = current.right, visible[right] == nil {
                    queue.append(right)
                    visible[right] = true

                }
                if let parent = parentMatch[current], visible[parent] == nil {
                    queue.append(parent)
                    visible[parent] = true

                }
            }
        }
        for node in queue {
            result.append(node.data)
        }
        return result
    }

    /*
     2385. Amount of Time for Binary Tree to Be Infected
     Medium
     Topics
     conpanies icon
     Companies
     Hint
     You are given the root of a binary tree with unique values, and an integer start. At minute 0, an infection starts from the node with value start.

     Each minute, a node becomes infected if:

     The node is currently uninfected.
     The node is adjacent to an infected node.
     Return the number of minutes needed for the entire tree to be infected.



     Example 1:


     Input: root = [1,5,3,null,4,10,6,9,2], start = 3
     Output: 4
     Explanation: The following nodes are infected during:
     - Minute 0: Node 3
     - Minute 1: Nodes 1, 10 and 6
     - Minute 2: Node 5
     - Minute 3: Node 4
     - Minute 4: Nodes 9 and 2
     It takes 4 minutes for the whole tree to be infected so we return 4.
     Example 2:


     Input: root = [1], start = 1
     Output: 0
     Explanation: At minute 0, the only node in the tree is infected so we return 0.


     Constraints:

     The number of nodes in the tree is in the range [1, 105].
     1 <= Node.val <= 105
     Each node has a unique value.
     A node with a value of start exists in the tree.
     */

    func amountOfTime(_ root: TreeNode<Int>?, _ start: Int) -> Int {
        guard let root = root else { return Int.max }
        let (parentMarker, startNode) = parentMarker(root: root, start: start)
        var result = 0
        var queue = Queue<TreeNode<Int>>()
        var visited = [TreeNode<Int>: Bool]()
        visited[startNode] = true

        queue.enqueue(startNode)
        while !queue.isEmpty() {
            var flag = false
            let count = queue.count
            for _ in stride(from: 0, through: queue.count() - 1, by: 1) {
                let current = queue.dequeue()!
                if let left = current.left, visited[left] == nil {
                    queue.enqueue(left)
                    visited[left] = true
                    flag = true
                }
                if let right = current.right, visited[right] == nil {
                    queue.enqueue(right)
                    visited[right] = true
                    flag = true
                }
                if let parent = parentMarker[current], visited[parent] == nil {
                    queue.enqueue(parent)
                    visited[parent] = true
                    flag = true
                }
            }
            if flag {
                result += 1
            }
        }
        return result
    }

    private func parentMarker(root: TreeNode<Int>, start: Int) -> ([TreeNode<Int>: TreeNode<Int>], TreeNode<Int>) {
        var treeNode = TreeNode<Int>(value: 0)
        var queue = Queue<TreeNode<Int>>()
        var parentMarker = [TreeNode<Int>: TreeNode<Int>]()
        queue.enqueue(root)
        while !queue.isEmpty() {
            let current = queue.dequeue()!
            if let left = current.left {
                parentMarker[left] = current
                queue.enqueue(left)
            }
            if let right = current.right {
                parentMarker[right] = current
                queue.enqueue(right)
            }
            if current.data == start {
                treeNode = current
            }
        }

        return (parentMarker, treeNode)
    }
    /*
     222. Count Complete Tree Nodes
     Given the root of a complete binary tree, return the number of the nodes in the tree.

     According to Wikipedia, every level, except possibly the last, is completely filled in a complete binary tree, and all nodes in the last level are as far left as possible. It can have between 1 and 2h nodes inclusive at the last level h.

     Design an algorithm that runs in less than O(n) time complexity.



     Example 1:


     Input: root = [1,2,3,4,5,6]
     Output: 6
     Example 2:

     Input: root = []
     Output: 0
     Example 3:

     Input: root = [1]
     Output: 1


     Constraints:

     The number of nodes in the tree is in the range [0, 5 * 104].
     0 <= Node.val <= 5 * 104
     The tree is guaranteed to be complete.
     */
    func countNodes(_ root: TreeNode<Int>?) -> Int {
        var result = 0
        inorder(root: root, count: &result)
        return result
    }

    func inorder(root: TreeNode<Int>?, count: inout Int) {
        guard let root = root else { return }
        inorder(root: root.left, count: &count)
        count += 1
        inorder(root: root.right, count: &count)
    }

    func countNodesOpti(_ root: TreeNode<T>?) -> Int {
        if root == nil {
            return 0
        }
        let leftHeight = leftHeight(root: root)
        let rightHeight = rightHeight(root: root)
        if leftHeight == rightHeight {
            return 1 << leftHeight - 1
        }
        return 1 + countNodesOpti(root?.left) + countNodesOpti(root?.right)

    }

    func leftHeight(root: TreeNode<T>?) -> Int {
        var root = root
        var height = 0
        while root != nil {
            height += 1
            root = root?.left
        }
        return height
    }

    func rightHeight(root: TreeNode<T>?) -> Int {
        var root = root
        var height = 0
        while root != nil {
            height += 1
            root = root?.right
        }
        return height
    }

    /*
     889. Construct Binary Tree from Preorder and Postorder Traversal

     Given two integer arrays, preorder and postorder where preorder is the preorder traversal of a binary tree of distinct values and postorder is the postorder traversal of the same tree, reconstruct and return the binary tree.

     If there exist multiple answers, you can return any of them.



     Example 1:


     Input: preorder = [1,2,4,5,3,6,7], postorder = [4,5,2,6,7,3,1]
     Output: [1,2,3,4,5,6,7]
     Example 2:

     Input: preorder = [1], postorder = [1]
     Output: [1]


     Constraints:

     1 <= preorder.length <= 30
     1 <= preorder[i] <= preorder.length
     All the values of preorder are unique.
     postorder.length == preorder.length
     1 <= postorder[i] <= postorder.length
     All the values of postorder are unique.
     It is guaranteed that preorder and postorder are the preorder traversal and postorder traversal of the same binary tree.
     */

    func buildTreePreIn(_ preorder: [Int], _ inorder: [Int]) -> TreeNode<Int>? {
        let count = inorder.count
        var dict = [Int: Int]()
        for i in stride(from: 0, through: count - 1, by: 1) {
            dict[inorder[i]] = i
        }

        return createTreePreIn(preOrder: preorder, preStart: 0, preEnd: count - 1, inOrder: inorder, inStart: 0, inEnd: count - 1, dict: dict)
    }

    /*
     106. Construct Binary Tree from Inorder and Postorder Traversal

     Given two integer arrays inorder and postorder where inorder is the inorder traversal of a binary tree and postorder is the postorder traversal of the same tree, construct and return the binary tree.



     Example 1:


     Input: inorder = [9,3,15,20,7], postorder = [9,15,7,20,3]
     Output: [3,9,20,null,null,15,7]
     Example 2:

     Input: inorder = [-1], postorder = [-1]
     Output: [-1]


     Constraints:

     1 <= inorder.length <= 3000
     postorder.length == inorder.length
     -3000 <= inorder[i], postorder[i] <= 3000
     inorder and postorder consist of unique values.
     Each value of postorder also appears in inorder.
     inorder is guaranteed to be the inorder traversal of the tree.
     postorder is guaranteed to be the postorder traversal of the tree.
     */
    
    func createTreePreIn(preOrder: [Int], preStart: Int, preEnd: Int, inOrder: [Int], inStart: Int, inEnd: Int, dict: [Int: Int]) -> TreeNode<Int>? {
        if preStart > preEnd || inStart > inEnd {
            return nil
        }

        let root = TreeNode<Int>(value: preOrder[preStart])
        let inRoot = dict[root.data]!
        let numsLeft = inRoot - inStart

        root.left = createTreePreIn(preOrder: preOrder, preStart: preStart + 1, preEnd: preStart + numsLeft, inOrder: inOrder, inStart: inStart, inEnd: inRoot - 1, dict: dict)
        root.right = createTreePreIn(preOrder: preOrder, preStart: preStart + numsLeft + 1, preEnd: preEnd, inOrder: inOrder, inStart: inRoot + 1, inEnd: inEnd, dict: dict)

        return root

    }

    func buildTreeInPost(_ inorder: [Int], _ postorder: [Int]) -> TreeNode<Int>? {
        let count = inorder.count
        var dict = [Int: Int]()
        for i in stride(from: 0, through: count - 1, by: 1) {
            dict[inorder[i]] = i
        }
        return createTreeInPost(inOrder: inorder, inStart: 0, inEnd: count - 1, postOrder: postorder, postStart: 0, postEnd: count - 1, dict: dict)
    }

    func createTreeInPost(inOrder: [Int], inStart: Int, inEnd: Int, postOrder: [Int], postStart: Int, postEnd: Int, dict: [Int: Int]) -> TreeNode<Int>? {
        if inStart > inEnd || postStart > postEnd {
            return nil
        }

        let root = TreeNode<Int>(value: postOrder[postEnd])
        let inRoot = dict[root.data]!
        let numsLeft = inRoot - inStart
        root.left = createTreeInPost(inOrder: inOrder, inStart: inStart, inEnd: inRoot - 1, postOrder: postOrder, postStart: postStart, postEnd: postStart + numsLeft - 1, dict: dict)
        root.right = createTreeInPost(inOrder: inOrder, inStart: inRoot + 1, inEnd: inEnd, postOrder: postOrder, postStart: postStart + numsLeft, postEnd: postEnd - 1, dict: dict)
        return root
    }

    /*

     Code
     Testcase
     Testcase
     Test Result
     297. Serialize and Deserialize Binary Tree
     Solved
     Hard
     Topics
     conpanies icon
     Companies
     Serialization is the process of converting a data structure or object into a sequence of bits so that it can be stored in a file or memory buffer, or transmitted across a network connection link to be reconstructed later in the same or another computer environment.

     Design an algorithm to serialize and deserialize a binary tree. There is no restriction on how your serialization/deserialization algorithm should work. You just need to ensure that a binary tree can be serialized to a string and this string can be deserialized to the original tree structure.

     Clarification: The input/output format is the same as how LeetCode serializes a binary tree. You do not necessarily need to follow this format, so please be creative and come up with different approaches yourself.



     Example 1:


     Input: root = [1,2,3,null,null,4,5]
     Output: [1,2,3,null,null,4,5]
     Example 2:

     Input: root = []
     Output: []


     Constraints:

     The number of nodes in the tree is in the range [0, 104].
     -1000 <= Node.val <= 1000
     */

    func serialize(_ root: TreeNode<Int>?) -> String {
            guard let root = root else { return "" }
            var result = ""
            var queue = [TreeNode<Int>?]()
            queue.append(root)
            while !queue.isEmpty {
                if let current = queue.removeFirst() {
                    result.append("\(current.data),")
                    queue.append(current.left)
                    queue.append(current.right)

                } else {
                    result.append("#,")
                }
            }
            return result
        }

        func deserialize(_ data: String) -> TreeNode<Int>? {
            guard !data.isEmpty else { return nil }
            var components = data.components(separatedBy: ",")
            var counter = 0
            var root = TreeNode<Int>(value: Int(components[0])!)
            counter += 1
            var queue = [TreeNode<Int>]()
            queue.append(root)
            while !queue.isEmpty {
                let current = queue.removeFirst()
                let component1 = components[counter]
                counter += 1
                if component1 == "#" {
                    current.left = nil
                } else {
                    let left = TreeNode<Int>(value: Int(component1)!)
                    current.left = left
                    queue.append(left)
                }
                let component2 = components[counter]
                counter += 1
                if component2 == "#" {
                    current.right = nil
                } else {
                    let right = TreeNode<Int>(value: Int(component2)!)
                    current.right = right
                    queue.append(right)
                }
            }
            return root
        }
}
