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

        let grid = [
          [Character("1"), "1", "1", "1", "0"],
          ["1", "1", "0", "1", "0"],
          ["1", "1", "0", "0", "0"],
          ["0", "0", "0", "0", "0"]
        ]
        print("Islands for grid - \(grid) is \(numIslands(grid))")

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

    /*
     Given an undirected graph with V vertices, find number of provinces. Two vertices u and v belong to single province if
     path exists from u to v or v to u
     */

    // SC - O(n) + O(n) (recursion stack space), excluding the adjacency list
    // TC - O(n) + O(V + 2e)
    func provinces(adjacencyMatrix: [[Int]], node: Int) -> Int {
        let count = adjacencyMatrix.count
        var adjacencyList = Array(repeating: [Int](), count: count)
        for i in 0..<count {
            for j in 0..<count {
                if i != j && adjacencyMatrix[i][j] == 1 {
                    adjacencyList[i].append(j)
                    // adjacencyList[j].append(i)
                }
            }
        }
        var result = 0
        var visited = Set<Int>()
        for i in 0..<count {
            if !visited.contains(i) {
                result += 1
                dfsTraversal(adjacencyList: adjacencyList, node: i, visited: &visited)
            }
        }

        return result
    }

    func dfsTraversal(adjacencyList: [[Int]], node: Int, visited: inout Set<Int>) {
        visited.insert(node)
        for i in adjacencyList[node] {
            if !visited.contains(i) {
                dfsTraversal(adjacencyList: adjacencyList, node: i, visited: &visited)
            }
        }
    }

    /*
     Given an m x n 2D binary grid grid which represents a map of '1's (land) and '0's (water), return the number of islands.

     An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of the grid are all surrounded by water.



     Example 1:

     Input: grid = [
       ["1","1","1","1","0"],
       ["1","1","0","1","0"],
       ["1","1","0","0","0"],
       ["0","0","0","0","0"]
     ]
     Output: 1
     Example 2:

     Input: grid = [
       ["1","1","0","0","0"],
       ["1","1","0","0","0"],
       ["0","0","1","0","0"],
       ["0","0","0","1","1"]
     ]
     Output: 3


     Constraints:

     m == grid.length
     n == grid[i].length
     1 <= m, n <= 300
     grid[i][j] is '0' or '1'.
     */

    struct HashablePair<T: Hashable>: Hashable {
        let x: T
        let y: T
    }
    
    func numIslands(_ grid: [[Character]]) -> Int {
        if grid.isEmpty {
            return 0
        }
        let row = grid.count
        let column = grid[0].count
        
        var visited = Set<HashablePair<Int>>()
        var count = 0
        for i in 0..<row {
            for j in 0..<column {
                if !visited.contains(HashablePair(x: i, y: j)) && grid[i][j] == "1" {
                    count += 1
                    bfs(visited: &visited, grid: grid, row: i, column: j)
                    
                }
            }
        }
        return count
    }
    
    private func bfs(visited: inout Set<HashablePair<Int>>, grid: [[Character]], row: Int, column: Int) {
        visited.insert(HashablePair(x: row, y: column))
        var queue = [HashablePair<Int>]()
        queue.append(HashablePair(x: row, y: column))
        while !queue.isEmpty {
            let element = queue.removeFirst()
            let currentRow = element.x
            let currentColumn = element.y
            for i in stride(from: -1, through: 1,  by: 1) {
                for j in stride(from: -1, through: 1,  by: 1)  {
                    if i != 0 && j != 0 {
                        continue
                    }
                    let newRow = currentRow + i
                    let newColumn = currentColumn + j
                    if newRow >= 0 && newRow < grid.count &&
                        newColumn >= 0 && newColumn < grid[0].count &&
                        !visited.contains(HashablePair(x: newRow, y: newColumn)) && grid[newRow][newColumn] == "1" {
                        visited.insert(HashablePair(x: newRow, y: newColumn))
                        queue.append(HashablePair(x: newRow, y: newColumn))
                    }
                }
            }
        }
    }
}
