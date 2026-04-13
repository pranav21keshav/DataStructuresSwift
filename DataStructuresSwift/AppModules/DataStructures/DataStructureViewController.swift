//
//  DataStructureViewController.swift
//  DataStructuresSwift
//
//  Created by PRANAV PRAVAKAR on 31/03/20.
//  Copyright © 2020 PRANAV PRAVAKAR. All rights reserved.
//

import OrderedCollections
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
        let a = sorting.mergeSortDynamic(list, <)
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
        _ = TreeProblems<Int>()
        _ = DynamicProblemsString()
        _ = BuyAndSellStockBestTime()
        _ = BinarySearch<Int>()
        _ = StackProblems()
        _ = TwoPointerAndSlidingWindow()
        _ = GraphProblems()
        var result = [[0: 1], [2: 10], [2: 9], [4: 6]]
        result.sort { $0.keys.first! == $1.keys.first ? $0.values.first! < $1.values.first! : $0.keys.first! < $1.keys.first! }
        print(result)
        var minHeap = MinHeap<Int>(capacity: 6)
        let values = [13, 16, 31, 41, 51, 100]
        for value in values {
            minHeap.insert(key: value)
        }
        print("Initial Heap - \(minHeap.elements)")
        minHeap.delete(key: 13)
        print("Heap After deleting 13 - \(minHeap.elements)")

        let pqh = [45, 31, 14, 13, 20, 7, 11, 12, 7]
        var pqheap = PriorityQueueHeap<Int>(capacity: pqh.count)
        for element in pqh {
            pqheap.insert(value: element)
        }
        print("Priority Queue - \(pqheap)")
        print("Priority Queue, after removing - \(pqheap.remove()), is - \(pqheap)")
        print("Priority Queue, after removing - \(pqheap.remove()), is - \(pqheap)")
        print("Priority Queue, after removing - \(pqheap.remove()), is - \(pqheap)")
        print("Priority Queue, after removing - \(pqheap.remove()), is - \(pqheap)")
        print("Priority Queue, after removing - \(pqheap.remove()), is - \(pqheap)")
        print("Priority Queue, after removing - \(pqheap.remove()), is - \(pqheap)")
        print("Priority Queue, after removing - \(pqheap.remove()), is - \(pqheap)")
        print("Priority Queue, after removing - \(pqheap.remove()), is - \(pqheap)")
        print("Priority Queue, after removing - \(pqheap.remove()), is - \(pqheap)")

        var arraySort1 = [[0, 30], [5, 10], [15, 20]]
        arraySort1.sort { $0[0] < $1[0] && $1[0] >= $0[1] }
        print("Sorted Array - \(arraySort1)")
        var arraySort2 = [[2, 11], [6, 16], [11, 16]]
        arraySort2.sort { $0[0] < $1[0] && $1[0] >= $0[1] }
        print("Sorted Array - \(arraySort2)")

        var arraySort3 = [[2, 15], [36, 45], [9, 29], [16, 23], [4, 9]]
        arraySort3.sort { $0[0] < $1[0] ? $0[1] <= $1[0] : $0[1] >= $1[1] }
        print("Sorted Array - \(arraySort3)")
        printInfo()
    }

    func printInfo() {
        var setArray = Set<[[Int]]>()
        setArray.insert([[0, 1], [1, 2], [2, 1]])
        setArray.insert([[0, 1], [2, 1], [1, 2]])
        setArray.insert([[0, 1], [1, 2], [2, 1]])
        print("Set Array - \(setArray)")
        for char in "abcde" {
            print("\(char) - \(char.asciiValue!)")
        }

        var array = [UInt8]()
        array.append(UInt8(exactly: 98)!)
        array.append(UInt8(exactly: 99)!)
        print(String(bytes: array, encoding: .ascii))

        var orderedSet = OrderedSet<Int>([3, 2, 1])
        print("Ordeened Set - \(orderedSet)")
        print("Ordered Set sorted - \(orderedSet.sorted())")

        let pqh = [45, 31, 14, 13, 20, 7, 11, 12, 7]
        var minheap = MinHeap<Int>(capacity: pqh.count)
        for element in pqh {
            minheap.insert(key: element)
        }
        print("Min Heap - \(minheap)")
        print("Min Heap, after removing - \(minheap.remove()), is - \(minheap)")
        print("Min Heap, after removing - \(minheap.remove()), is - \(minheap)")
        print("Min Heap, after removing - \(minheap.remove()), is - \(minheap)")
        print("Min Heap, after removing - \(minheap.remove()), is - \(minheap)")
        print("Min Heap, after removing - \(minheap.remove()), is - \(minheap)")
        print("Min Heap, after removing - \(minheap.remove()), is - \(minheap)")
        print("Min Heap, after removing - \(minheap.remove()), is - \(minheap)")
        print("Min Heap, after removing - \(minheap.remove()), is - \(minheap)")
        print("Min Heap, after removing - \(minheap.remove()), is - \(minheap)")

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
