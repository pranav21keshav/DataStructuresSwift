//
//  TreeNode.swift
//  DataStructuresSwift
//
//  Created by PRANAV PRAVAKAR on 31/03/20.
//  Copyright © 2020 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation
class TreeNode<T: Comparable & Equatable> {
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
