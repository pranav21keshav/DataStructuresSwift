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
        let buy2Chocolates = BuyTwoChocolates()
        print("Left Money - ", buy2Chocolates.buyChococolates(prices: [1, 2, 2], money: 3))
        print("Left Money - ", buy2Chocolates.buyChococolates(prices: [3, 2, 3], money: 3))

        let elementCount = ElementCountInArray()
        elementCount.elementCountIn(array: [0, 0, 1, 2])
        elementCount.elementCountIn(array: [1, 2, 3, 4])
        elementCount.elementCountIn(array: [5, 5, 5, 5])

        let permutation = Permuation()
//        var string = "ABC"
//        for i in 0..<string.count {
//            print(string[i])
//        }
//        permutation.permute(string: &string, start: 0, end: string.count - 1)
        let stringProblems = StringProblems()
        stringProblems.findSubsrtingNaive(string: "I am a disco dancer", pattern: "disco")

        _ = KMP()
       _ = Bitwise()
        _ = KadaneAlgorithm()
        _ = QuickSelect()
        _ = Graph()
        _ = AdjacencyList(vertices: 6)
        _ = ArrayProblems()
        _ = StringProblems()
        _ = TreeOperations<Int>()
        _ = DynamicProblem()
        _ = TreeProblems()
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
