//
//  BinarySearchTree.swift
//  DataStructuresSwift
//
//  Created by Pranav Pravakar on 12/06/24.
//  Copyright © 2024 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation
// Left < Node < Right
// Inorder traversal gives sorted order
class BinarySearchTree<T: Comparable & Hashable> {
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

    /*

     701. Insert into a Binary Search Tree

     You are given the root node of a binary search tree (BST) and a value to insert into the tree. Return the root node of the BST after the insertion. It is guaranteed that the new value does not exist in the original BST.

     Notice that there may exist multiple valid ways for the insertion, as long as the tree remains a BST after insertion. You can return any of them.



     Example 1:


     Input: root = [4,2,7,1,3], val = 5
     Output: [4,2,7,1,3,5]
     Explanation: Another accepted tree is:

     Example 2:

     Input: root = [40,20,60,10,30,50,70], val = 25
     Output: [40,20,60,10,30,50,70,null,null,25]
     Example 3:

     Input: root = [4,2,7,1,3,null,null,null,null,null,null], val = 5
     Output: [4,2,7,1,3,5]


     Constraints:

     The number of nodes in the tree will be in the range [0, 104].
     -108 <= Node.val <= 108
     All the values Node.val are unique.
     -108 <= val <= 108
     It's guaranteed that val does not exist in the original BST.
     */
    func insertIntoBSTRecursive(node: TreeNode<T>?, data: T) -> TreeNode<T> {
        if node == nil {
            let newNode = TreeNode<T>(value: data)
            return newNode
        }
        if data < node!.data {
            node?.left = insertIntoBSTRecursive(node: node?.left, data: data)
        } else {
            node?.right = insertIntoBSTRecursive(node: node?.right, data: data)
        }

        return node!
    }

    func insertIntoBST(_ root: TreeNode<Int>?, _ val: Int) -> TreeNode<Int>? {
        if root == nil {
            return TreeNode<Int>(value: val)
        }
        var current = root

        while current != nil {
            if val > current!.data {
                if current?.right != nil {
                    current = current?.right
                } else {
                    current?.right = TreeNode<Int>(value: val)
                    break
                }
            } else {
                if current?.left != nil {
                    current = current?.left
                } else {
                    current?.left = TreeNode<Int>(value: val)
                    break
                }
            }
        }
        return root
    }

    // TC - O(h)
    // SC - O(h)
    func searchRecursive(node: TreeNode<T>?, data: T) -> TreeNode<T>? {
        if node == nil || node?.data == data {
            return node
        }

        if data < node!.data {
            return searchRecursive(node: node?.left, data: data)
        }

        return searchRecursive(node: node?.right, data: data)
    }
    // TC - O(h)
    // SC - O(1)
    func searchIterative(node: TreeNode<T>?, data: T) -> TreeNode<T>? {
        var node = node
        while node != nil || node?.data != data {
            if data < node!.data {
                node = node?.left
            } else {
                node = node?.right
            }
        }
        return node
    }

    // TC - O(h)
    // SC - O(1)
    func searchCeil(node: TreeNode<Int>?, data: Int) -> Int {
        var node = node
        var ceil = -1
        while node != nil {
            if node?.data == ceil {
                ceil = node!.data
                return ceil
            }
            if data > node!.data {
                node = node?.right
            } else {
                ceil = node!.data
                node = node?.left
            }
        }
        return ceil
    }

    func searchFloor(node: TreeNode<Int>?, data: Int) -> Int {
        var node = node
        var floor = -1
        while node != nil {
            if node?.data == floor {
                floor = node!.data
                return floor
            }
            if data > node!.data {
                floor = node!.data
                node = node?.right
            } else {
                node = node?.left
            }
        }
        return floor
    }

    /*
     450. Delete Node in a BST

     Companies
     Given a root node reference of a BST and a key, delete the node with the given key in the BST. Return the root node reference (possibly updated) of the BST.

     Basically, the deletion can be divided into two stages:

     Search for a node to remove.
     If the node is found, delete the node.


     Example 1:


     Input: root = [5,3,6,2,4,null,7], key = 3
     Output: [5,4,6,2,null,null,7]
     Explanation: Given key to delete is 3. So we find the node with value 3 and delete it.
     One valid answer is [5,4,6,2,null,null,7], shown in the above BST.
     Please notice that another valid answer is [5,2,6,null,4,null,7] and it's also accepted.

     Example 2:

     Input: root = [5,3,6,2,4,null,7], key = 0
     Output: [5,3,6,2,4,null,7]
     Explanation: The tree does not contain a node with value = 0.
     Example 3:

     Input: root = [], key = 0
     Output: []


     Constraints:

     The number of nodes in the tree is in the range [0, 104].
     -105 <= Node.val <= 105
     Each node has a unique value.
     root is a valid binary search tree.
     -105 <= key <= 105


     Follow up: Could you solve it with time complexity O(height of tree)?
     */
    func deleteNode(_ root: TreeNode<Int>?, _ key: Int) -> TreeNode<Int>? {
        var current = root
        if current?.data == key {
            return helper(root: current)
        }
        while current != nil {
            if current!.data > key {
                if current?.left != nil && current?.left?.data == key {
                    current?.left = helper(root: current?.left)
                    break
                } else {
                    current = current?.left
                }
            } else {
                if current?.right != nil && current?.right?.data == key {
                    current?.right = helper(root: current?.right)
                    break
                } else {
                    current = current?.right
                }
            }
        }
        return root
    }

