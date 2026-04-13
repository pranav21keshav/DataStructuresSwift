//
//  Graph.swift
//  DataStructuresSwift
//
//  Created by Pranav Pravakar on 06/07/24.
//  Copyright © 2024 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation
struct Pair {
    var edge: Int
    var weight: Int
}
struct Graph {
    // Total degree of graph = 2 * E
    // Degree of a node in undriected graph is total number of edges
    // Diected Graph - Indegree, Outdegree
    // Indegree - Number of incoming edges
    // Outdegree - Number of outgoing edges
    // Edge Weight -
    // Weighted graph
    // Bipartitie graph - adjacent egdes are in different color
    // Linear graph is always bipartite
    // Graph with even cycle length can be bipartite
    // Graph with odd cycle length can not be bipartite

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

        let grid: [[Character]] = [
          ["1", "1", "1", "1", "0"],
          ["1", "1", "0", "1", "0"],
          ["1", "1", "0", "0", "0"],
          ["0", "0", "0", "0", "0"]
        ]
//        print("Islands for grid - \(grid) is \(numIslands(grid))")

        let grid2: [[Character]] = [
          ["1", "1", "0", "0", "0"],
          ["1", "1", "0", "0", "0"],
          ["0", "0", "1", "0", "0"],
          ["0", "0", "0", "1", "1"]
        ]
//        print("Islands for grid - \(grid2) is \(numIslands(grid2))")
    }

    // SC - O(2E), For dircted graph - O(E)
    func createAdjacencyList(edges: [[Int]], vertices: Int) -> [[Int]] {
        var list = [[Int]](repeating: [], count: vertices)
        for edge in edges {
            let u = edge[0]
            let v = edge[1]
            list[u].append(v)
            // For undirected graph

            list[v].append(u)
        }

        return list
    }

    // SC - O(n^2)
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

    // SC - O(3n)
    // TC - O(n) + O(2E) - Undirected graph
    func bfs(node: Int, adjacencyList: [[Int]]) -> [Int] {
        var result = [Int]()
        var visited = Set<Int>()
        var queue = Queue<Int>()
        visited.insert(0)
        queue.enqueue(0)
        while !queue.isEmpty() {
            let node = queue.dequeue()!
            result.append(node)
            for i in adjacencyList[node] {
                if !visited.contains(i) {
                    visited.insert(i)
                    queue.enqueue(i)
                }
            }
        }

        return result
    }

    // SC - O(n) (result) + O(n) (visited) + O(n) (stack space)
    // TC - O(n) + O(2E) - Undirected graph
    func dfsAdjacencyList(adjacencyList: [[Int]]) -> [Int] {
        var result = [Int]()
        var visited = Set<Int>()

        dfsRecursiondjacencyList(adjacencyList: adjacencyList, node: 0, visited: &visited, result: &result)
        return result
    }

    func dfsRecursiondjacencyList(adjacencyList: [[Int]], node: Int, visited: inout Set<Int>, result: inout [Int]) {
        result.append(node)
        visited.insert(node)
        for i in adjacencyList[node] {
            if !visited.contains(i) {
                dfsRecursiondjacencyList(adjacencyList: adjacencyList, node: i, visited: &visited, result: &result)
            }
        }
    }
}
