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

    /*
    func insert(data: T) {
        if root == nil {
            root = TreeNode(value: data)
            return
        }
        var current = root
        if data < current!.data {
            insert(data: <#T##Comparable#>)
        }

    }

    private func insertData(data: T) {
        
    }
     */
}