    func helper(root: TreeNode<Int>?) -> TreeNode<Int>? {
        if root?.left == nil {
            return root?.right
        } else if root?.right == nil {
            return root?.left
        } else {
            let leftsRight = findRight(root: root?.left)
            leftsRight?.right = root?.right
            return root?.left
        }
    }
    func findRight(root: TreeNode<Int>?) -> TreeNode<Int>? {
        var root = root
        while root?.right != nil {
            root = root?.right
        }
        return root
    }

    func deleteNodeRecursive(root: TreeNode<Int>?, key: Int) -> TreeNode<Int>? {
        if root == nil {
            return root
        }
        if root!.data > key {
            root?.left = deleteNodeRecursive(root: root?.left, key: key)
        } else if root!.data < key {
            root?.right = deleteNodeRecursive(root: root?.right, key: key)
        } else {
            if root?.left == nil {
                return root?.right
            } else if root?.right == nil {
                return root?.left
            } else {
                let inorderSuccessor = inorderSuccessor(root: root)!
                root?.data = inorderSuccessor.data
                root?.right = deleteNodeRecursive(root: root?.right, key: inorderSuccessor.data)
            }
        }
        return root
    }

    func inorderSuccessor(root: TreeNode<Int>?) -> TreeNode<Int>? {
        var root = root?.right
        while root != nil && root?.left != nil {
            root = root?.left
        }
        return root
    }

    /*
     230. Kth Smallest Element in a BST

     Given the root of a binary search tree, and an integer k, return the kth smallest value (1-indexed) of all the values of the nodes in the tree.



     Example 1:


     Input: root = [3,1,4,null,2], k = 1
     Output: 1
     Example 2:


     Input: root = [5,3,6,2,4,null,null,1], k = 3
     Output: 3


     Constraints:

     The number of nodes in the tree is n.
     1 <= k <= n <= 104
     0 <= Node.val <= 104


     Follow up: If the BST is modified often (i.e., we can do insert and delete operations) and you need to find the kth smallest frequently, how would you optimize?
     */
    func kthSmallest(_ root: TreeNode<Int>?, _ k: Int) -> Int {
        var count = 0
        var result = 0
        var current = root
        while current != nil {
            if current?.left == nil {
                count += 1
                if count == k {
                    result = current!.data
                    break
                }
                current = current?.right
            } else {
                var successor = current?.left
                while successor?.right != nil && successor?.right != current {
                    successor = successor?.right
                }
                if successor?.right == current {
                    count += 1

                    if count == k {
                        result = current!.data
                        break
                    }
                    current = current?.right
                    successor?.right = nil
                } else {
                    successor?.right = current
                    current = current?.left
                }
            }
        }
        return result

    }

    /*
     98. Validate Binary Search Tree

     A valid BST is defined as follows:

     The left subtree of a node contains only nodes with keys strictly less than the node's key.
     The right subtree of a node contains only nodes with keys strictly greater than the node's key.
     Both the left and right subtrees must also be binary search trees.


     Example 1:


     Input: root = [2,1,3]
     Output: true
     Example 2:


     Input: root = [5,1,4,null,null,3,6]
     Output: false
     Explanation: The root node's value is 5 but its right child's value is 4.


     Constraints:

     The number of nodes in the tree is in the range [1, 104].
     -231 <= Node.val <= 231 - 1
     */

    func isValidBST(_ root: TreeNode<Int>?) -> Bool {
        isValidBST(root: root, min: Int.min, max: Int.max)
    }

    private func isValidBST(root: TreeNode<Int>?, min: Int, max: Int) -> Bool {
        if root == nil {
            return true
        }
        if root!.data <= min || root!.data >= max {
            return false
        }
        return isValidBST(root: root?.left, min: min, max: root!.data) && isValidBST(root: root?.right, min: root!.data, max: max)
    }

    /*
     235. Lowest Common Ancestor of a Binary Search Tree
     
     Given a binary search tree (BST), find the lowest common ancestor (LCA) node of two given nodes in the BST.

     According to the definition of LCA on Wikipedia: “The lowest common ancestor is defined between two nodes p and q as the lowest node in T that has both p and q as descendants (where we allow a node to be a descendant of itself).”



     Example 1:


     Input: root = [6,2,8,0,4,7,9,null,null,3,5], p = 2, q = 8
     Output: 6
     Explanation: The LCA of nodes 2 and 8 is 6.
     Example 2:


     Input: root = [6,2,8,0,4,7,9,null,null,3,5], p = 2, q = 4
     Output: 2
     Explanation: The LCA of nodes 2 and 4 is 2, since a node can be a descendant of itself according to the LCA definition.
     Example 3:

     Input: root = [2,1], p = 2, q = 1
     Output: 2


     Constraints:

     The number of nodes in the tree is in the range [2, 105].
     -109 <= Node.val <= 109
     All Node.val are unique.
     p != q
     p and q will exist in the BST.
     */

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
     1008. Construct Binary Search Tree from Preorder Traversal

