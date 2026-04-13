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

struct LinkedListProblems {
    /*
    2. Add Two Numbers

    You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order, and each of their nodes contains a single digit. Add the two numbers and return the sum as a linked list.

    You may assume the two numbers do not contain any leading zero, except the number 0 itself.



    Example 1:


    Input: l1 = [2,4,3], l2 = [5,6,4]
    Output: [7,0,8]
    Explanation: 342 + 465 = 807.
    Example 2:

    Input: l1 = [0], l2 = [0]
    Output: [0]
    Example 3:

    Input: l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]
    Output: [8,9,9,9,0,0,0,1]


    Constraints:

    The number of nodes in each linked list is in the range [1, 100].
    0 <= Node.val <= 9
    It is guaranteed that the list represents a number that does not have leading zeros.
     */
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var l1 = l1
        var l2 = l2
        var newHead: ListNode? = ListNode()
        var current = newHead
        var carry = 0
        while l1 != nil || l2 != nil {
            let x = l1?.val ?? 0
            let y = l2?.val ?? 0
            let sum = (x + y + carry) % 10
            carry = (x + y + carry) / 10
            current?.next = ListNode(sum)
            current = current?.next
            if l1 != nil {
                l1 = l1?.next
            }
            if l2 != nil {
                l2 = l2?.next
            }
        }
        if carry != 0 {
            current?.next = ListNode(carry)
        }
        newHead = newHead?.next
        return newHead
    }

    /*
     445. Add Two Numbers II

     You are given two non-empty linked lists representing two non-negative integers. The most significant digit comes first and each of their nodes contains a single digit. Add the two numbers and return the sum as a linked list.

     You may assume the two numbers do not contain any leading zero, except the number 0 itself.



     Example 1:


     Input: l1 = [7,2,4,3], l2 = [5,6,4]
     Output: [7,8,0,7]
     Example 2:

     Input: l1 = [2,4,3], l2 = [5,6,4]
     Output: [8,0,7]
     Example 3:

     Input: l1 = [0], l2 = [0]
     Output: [0]


     Constraints:

     The number of nodes in each linked list is in the range [1, 100].
     0 <= Node.val <= 9
     It is guaranteed that the list represents a number that does not have leading zeros.


     Follow up: Could you solve it without reversing the input lists?
     */
    // Approach 1 - Reverse linked list
    // Aproach 2 - Stacks
}
