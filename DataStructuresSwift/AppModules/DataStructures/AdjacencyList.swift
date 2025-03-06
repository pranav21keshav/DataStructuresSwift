//
//  AdjacencyList.swift
//  DataStructuresSwift
//
//  Created by Pranav Pravakar on 06/07/24.
//  Copyright © 2024 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation
struct AdjacencyList {
    private let vertices: Int
    private var graph: [Node<Int>?]
}

extension AdjacencyList {
    init(vertices: Int) {
        self.vertices = vertices
        graph = [Node<Int>?](repeating: nil, count: vertices)
        performOperations()
    }

    mutating func addEdge(source: Int, destination: Int) {
        let node = Node(value: destination, next: nil)
        node.next = graph[source]
        graph[source] = node
    }

    mutating func addVertex(vertex: Int, source: Int, destination: Int) {
        addEdge(source: source, destination: vertex)
        addEdge(source: vertex, destination: destination)
    }

    mutating func deleteVertex(vertice: Int) {
        for i in 0..<vertices {
            if i == vertice {
                graph[i] = nil
                continue
            }
            if graph[i]?.data == vertice {
                graph[i] = graph[i]?.next
                continue
            }
            var temp = graph[i]
            while temp != nil {
                let prev = temp
                temp = temp?.next
                if temp?.data == vertice {
                    prev?.next = temp?.next
                    temp = nil
                } 
            }
        }
    }

    func printValues() {
        for i in 0..<vertices {
            print("\n\(i) -> ", terminator: "")
            var temp: Node<Int>? = graph[i]
            while temp != nil {
                print("\(temp!.data) ", terminator: "")
                temp = temp?.next
            }
        }
    }

    mutating func createInitialEdges() {
        addEdge(source: 0, destination: 1)
        addEdge(source: 0, destination: 3)
        addEdge(source: 0, destination: 4)
        addEdge(source: 1, destination: 2)
        addEdge(source: 3, destination: 2)
        addEdge(source: 4, destination: 3)
//        addEdge(source: 5, destination: 4)
    }

    mutating func performOperations() {
        createInitialEdges()
        print("\n\nInitial --->", terminator: "")
        printValues()
        addVertex(vertex: 5, source: 3, destination: 2)
        addEdge(source: 5, destination: 4)
        print("\n\nAfter adding vertex 5 --->", terminator: "")
        printValues()
        deleteVertex(vertice: 4)
        print("\n\nDelete vertex 4 --->", terminator: "")
        printValues()
    }
}