     Given an array of integers preorder, which represents the preorder traversal of a BST (i.e., binary search tree), construct the tree and return its root.

     It is guaranteed that there is always possible to find a binary search tree with the given requirements for the given test cases.

     A binary search tree is a binary tree where for every node, any descendant of Node.left has a value strictly less than Node.val, and any descendant of Node.right has a value strictly greater than Node.val.

     A preorder traversal of a binary tree displays the value of the node first, then traverses Node.left, then traverses Node.right.



     Example 1:


     Input: preorder = [8,5,1,7,10,12]
     Output: [8,5,10,1,7,null,12]
     Example 2:

     Input: preorder = [1,3]
     Output: [1,null,3]
     */
    func bstFromPreorder(_ preorder: [Int]) -> TreeNode<Int>? {
        var index = 0
        return bst(preorder: preorder, index: &index, max: Int.max)
    }

    private func bst(preorder: [Int], index: inout Int, max: Int) -> TreeNode<Int>? {
        if index >= preorder.count || preorder[index] > max {
            return nil
        }
        let element = preorder[index]
        let root = TreeNode<Int>(value: element)
        index += 1
        root.left = bst(preorder: preorder, index: &index, max: element)
        root.right = bst(preorder: preorder, index: &index, max: max)
        return root

    }

    /*
     285. Inorder Successor in BST

     Given the root of a binary search tree and a node p in it, return the in-order successor of that node in the BST. If the given node has no in-order successor in the tree, return null.

     The successor of a node p is the node with the smallest key greater than p.val.



     Example 1:


     Input: root = [2,1,3], p = 1
     Output: 2
     Explanation: 1's in-order successor node is 2. Note that both p and the return value is of TreeNode type.
     Example 2:


     Input: root = [5,3,6,2,4,null,null,1], p = 6
     Output: null
     Explanation: There is no in-order successor of the current node, so the answer is null.


     Constraints:

     The number of nodes in the tree is in the range [1, 104].
     -105 <= Node.val <= 105
     All Nodes will have unique values.
     */

    func inorderSuccessor(_ root: TreeNode<Int>?, _ p: TreeNode<Int>?) -> TreeNode<Int>? {
        var successor: TreeNode<Int>?
        var root = root
        while root != nil {
            if p!.data >= root!.data {
                root = root?.right
            } else {
                successor = root
                root = root?.left
            }
        }
        return successor
    }

    /*
     173. Binary Search Tree Iterator
     Implement the BSTIterator class that represents an iterator over the in-order traversal of a binary search tree (BST):

     BSTIterator(TreeNode root) Initializes an object of the BSTIterator class. The root of the BST is given as part of the constructor. The pointer should be initialized to a non-existent number smaller than any element in the BST.
     boolean hasNext() Returns true if there exists a number in the traversal to the right of the pointer, otherwise returns false.
     int next() Moves the pointer to the right, then returns the number at the pointer.
     Notice that by initializing the pointer to a non-existent smallest number, the first call to next() will return the smallest element in the BST.

     You may assume that next() calls will always be valid. That is, there will be at least a next number in the in-order traversal when next() is called.



     Example 1:


     Input
     ["BSTIterator", "next", "next", "hasNext", "next", "hasNext", "next", "hasNext", "next", "hasNext"]
     [[[7, 3, 15, null, null, 9, 20]], [], [], [], [], [], [], [], [], []]
     Output
     [null, 3, 7, true, 9, true, 15, true, 20, false]

     Explanation
     BSTIterator bSTIterator = new BSTIterator([7, 3, 15, null, null, 9, 20]);
     bSTIterator.next();    // return 3
     bSTIterator.next();    // return 7
     bSTIterator.hasNext(); // return True
     bSTIterator.next();    // return 9
     bSTIterator.hasNext(); // return True
     bSTIterator.next();    // return 15
     bSTIterator.hasNext(); // return True
     bSTIterator.next();    // return 20
     bSTIterator.hasNext(); // return False


     Constraints:

     The number of nodes in the tree is in the range [1, 105].
     0 <= Node.val <= 106
     At most 105 calls will be made to hasNext, and next.


     Follow up:

     Could you implement next() and hasNext() to run in average O(1) time and use O(h) memory, where h is the height of the tree?
     */
    // private let root: TreeNode
        private var stack = [TreeNode<Int>]()

        init(_ root: TreeNode<Int>?) {
            // self.root = root
            pushAllLeft(root: root)
        }

        func next() -> Int {
            let node = stack.removeLast()
            if node.right != nil {
                pushAllLeft(root: node.right)
            }
            return node.data
        }

        func hasNext() -> Bool {
            !stack.isEmpty
        }

        private func pushAllLeft(root: TreeNode<Int>?) {
            var root = root
            while root != nil {
                stack.append(root!)
                root = root?.left
            }
        }
}
