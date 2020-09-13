//
//  DataStructureViewController.swift
//  DataStructuresSwift
//
//  Created by PRANAV PRAVAKAR on 31/03/20.
//  Copyright © 2020 PRANAV PRAVAKAR. All rights reserved.
//

import UIKit

class DataStructureViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let sll = SinglyLinkedList<Int>()
        let sllListNode = sll.createLinkedList(with: [1, 4, 5, 7, 9, 10, 12])
        sll.printSinglyLinkedList(root: sllListNode)
        var treeOps = TreeOperations<Int>()
        let root = treeOps.createIntBinaryTree()
        treeOps.inOrderTraversalUsingRecusrion(root: root)
        treeOps.inOrderTraversalUsingStack(root: root)
        
        var array = [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
        let sorting = Sorting<Int>()
        var ascendingArray = sorting.insertionSortPractice(array)
        print(ascendingArray)
        var descendingArray = sorting.insertionSortGeneric(ascendingArray, >)
        print(descendingArray)
        var list = [ 10, 0, 3, 9, 2, 14, 26, 27, 1, 5, 8, -1, 8 ]
        let a = sorting.mergeSort(list, <)
        print(a)
        sorting.quicksortLomuto(&list, low: 0, high: list.count - 1)
        print(list)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
