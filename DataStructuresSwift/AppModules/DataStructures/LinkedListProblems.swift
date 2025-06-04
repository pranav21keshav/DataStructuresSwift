//
//  LinkedListOperations.swift
//  DataStructuresSwift
//
//  Created by PRANAV PRAVAKAR on 08/04/20.
//  Copyright © 2020 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation
struct LinkedListOperations<T> {
/*
 Given the head of a sorted linked list, delete all nodes that have duplicate numbers, leaving only distinct numbers from the original list. Return the linked list sorted as well.
 Input: head = [1,2,3,3,4,4,5]
 Output: [1,2,5]

 Input: head = [1,1,1,2,3]
 Output: [2,3]
 */

//      Definition for singly-linked list.

}

public class ListNode {
    public var val: Int
    public var next: ListNode?

    public init() {
        self.val = 0
        self.next = nil
    }
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
    public init(_ val: Int, _ next: ListNode?) {
        self.val = val
        self.next = next
    }
}
extension ListNode: Equatable {
  public static func == (lhs: ListNode, rhs: ListNode) -> Bool {
      lhs === rhs
  }
}
class Solution {
    func deleteDuplicates(_ head: ListNode?) -> ListNode? {
        var current = head
        guard head != nil else { return nil }
        guard current?.next != nil else { return head }
        var fake: ListNode? = ListNode()
        fake?.next = current
        var prev = fake

        while current != nil {
            if  current?.next != nil && prev?.next?.val == current?.next?.val {
                current = current?.next

            } else {
                if prev?.next == current {
                    prev = prev?.next
                } else {
                    prev?.next = current?.next
                }
                if current != nil {
                    current = current?.next
                }
            }
        }

        fake = fake?.next

        return fake
    }
}
