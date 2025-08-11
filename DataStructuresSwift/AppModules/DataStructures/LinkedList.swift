//
//  SinglyLinkedList.swift
//  DataStructuresSwift
//
//  Created by PRANAV PRAVAKAR on 01/04/20.
//  Copyright © 2020 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation
struct SinglyLinkedList<T: Hashable> {
    func createLinkedList(with values: [T]) -> Node<T> {
        let head = Node(value: values.first!)
        var temp = head
        for i in 1..<values.count {
            let node = Node(value: values[i])
            temp.next = node
            temp = temp.next!
        }
        return head
    }
    func insert(value: T, after: T, in list: Node<T>) {
        var start: Node? = list
        while start != nil {
            if start?.data == after {
                let newNode = Node(value: value, next: start?.next)
                start?.next = newNode
                break
            }
            start = start?.next
        }
    }
    func printSinglyLinkedList(root: Node<T>) {
        var start: Node? = root
        while start != nil {
            print(start!.data, separator: "", terminator: ",")
            start = start?.next
        }
    }
    func printSinglyLinkedListReverse(root: Node<T>) {
        if root.next != nil {
            printSinglyLinkedListReverse(root: root.next!)
        }
        print(root.data)
    }
    
}
