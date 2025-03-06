//
//  CircularQueue.swift
//  DataStructuresSwift
//
//  Created by Pranav Pravakar on 02/07/23.
//  Copyright © 2023 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation

struct CircularQueue<T> {
    private var elements: [T]
    private var size: Int
    private var front: Int
    private var rear: Int
}

private extension CircularQueue {
    func isFull() -> Bool {
        front == 0 && rear == size - 1 || front == rear + 1
    }

    func isEmpty() -> Bool {
        front == -1
    }
}

extension CircularQueue {
    init(repeatingValue: T, size: Int) {
        elements = [T](repeating: repeatingValue, count: size)
        self.size = size
        front = -1
        rear = -1
    }

    mutating func enqueue(element: T) {
        if isFull() {
            return
        }
        if front == -1 {
            front = 0
        }
        let index = (rear + 1) % size
        elements[index] = element
    }

    mutating func dequeue() -> T? {
        if isEmpty() {
            return nil
        }

        let value = elements[front]
        front = (front + 1) % size
        if front == rear {
            front = -1
            rear = -1
        }
        return value
    }
}
