//
//  Graph.swift
//  DataStructuresSwift
//
//  Created by Pranav Pravakar on 06/07/24.
//  Copyright © 2024 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation
struct Graph {
    init() {
        var graph = [[Int]]()
        graph.append([0, 1, 0, 0])
        graph.append([1, 0, 1, 0])
        graph.append([0, 1, 0, 1])
        graph.append([0, 0, 1, 0])

        let vertices = graph.count
        let adjacencyMatrix = createAdjacencyMatrix(graph: graph, vertices: vertices)

        print("Matrix: - ")
        for i in 0..<vertices {
            print("")
            for j in 0..<vertices {
                print("\(adjacencyMatrix[i][j]) ", terminator: "")
            }
        }

        let edges = [[0, 1], [0, 2], [1, 2], [2, 3], [3, 1]]
        let adjacencyList = createAdjacencyList(edges: edges, vertices: 4)
        print("\n\nAdjacency List: - ")
        for i in 0..<vertices {
            print("\n\(i) -> ", terminator: "")
            for j in 0..<adjacencyList[i].count {
                print("\(adjacencyList[i][j]) ", terminator: "")
            }
        }
    }

    func createAdjacencyList(edges: [[Int]], vertices: Int) -> [[Int]] {
        var list = [[Int]](repeating: [], count: vertices)
        for edge in edges {
            let u = edge[0]
            let v = edge[1]
            list[u].append(v)
            list[v].append(u)
        }

        return list
    }

    func createAdjacencyMatrix(graph: [[Int]], vertices: Int) -> [[Int]] {
        var adjacencyMatrix = [[Int]](repeating: [Int](repeating: 0, count: vertices), count: vertices)

        for i in 0..<vertices {
            for j in 0..<vertices {
                if graph[i][j] == 1 {
                    adjacencyMatrix[i][j] = 1
                    // For undirected graph
                    adjacencyMatrix[j][i] = 1
                }
            }
        }

        return adjacencyMatrix
    }
}
