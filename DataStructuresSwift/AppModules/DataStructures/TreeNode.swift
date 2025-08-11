//
//  TreeNode.swift
//  DataStructuresSwift
//
//  Created by PRANAV PRAVAKAR on 31/03/20.
//  Copyright © 2020 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation
class TreeNode<T: Comparable & Hashable> {
    var data: T
    var left: TreeNode?
    var right: TreeNode?

    init(value: T, left: TreeNode? = nil, right: TreeNode? = nil) {
        self.data = value
        self.left = left
        self.right = right
    }
}

extension TreeNode: Equatable {
    static func == (lhs: TreeNode, rhs: TreeNode) -> Bool {
        lhs === rhs
    }
}

extension TreeNode: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(data)
        hasher.combine(left)
        hasher.combine(right)
    }
}

extension TreeNode {
    var isLeaf: Bool {
        left == nil && right == nil
    }
}
