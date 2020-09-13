//
//  Node.swift
//  DataStructuresSwift
//
//  Created by PRANAV PRAVAKAR on 31/03/20.
//  Copyright © 2020 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation

class Node<T> {
    var data: T
    var next: Node?
    
    init(value: T, next: Node? = nil) {
        self.data = value
        self.next = next
    }
}
