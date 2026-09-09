//
//  GraphProblems.swift
//  DataStructuresSwift
//
//  Created by Pranav pravakar on 23/11/25.
//  Copyright © 2025 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation
// swiftlint:disable file_length
extension GraphProblems.Pair: Hashable {}
struct HeapItem3<T: Comparable & Hashable> {
    let x: T
    let y: T
    let z: T
}

extension HeapItem3: Comparable {
    public static func < (lhs: HeapItem3, rhs: HeapItem3) -> Bool {
        if lhs.x == rhs.x {
            return lhs.y < rhs.y && lhs.z < rhs.z
        }
        return lhs.x < rhs.x
    }
}
struct GraphProblems {
    init() {
        print("Alien Dictionary - \(alienOrder(["z", "x"]))")
        let elements1 = [[1, 2, 2], [3, 8, 2], [5, 3, 5]]
        let elements2 = [[1, 2, 3], [3, 8, 4], [5, 3, 5]]
        let elements3 = [[1, 2, 1, 1, 1], [1, 2, 1, 2, 1], [1, 2, 1, 2, 1], [1, 2, 1, 2, 1], [1, 1, 1, 2, 1]]
        print(minimumEffortPath(elements1))
        print(minimumEffortPath(elements2))
        print(minimumEffortPath(elements3))
        let flights = [[0, 1, 100], [1, 2, 100], [2, 0, 100], [1, 3, 600], [2, 3, 200]]

        print("CheapestFlight - \(findCheapestPrice(4, flights, 0, 3, 1))")
    }
    /*
     547. Number of Provinces

     There are n cities. Some of them are connected, while some are not. If city a is connected directly with city b, and city b is connected directly with city c, then city a is connected indirectly with city c.

     A province is a group of directly or indirectly connected cities and no other cities outside of the group.

     You are given an n x n matrix isConnected where isConnected[i][j] = 1 if the ith city and the jth city are directly connected, and isConnected[i][j] = 0 otherwise.

     Return the total number of provinces.



     Example 1:


     Input: isConnected = [[1,1,0],[1,1,0],[0,0,1]]
     Output: 2
     Example 2:


     Input: isConnected = [[1,0,0],[0,1,0],[0,0,1]]
     Output: 3


     Constraints:

     1 <= n <= 200
     n == isConnected.length
     n == isConnected[i].length
     isConnected[i][j] is 1 or 0.
     isConnected[i][i] == 1
     isConnected[i][j] == isConnected[j][i]
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
                dfsTraversalProvinces(adjacencyList: adjacencyList, node: i, visited: &visited)
            }
        }

        return result
    }

    func dfsTraversalProvinces(adjacencyList: [[Int]], node: Int, visited: inout Set<Int>) {
        visited.insert(node)
        for i in adjacencyList[node] {
            if !visited.contains(i) {
                dfsTraversalProvinces(adjacencyList: adjacencyList, node: i, visited: &visited)
            }
        }
    }

    func provincesAdjacencyMatrix(_ isConnected: [[Int]]) -> Int {
        let count = isConnected.count
        var result = 0
        var visited = Set<Int>()
        for i in 0..<count {
            if !visited.contains(i) {
                result += 1
                dfsTraversalAdjacencyMatrix(adjacencyMatrix: isConnected, node: i, visited: &visited)
            }
        }

        return result
    }

    func dfsTraversalAdjacencyMatrix(adjacencyMatrix: [[Int]], node: Int, visited: inout Set<Int>) {
        visited.insert(node)
        for i in 0..<adjacencyMatrix[node].count {
            if adjacencyMatrix[node][i] == 1 && !visited.contains(i) {
                dfsTraversalAdjacencyMatrix(adjacencyMatrix: adjacencyMatrix, node: i, visited: &visited)
            }
        }
    }

    /*

     Number of Islands

     Given an m x n 2D binary grid grid which represents a map of '1's (land) and '0's (water), return the number of islands.

     An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of the grid are
     all surrounded by water.



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

    // TC - O(n ^ 2)
    // SC - O(n ^ 2)
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
             for i in stride(from: -1, through: 1, by: 1) {
                 for j in stride(from: -1, through: 1, by: 1) {
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
    /*


     733. Flood Fill

     Hint
     You are given an image represented by an m x n grid of integers image, where image[i][j] represents the pixel value of the image. You are also given three integers sr, sc, and color. Your task is to perform a flood fill on the image starting from the pixel image[sr][sc].

     To perform a flood fill:

     Begin with the starting pixel and change its color to color.
     Perform the same process for each pixel that is directly adjacent (pixels that share a side with the original pixel, either horizontally or vertically) and shares the same color as the starting pixel.
     Keep repeating this process by checking neighboring pixels of the updated pixels and modifying their color if it matches the original color of the starting pixel.
     The process stops when there are no more adjacent pixels of the original color to update.
     Return the modified image after performing the flood fill.



     Example 1:

     Input: image = [[1,1,1],[1,1,0],[1,0,1]], sr = 1, sc = 1, color = 2

     Output: [[2,2,2],[2,2,0],[2,0,1]]

     Explanation:



     From the center of the image with position (sr, sc) = (1, 1) (i.e., the red pixel), all pixels connected by a path of the same color as the starting pixel (i.e., the blue pixels) are colored with the new color.

     Note the bottom corner is not colored 2, because it is not horizontally or vertically connected to the starting pixel.

     Example 2:

     Input: image = [[0,0,0],[0,0,0]], sr = 0, sc = 0, color = 0

     Output: [[0,0,0],[0,0,0]]

     Explanation:

     The starting pixel is already colored with 0, which is the same as the target color. Therefore, no changes are made to the image.



     Constraints:

     m == image.length
     n == image[i].length
     1 <= m, n <= 50
     0 <= image[i][j], color < 216
     0 <= sr < m
     0 <= sc < n
     */

    func floodFill(_ image: [[Int]], _ sr: Int, _ sc: Int, _ color: Int) -> [[Int]] {
        var result = image
        dfsFloodFill(image: image, result: &result, row: sr, column: sc, initialColor: image[sr][sc], newColor: color)
        return result
    }

    func floodFillBFS(_ image: [[Int]], _ sr: Int, _ sc: Int, _ color: Int) -> [[Int]] {
        var result = image
        let delRow = [0, -1, 0, 1]
        let delColumn = [-1, 0, 1, 0]
        let rowCount = image.count
        let columnCount = image[0].count
        var queue = [Pair]()
        let initialColor = image[sr][sc]
        queue.append(Pair(x: sr, y: sc))
        result[sr][sc] = color
        while !queue.isEmpty {
            let pair = queue.removeFirst()
            for index in stride(from: 0, through: 3, by: 1) {
                let newRow = pair.x + delRow[index]
                let newColumn = pair.y + delColumn[index]
                if newRow >= 0 && newRow < rowCount && newColumn >= 0 && newColumn < columnCount && image[newRow][newColumn] == initialColor && result[newRow][newColumn] != color {
                    queue.append(Pair(x: newRow, y: newColumn))
                    result[newRow][newColumn] = color
                }
            }
        }

        return result
    }

    private func  dfsFloodFill(image: [[Int]], result: inout [[Int]], row: Int, column: Int, initialColor: Int, newColor: Int) {
        result[row][column] = newColor
        let delRow = [0, -1, 0, 1]
        let delColumn = [-1, 0, 1, 0]
        let rowCount = image.count
        let columnCount = image[0].count
        for index in stride(from: 0, through: 3, by: 1) {
            let newRow = row + delRow[index]
            let newColumn = column + delColumn[index]
            if newRow >= 0 && newRow < rowCount && newColumn >= 0 && newColumn < columnCount && image[newRow][newColumn] == initialColor && result[newRow][newColumn] != newColor {
                dfsFloodFill(image: image, result: &result, row: newRow, column: newColumn, initialColor: initialColor, newColor: newColor)
            }
        }
    }
    /*
     994. Rotting Oranges
   
     You are given an m x n grid where each cell can have one of three values:

     0 representing an empty cell,
     1 representing a fresh orange, or
     2 representing a rotten orange.
     Every minute, any fresh orange that is 4-directionally adjacent to a rotten orange becomes rotten.

     Return the minimum number of minutes that must elapse until no cell has a fresh orange. If this is impossible, return -1.



     Example 1:


     Input: grid = [[2,1,1],[1,1,0],[0,1,1]]
     Output: 4
     Example 2:

     Input: grid = [[2,1,1],[0,1,1],[1,0,1]]
     Output: -1
     Explanation: The orange in the bottom left corner (row 2, column 0) is never rotten, because rotting only happens 4-directionally.
     Example 3:

     Input: grid = [[0,2]]
     Output: 0
     Explanation: Since there are already no fresh oranges at minute 0, the answer is just 0.


     Constraints:

     m == grid.length
     n == grid[i].length
     1 <= m, n <= 10
     grid[i][j] is 0, 1, or 2.
     */

    struct RCTPair {
        let row: Int
        let column: Int
        let time: Int
    }

    func orangesRotting(_ grid: [[Int]]) -> Int {
        let rowCount = grid.count
        let columnCount = grid[0].count
        var queue = [RCTPair]()
        var originalCount = 0
        var visited = [[Int]](repeating: [Int](repeating: 0, count: columnCount), count: rowCount)
        for i in stride(from: 0, through: rowCount - 1, by: 1) {
            for j in stride(from: 0, through: columnCount - 1, by: 1) {
                if grid[i][j] == 2 {
                    queue.append(RCTPair(row: i, column: j, time: 0))
                    visited[i][j] = 2
                }
                if grid[i][j] == 1 {
                    originalCount += 1
                }
            }
        }

        let delRow = [0, -1, 0, 1]
        let delColumn = [-1, 0, 1, 0]
        var maxTime = 0
        var newCount = 0
        while !queue.isEmpty {
            let element = queue.removeFirst()
            maxTime = max(maxTime, element.time)
            for i in stride(from: 0, through: 3, by: 1) {
                let newRow = element.row + delRow[i]
                let newColumn = element.column + delColumn[i]
                if newRow >= 0 && newRow < rowCount && newColumn >= 0 && newColumn < columnCount && visited[newRow][newColumn] == 0 && grid[newRow][newColumn] == 1 {
                    queue.append(RCTPair(row: newRow, column: newColumn, time: element.time + 1))
                    visited[newRow][newColumn] = 2
                    newCount += 1
                }
            }
        }
        return newCount == originalCount ? maxTime : -1
    }

    struct Pair {
        let x: Int
        let y: Int
    }

    func detectCycleBFS(source: Int, adjacencyList: [[Int]], visited: inout Set<Int>) -> Bool {
        var queue = [Pair]()
        visited.insert(source)
        queue.append(Pair(x: source, y: -1))
        while !queue.isEmpty {
            let currentNode = queue.removeFirst()
            for node in adjacencyList[currentNode.x] {
                if !visited.contains(node) {
                    visited.insert(node)
                    queue.append(Pair(x: node, y: currentNode.x))
                } else if node != currentNode.y {
                    return true
                }
            }
        }
        return false
    }

    // TC -  O(N + 2E) + O (N)
    // SC - O(N) + O(N)
    func isCycleBFS(vertices: [Int], adjacencyList: [[Int]]) -> Bool {
        var visited = Set<Int>()
        for v in vertices {
            if !visited.contains(v) {
                if detectCycleBFS(source: v, adjacencyList: adjacencyList, visited: &visited) {
                    return true
                }
            }
        }
        return false
    }

    func detectCycleDFS(node: Int, parent: Int, visited: inout Set<Int>, adjacencyList: [[Int]]) -> Bool {
        visited.insert(node)
        for adjacentNode in adjacencyList[node] {
            if !visited.contains(adjacentNode) {
                if detectCycleDFS(node: adjacentNode, parent: node, visited: &visited, adjacencyList: adjacencyList) {
                    return true
                }
            } else if adjacentNode != parent {
                return true
            }
        }
        return false
    }

    func isCycleDFS(vertices: [Int], adjacencyList: [[Int]]) -> Bool {
        var visited = Set<Int>()
        for vertice in vertices {
            if !visited.contains(vertice) {
                if detectCycleDFS(node: vertice, parent: -1, visited: &visited, adjacencyList: adjacencyList) {
                    return true
                }
            }
        }
        return false
    }

    /*
     Solutions

     542. 01 Matrix

     Given an m x n binary matrix mat, return the distance of the nearest 0 for each cell.

     The distance between two cells sharing a common edge is 1.



     Example 1:


     Input: mat = [[0,0,0],[0,1,0],[0,0,0]]
     Output: [[0,0,0],[0,1,0],[0,0,0]]
     Example 2:


     Input: mat = [[0,0,0],[0,1,0],[1,1,1]]
     Output: [[0,0,0],[0,1,0],[1,2,1]]


     Constraints:

     m == mat.length
     n == mat[i].length
     1 <= m, n <= 104
     1 <= m * n <= 104
     mat[i][j] is either 0 or 1.
     There is at least one 0 in mat.


     Note: This question is the same as 1765: https://leetcode.com/problems/map-of-highest-peak/
     */

    struct RCInfo {
        let row: Int
        let column: Int
        let info: Int
    }

    // TC - O(n * m * 4 + n * m)
    // SC - O(n * m * 2)
    func updateMatrix(_ mat: [[Int]]) -> [[Int]] {
        let rowCount = mat.count
        let columnCount = mat[0].count
        var visited = [[Bool]](repeating: [Bool](repeating: false, count: columnCount), count: rowCount)
        var distance = [[Int]](repeating: [Int](repeating: 0, count: columnCount), count: rowCount)
        var queue = [RCInfo]()
        for i in stride(from: 0, through: rowCount - 1, by: 1) {
            for j in stride(from: 0, through: columnCount - 1, by: 1) {
                if mat[i][j] == 0 {
                    visited[i][j] = true
                    queue.append(RCInfo(row: i, column: j, info: 0))
                }
            }
        }

        while !queue.isEmpty {
            let top = queue.removeFirst()
            let delRow = [0, -1, 0, 1]
            let delColumn = [-1, 0, 1, 0]
            distance[top.row][top.column] = top.info
            for index in stride(from: 0, through: 3, by: 1) {
                let newRow = top.row + delRow[index]
                let newColumn = top.column + delColumn[index]
                if newRow >= 0 && newRow < rowCount && newColumn >= 0 && newColumn < columnCount && !visited[newRow][newColumn] && mat[newRow][newColumn] != 0 {
                    visited[newRow][newColumn] = true
                    queue.append(RCInfo(row: newRow, column: newColumn, info: top.info + 1))
                }
            }
        }
        return distance
    }

    /*
     130. Surrounded Regions
     Medium

     You are given an m x n matrix board containing letters 'X' and 'O', capture regions that are surrounded:

     Connect: A cell is connected to adjacent cells horizontally or vertically.
     Region: To form a region connect every 'O' cell.
     Surround: The region is surrounded with 'X' cells if you can connect the region with 'X' cells and none of the region cells are on the edge of the board.
     To capture a surrounded region, replace all 'O's with 'X's in-place within the original board. You do not need to return anything.



     Example 1:

     Input: board = [["X","X","X","X"],["X","O","O","X"],["X","X","O","X"],["X","O","X","X"]]

     Output: [["X","X","X","X"],["X","X","X","X"],["X","X","X","X"],["X","O","X","X"]]

     Explanation:


     In the above diagram, the bottom region is not captured because it is on the edge of the board and cannot be surrounded.

     Example 2:

     Input: board = [["X"]]

     Output: [["X"]]



     Constraints:

     m == board.length
     n == board[i].length
     1 <= m, n <= 200
     board[i][j] is 'X' or 'O'.
     */

    func solveBFS(_ board: inout [[Character]]) {
        let rowCount = board.count
        let columnCount = board[0].count
        var queue = [HashablePair<Int>]()
        var visited = Set<HashablePair<Int>>()
        for i in stride(from: 0, through: rowCount - 1, by: 1) {
            for j in stride(from: 0, through: columnCount - 1, by: 1) {
                if i == 0 || i == rowCount - 1 || j == 0 || j == columnCount - 1 {
                    let rc = HashablePair(x: i, y: j)
                    if board[i][j] == "O" && !visited.contains(rc) {
                        visited.insert(HashablePair(x: i, y: j))
                        queue.append(HashablePair(x: i, y: j))
                    }
                }
            }
        }

        let delRow = [-1, 0, 1, 0]
        let delColumn = [0, -1, 0, 1]

        while !queue.isEmpty {
            let element = queue.removeFirst()
            for i in stride(from: 0, through: 3, by: 1) {
                let newRow = element.x + delRow[i]
                let newColumn = element.y + delColumn[i]
                if isRowColumnValid(row: newRow, column: newColumn, rowCount: rowCount, columnCount: columnCount) && !visited.contains(HashablePair(x: newRow, y: newColumn)) && board[newRow][newColumn] == "O" {
                    queue.append(HashablePair(x: newRow, y: newColumn))
                    visited.insert(HashablePair(x: newRow, y: newColumn))
                }
            }
        }

        for i in stride(from: 0, through: rowCount - 1, by: 1) {
            for j in stride(from: 0, through: columnCount - 1, by: 1) {
                if board[i][j] == "O" && !visited.contains(HashablePair(x: i, y: j)) {
                    board[i][j] = "X"
                }
            }
        }

    }

    private func isRowColumnValid(row: Int, column: Int, rowCount: Int, columnCount: Int) -> Bool {
        return row >= 0 && row < rowCount && column >= 0 && column < columnCount
    }

    func solveDFS(_ board: inout [[Character]]) {
        let rowCount = board.count
        let columnCount = board[0].count
        var visited = Set<Pair>()
        for i in stride(from: 0, through: rowCount - 1, by: 1) {
            for j in stride(from: 0, through: columnCount - 1, by: 1) {
                if i == 0 || i == rowCount - 1 || j == 0 || j == columnCount - 1 {
                    if board[i][j] == "O" && !visited.contains(Pair(x: i, y: j)) {
                        dfsSolveBoard(row: i, column: j, visited: &visited, board: board)
                    }
                }
            }
        }

        for i in stride(from: 0, through: rowCount - 1, by: 1) {
            for j in stride(from: 0, through: columnCount - 1, by: 1) {
                if board[i][j] == "O" && !visited.contains(Pair(x: i, y: j)) {
                    board[i][j] = "X"
                }
            }
        }

    }

    func dfsSolveBoard(row: Int, column: Int, visited: inout Set<Pair>, board: [[Character]]) {
        visited.insert(Pair(x: row, y: column))
        let rowCount = board.count
        let columnCount = board[0].count
        let delRow = [-1, 0, 1, 0]
        let delColumn = [0, -1, 0, 1]

        for i in stride(from: 0, through: 3, by: 1) {
            let newRow = row + delRow[i]
            let newColumn = column + delColumn[i]
            if isRowColumnValid(row: newRow, column: newColumn, rowCount: rowCount, columnCount: columnCount) && !visited.contains(Pair(x: newRow, y: newColumn)) && board[newRow][newColumn] == "O" {
                dfsSolveBoard(row: newRow, column: newColumn, visited: &visited, board: board)
            }
        }
    }

    /*
     1020. Number of Enclaves

     You are given an m x n binary matrix grid, where 0 represents a sea cell and 1 represents a land cell.

     A move consists of walking from one land cell to another adjacent (4-directionally) land cell or walking off the boundary of the grid.

     Return the number of land cells in grid for which we cannot walk off the boundary of the grid in any number of moves.



     Example 1:


     Input: grid = [[0,0,0,0],[1,0,1,0],[0,1,1,0],[0,0,0,0]]
     Output: 3
     Explanation: There are three 1s that are enclosed by 0s, and one 1 that is not enclosed because its on the boundary.
     Example 2:


     Input: grid = [[0,1,1,0],[0,0,1,0],[0,0,1,0],[0,0,0,0]]
     Output: 0
     Explanation: All 1s are either on the boundary or can reach the boundary.


     Constraints:

     m == grid.length
     n == grid[i].length
     1 <= m, n <= 500
     grid[i][j] is either 0 or 1.
     */

    func numEnclavesBFS(_ grid: [[Int]]) -> Int {
        let rowCount = grid.count
        let columnCount = grid[0].count
        var visited = [[Bool]](repeating: [Bool](repeating: false, count: columnCount), count: rowCount)
        var result = 0
        var queue = [Pair]()
        for i in stride(from: 0, through: rowCount - 1, by: 1) {
            for j in stride(from: 0, through: columnCount - 1, by: 1) {
                if i == 0 || i == rowCount - 1 || j == 0 || j == columnCount - 1 {
                    if grid[i][j] == 1 && !visited[i][j] {
                        visited[i][j] = true
                        queue.append(Pair(x: i, y: j))
                    }
                }
            }
        }
        while !queue.isEmpty {
            let delRow = [-1, 0, 1, 0]
            let delColumn = [0, -1, 0, 1]
            let element = queue.removeFirst()

            for i in stride(from: 0, through: 3, by: 1) {
                let newRow = element.x + delRow[i]
                let newColumn = element.y + delColumn[i]
                if isRowColumnValid(row: newRow, column: newColumn, rowCount: rowCount, columnCount: columnCount) && !visited[newRow][newColumn] && grid[newRow][newColumn] == 1 {
                    visited[newRow][newColumn] = true
                    queue.append(Pair(x: newRow, y: newColumn))
                }
            }
        }

        for i in stride(from: 0, through: rowCount - 1, by: 1) {
            for j in stride(from: 0, through: columnCount - 1, by: 1) {
                if grid[i][j] == 1 && !visited[i][j] {
                    result += 1
                }
            }
        }
        return result
    }

    func numEnclavesDFS(_ grid: [[Int]]) -> Int {
        let rowCount = grid.count
        let columnCount = grid[0].count
        var visited = [[Bool]](repeating: [Bool](repeating: false, count: columnCount), count: rowCount)
        var result = 0

        for i in stride(from: 0, through: rowCount - 1, by: 1) {
            for j in stride(from: 0, through: columnCount - 1, by: 1) {
                if i == 0 || i == rowCount - 1 || j == 0 || j == columnCount - 1 {
                    if grid[i][j] == 1 && !visited[i][j] {
                        dfsEncalves(row: i, column: j, visited: &visited, grid: grid)
                    }
                }
            }
        }

        for i in stride(from: 0, through: rowCount - 1, by: 1) {
            for j in stride(from: 0, through: columnCount - 1, by: 1) {
                if grid[i][j] == 1 && !visited[i][j] {
                    result += 1
                }
            }
        }
        return result
    }

    func dfsEncalves(row: Int, column: Int, visited: inout [[Bool]], grid: [[Int]]) {
        visited[row][column] = true
        let rowCount = grid.count
        let columnCount = grid[0].count
        let delRow = [-1, 0, 1, 0]
        let delColumn = [0, -1, 0, 1]

        for i in stride(from: 0, through: 3, by: 1) {
            let newRow = row + delRow[i]
            let newColumn = column + delColumn[i]
            if isRowColumnValid(row: newRow, column: newColumn, rowCount: rowCount, columnCount: columnCount) && !visited[newRow][newColumn] && grid[newRow][newColumn] == 1 {
                dfsEncalves(row: newRow, column: newColumn, visited: &visited, grid: grid)
            }
        }
    }
    /*

     Code
    
     694. Number of Distinct Islands
     You are given an m x n binary matrix grid. An island is a group of 1's (representing land) connected 4-directionally (horizontal or vertical.) You may assume all four edges of the grid are surrounded by water.

     An island is considered to be the same as another if and only if one island can be translated (and not rotated or reflected) to equal the other.

     Return the number of distinct islands.



     Example 1:


     Input: grid = [[1,1,0,0,0],[1,1,0,0,0],[0,0,0,1,1],[0,0,0,1,1]]
     Output: 1
     Example 2:


     Input: grid = [[1,1,0,1,1],[1,0,0,0,0],[0,0,0,0,1],[1,1,0,1,1]]
     Output: 3


     Constraints:

     m == grid.length
     n == grid[i].length
     1 <= m, n <= 50
     grid[i][j] is either 0 or 1.
     */

    // TC - O(n * m) + O(n * m * 4)
    // SC - O(n * m)
    func numDistinctIslands(_ grid: [[Int]]) -> Int {
        let rowCount = grid.count
        let columnCount = grid[0].count
        var visited = [[Bool]](repeating: [Bool](repeating: false, count: columnCount), count: rowCount)
        var set = Set<[[Int]]>()
        for i in stride(from: 0, through: rowCount - 1, by: 1) {
            for j in stride(from: 0, through: columnCount - 1, by: 1) {

                if !visited[i][j] && grid[i][j] == 1 {
                    var list = [[Int]]()
                    dfsDistincIslands(row: i, column: j, row1: i, column1: j, visited: &visited, list: &list, grid: grid)
                    set.insert(list)
                }
            }
        }
        return set.count
    }

    func dfsDistincIslands(row: Int, column: Int, row1: Int, column1: Int, visited: inout [[Bool]], list: inout [[Int]], grid: [[Int]]) {
        visited[row][column] = true
        list.append([row1 - row, column1 - column])
        let rowCount = grid.count
        let columnCount = grid[0].count
        let delRow = [-1, 0, 1, 0]
        let delColumn = [0, -1, 0, 1]
        for i in stride(from: 0, through: 3, by: 1) {
            let newRow = row + delRow[i]
            let newColumn = column + delColumn[i]
            if newRow >= 0 && newRow < rowCount && newColumn >= 0 && newColumn < columnCount && !visited[newRow][newColumn] && grid[newRow][newColumn] == 1 {
                dfsDistincIslands(row: newRow, column: newColumn, row1: row1, column1: column1, visited: &visited, list: &list, grid: grid)
            }
        }
    }

    /*
     785. Is Graph Bipartite?

     There is an undirected graph with n nodes, where each node is numbered between 0 and n - 1. You are given a 2D array graph, where graph[u] is an array of nodes that node u is adjacent to. More formally, for each v in graph[u], there is an undirected edge between node u and node v. The graph has the following properties:

     There are no self-edges (graph[u] does not contain u).
     There are no parallel edges (graph[u] does not contain duplicate values).
     If v is in graph[u], then u is in graph[v] (the graph is undirected).
     The graph may not be connected, meaning there may be two nodes u and v such that there is no path between them.
     A graph is bipartite if the nodes can be partitioned into two independent sets A and B such that every edge in the graph connects a node in set A and a node in set B.

     Return true if and only if it is bipartite.



     Example 1:


     Input: graph = [[1,2,3],[0,2],[0,1,3],[0,2]]
     Output: false
     Explanation: There is no way to partition the nodes into two independent sets such that every edge connects a node in one and a node in the other.
     Example 2:


     Input: graph = [[1,3],[0,2],[1,3],[0,2]]
     Output: true
     Explanation: We can partition the nodes into two sets: {0, 2} and {1, 3}.


     Constraints:

     graph.length == n
     1 <= n <= 100
     0 <= graph[u].length < n
     0 <= graph[u][i] <= n - 1
     graph[u] does not contain u.
     All the values of graph[u] are unique.
     If graph[u] contains v, then graph[v] contains u.
     */
    func isBipartiteDFS(_ graph: [[Int]]) -> Bool {
        let count = graph.count
        var colors = [Int](repeating: -1, count: count)
        for i in stride(from: 0, through: count - 1, by: 1) {
            if colors[i] == -1 {
                if isBipartiteDFS(node: i, graph: graph, colors: &colors, color: 0) == false {
                    return false
                }
            }
        }
        return true
    }

    private func isBipartiteDFS(node: Int, graph: [[Int]], colors: inout [Int], color: Int) -> Bool {
        colors[node] = color
        for adjacentNode in graph[node] {
            if colors[adjacentNode] == -1 {
                if isBipartiteDFS(node: adjacentNode, graph: graph, colors: &colors, color: 1 - color) == false {
                    return false
                }
            } else if colors[adjacentNode] == color {
                return false
            }
        }
        return true
    }

    // detectCycle In directed graph
    func cycleDirectedGraph(_ graph: [[Int]]) -> Bool {
        let count = graph.count
        var visited = [Bool](repeating: false, count: count)
        var pathVisited = [Bool](repeating: false, count: count)

        for i in stride(from: 0, through: count - 1, by: 1) {
            if !visited[i] {
                if cycleDirectedGraph(graph: graph, node: i, visited: &visited, pathVisited: &pathVisited) {
                    return true
                }
            }
        }
        return false
    }

    private func cycleDirectedGraph(graph: [[Int]], node: Int, visited: inout [Bool], pathVisited: inout [Bool]) -> Bool {
        visited[node] = true
        pathVisited[node] = true
        for adjacentNode in graph[node] {
            if !visited[adjacentNode] {
                if cycleDirectedGraph(graph: graph, node: adjacentNode, visited: &visited, pathVisited: &pathVisited) {
                    return true
                }
            } else if pathVisited[adjacentNode] {
                return true
            }
        }
        pathVisited[node] = false

        return false
    }

    /*
     802. Find Eventual Safe States

     There is a directed graph of n nodes with each node labeled from 0 to n - 1. The graph is represented by a 0-indexed 2D integer array graph where graph[i] is an integer array of nodes adjacent to node i, meaning there is an edge from node i to each node in graph[i].

     A node is a terminal node if there are no outgoing edges. A node is a safe node if every possible path starting from that node leads to a terminal node (or another safe node).

     Return an array containing all the safe nodes of the graph. The answer should be sorted in ascending order.



     Example 1:

     Illustration of graph
     Input: graph = [[1,2],[2,3],[5],[0],[5],[],[]]
     Output: [2,4,5,6]
     Explanation: The given graph is shown above.
     Nodes 5 and 6 are terminal nodes as there are no outgoing edges from either of them.
     Every path starting at nodes 2, 4, 5, and 6 all lead to either node 5 or 6.
     Example 2:

     Input: graph = [[1,2,3,4],[1,2],[3,4],[0,4],[]]
     Output: [4]
     Explanation:
     Only node 4 is a terminal node, and every path starting at node 4 leads to node 4.


     Constraints:

     n == graph.length
     1 <= n <= 104
     0 <= graph[i].length <= n
     0 <= graph[i][j] <= n - 1
     graph[i] is sorted in a strictly increasing order.
     The graph may contain self-loops.
     The number of edges in the graph will be in the range [1, 4 * 104].
     */

    // SC - O(3n)
    // TC - O(V + E)
    func eventualSafeNodes(_ graph: [[Int]]) -> [Int] {
        let count = graph.count
        var visited = [Bool](repeating: false, count: count)
        var pathVisited = [Bool](repeating: false, count: count)
        var safe = [Bool](repeating: false, count: count)
        for i in stride(from: 0, through: count - 1, by: 1) {
            if !visited[i] {
                safeDFS(node: i, graph: graph, visited: &visited, pathVisited: &pathVisited, safe: &safe)
            }
        }
        var result = [Int]()
        for i in stride(from: 0, through: count - 1, by: 1) {
            if safe[i] {
                result.append(i)
            }
        }
        return result
    }

    func safeDFS(node: Int, graph: [[Int]], visited: inout [Bool], pathVisited: inout [Bool], safe: inout [Bool]) -> Bool {
        visited[node] = true
        pathVisited[node] = true

        for adjacentNode in graph[node] {
            if !visited[adjacentNode] {
                if safeDFS(node: adjacentNode, graph: graph, visited: &visited, pathVisited: &pathVisited, safe: &safe) {
                    return true
                }
            } else if pathVisited[adjacentNode] {
                return true
            }
        }
        pathVisited[node] = false
        safe[node] = true
        return false
    }

    func topologicalSort(_ graph: [[Int]]) -> [Int] {
        let count = graph.count
        var visited = [Bool](repeating: false, count: count)
        var stack = [Int]()
        for i in stride(from: 0, through: count - 1, by: 1) {
            if !visited[i] {
                topologicalSortDFS(node: i, graph: graph, visited: &visited, stack: &stack)
            }
        }

        return stack.reversed()
    }

    func topologicalSortDFS(node: Int, graph: [[Int]], visited: inout [Bool], stack: inout [Int]) {
        visited[node] = true
        for adjacentNode in graph[node] {
            if !visited[adjacentNode] {
                topologicalSortDFS(node: adjacentNode, graph: graph, visited: &visited, stack: &stack)
            }
        }
        stack.append(node)
    }

    func topologicalSortBFS(graph: [[Int]]) -> [Int] {
        let count = graph.count
        var indegree = [Int](repeating: 0, count: count)
        for i in stride(from: 0, through: count - 1, by: 1) {
            for adjacentNode in graph[i] {
                indegree[adjacentNode] += 1
            }
        }

        var queue = [Int]()
        for i in stride(from: 0, through: count - 1, by: 1) {
            if indegree[i] == 0 {
                queue.append(i)
            }
        }

        var topological = [Int]()
        while !queue.isEmpty {
            let element = queue.removeFirst()
            topological.append(element)

            for adjacentNode in graph[element] {
                indegree[adjacentNode] -= 1
                if indegree[adjacentNode] == 0 {
                    queue.append(adjacentNode)
                }
            }
        }
        return topological
    }

    /*

     207. Course Schedule

     There are a total of numCourses courses you have to take, labeled from 0 to numCourses - 1. You are given an array prerequisites where prerequisites[i] = [ai, bi] indicates that you must take course bi first if you want to take course ai.

     For example, the pair [0, 1], indicates that to take course 0 you have to first take course 1.
     Return true if you can finish all courses. Otherwise, return false.



     Example 1:

     Input: numCourses = 2, prerequisites = [[1,0]]
     Output: true
     Explanation: There are a total of 2 courses to take.
     To take course 1 you should have finished course 0. So it is possible.
     Example 2:

     Input: numCourses = 2, prerequisites = [[1,0],[0,1]]
     Output: false
     Explanation: There are a total of 2 courses to take.
     To take course 1 you should have finished course 0, and to take course 0 you should also have finished course 1. So it is impossible.


     Constraints:

     1 <= numCourses <= 2000
     0 <= prerequisites.length <= 5000
     prerequisites[i].length == 2
     0 <= ai, bi < numCourses
     All the pairs prerequisites[i] are unique.
     */
    func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
        var adjacencyList = [[Int]](repeating: [Int](), count: numCourses)
        for pre in prerequisites {
            adjacencyList[pre[0]].append(pre[1])
        }

        var indegree = [Int](repeating: 0, count: numCourses)
        for i in stride(from: 0, through: numCourses - 1, by: 1) {
            for node in adjacencyList[i] {
                indegree[node] += 1
            }
        }
        var queue = [Int]()
        for i in stride(from: 0, through: numCourses - 1, by: 1) {
            if indegree[i] == 0 {
                queue.append(i)
            }
        }
        var count = 0
        while !queue.isEmpty {
            let element = queue.removeFirst()
            count += 1
            for node in adjacencyList[element] {
                indegree[node] -= 1
                if indegree[node] == 0 {
                    queue.append(node)
                }
            }
        }
        return count == numCourses
    }

    /*
     210. Course Schedule II

     There are a total of numCourses courses you have to take, labeled from 0 to numCourses - 1. You are given an array prerequisites where prerequisites[i] = [ai, bi] indicates that you must take course bi first if you want to take course ai.

     For example, the pair [0, 1], indicates that to take course 0 you have to first take course 1.
     Return the ordering of courses you should take to finish all courses. If there are many valid answers, return any of them. If it is impossible to finish all courses, return an empty array.



     Example 1:

     Input: numCourses = 2, prerequisites = [[1,0]]
     Output: [0,1]
     Explanation: There are a total of 2 courses to take. To take course 1 you should have finished course 0. So the correct course order is [0,1].
     Example 2:

     Input: numCourses = 4, prerequisites = [[1,0],[2,0],[3,1],[3,2]]
     Output: [0,2,1,3]
     Explanation: There are a total of 4 courses to take. To take course 3 you should have finished both courses 1 and 2. Both courses 1 and 2 should be taken after you finished course 0.
     So one correct course order is [0,1,2,3]. Another correct ordering is [0,2,1,3].
     Example 3:

     Input: numCourses = 1, prerequisites = []
     Output: [0]


     Constraints:

     1 <= numCourses <= 2000
     0 <= prerequisites.length <= numCourses * (numCourses - 1)
     prerequisites[i].length == 2
     0 <= ai, bi < numCourses
     ai != bi
     All the pairs [ai, bi] are distinct.
     */
    func findOrder(_ numCourses: Int, _ prerequisites: [[Int]]) -> [Int] {
        var adjacencyList = [[Int]](repeating: [Int](), count: numCourses)
        for pre in prerequisites {
            adjacencyList[pre[1]].append(pre[0])
        }
        
        var indegree = [Int](repeating: 0, count: numCourses)
        for i in stride(from: 0, through: numCourses - 1, by: 1) {
            for node in adjacencyList[i] {
                indegree[node] += 1
            }
        }
        var queue = [Int]()
        for i in stride(from: 0, through: numCourses - 1, by: 1) {
            if indegree[i] == 0 {
                queue.append(i)
            }
        }
        var order = [Int]()
        while !queue.isEmpty {
            let element = queue.removeFirst()
            order.append(element)
            for node in adjacencyList[element] {
                indegree[node] -= 1
                if indegree[node] == 0 {
                    queue.append(node)
                }
            }
        }
        return order.count == numCourses ? order : []
    }
    /*
     269. Alien Dictionary

     There is a new alien language that uses the English alphabet. However, the order of the letters is unknown to you.

     You are given a list of strings words from the alien language's dictionary. Now it is claimed that the strings in words are sorted lexicographically by the rules of this new language.

     If this claim is incorrect, and the given arrangement of string in words cannot correspond to any order of letters, return "".

     Otherwise, return a string of the unique letters in the new alien language sorted in lexicographically increasing order by the new language's rules. If there are multiple solutions, return any of them.



     Example 1:

     Input: words = ["wrt","wrf","er","ett","rftt"]
     Output: "wertf"
     Example 2:

     Input: words = ["z","x"]
     Output: "zx"
     Example 3:

     Input: words = ["z","x","z"]
     Output: ""
     Explanation: The order is invalid, so return "".


     Constraints:

     1 <= words.length <= 100
     1 <= words[i].length <= 100
     words[i] consists of only lowercase English letters.
     */

    func alienOrder(_ words: [String]) -> String {
        var adjacencyList = [[Int]](repeating: [Int](), count: 26)
        let aAsciiValue = Int(Character("a").asciiValue!)
        var exists = Set<Int>()
        // // Find unique letters present in words. This helps in adjacency list
        for word in words {
            for char in word {
                exists.insert(Int(char.asciiValue!) - aAsciiValue)
            }
        }
        // Create adjacency list
        let wordCount = words.count - 2
        for i in stride(from: 0, through: wordCount, by: 1) {
            let string1 = words[i]
            let string2 = words[i + 1]

            let minlength = min(string1.count, string2.count)
            var unmatched = false
            for j in stride(from: 0, through: minlength - 1, by: 1) {
                let char1 = string1[String.Index(utf16Offset: j, in: string1)]
                let char2 = string2[String.Index(utf16Offset: j, in: string2)]
                if char1 != char2 {
                    adjacencyList[Int(char1.asciiValue!) - aAsciiValue].append(Int(char2.asciiValue!) - aAsciiValue)
                    unmatched = true
                    break
                }
            }
            // If all match and first string count is greater then it is invalid
            if !unmatched && string1.count > string2.count {
                return ""
            }
        }

        var indegree = [Int](repeating: 0, count: 26)
        for i in stride(from: 0, through: 25, by: 1) where exists.contains(i) {
            for node in adjacencyList[i] {
                indegree[node] += 1
            }
        }
        var queue = [Int]()
        for i in stride(from: 0, through: 25, by: 1) where exists.contains(i) {
            if indegree[i] == 0 {
                queue.append(i)
            }
        }
        var topo = [UInt8]()
        while !queue.isEmpty {
            let node = queue.removeFirst()
            topo.append(UInt8(exactly: node + aAsciiValue)!)
            for adjacentNode in adjacencyList[node] {
                indegree[adjacentNode] -= 1
                if indegree[adjacentNode] == 0 {
                    queue.append(adjacentNode)
                }
            }
        }
        // Find if there is a cycle
        if indegree.contains(where: { $0 > 0 }) {
            return ""
        }
        return String(bytes: topo, encoding: .ascii)!
    }

    /*
     Shortest path in undirected graph with unit weights
     
     */
    func shortestPathLengthUndirectedGRaph(_ graph: [[Int]]) -> [Int] {
        let count = graph.count
        var distance = [Int](repeating: Int(1e9), count: count)
        var queue = [Int]()
        queue.append(0)
        distance[0] = 0
        var minDistance = Int.max
        while !queue.isEmpty {
            let node = queue.removeFirst()
            for adjacentNode in graph[node] {
                if distance[node] + 1 < distance[adjacentNode] {
                    distance[adjacentNode] = distance[node] + 1
                    queue.append(adjacentNode)
                    minDistance = min(minDistance, distance[adjacentNode])
                }
            }
        }
        for i in stride(from: 0, through: count - 1, by: 1) where distance[i] == Int(1e9) {
            distance[i] = -1
        }
        return distance
    }

    /*


     127. Word Ladder

     A transformation sequence from word beginWord to word endWord using a dictionary wordList is a sequence of words beginWord -> s1 -> s2 -> ... -> sk such that:

     Every adjacent pair of words differs by a single letter.
     Every si for 1 <= i <= k is in wordList. Note that beginWord does not need to be in wordList.
     sk == endWord
     Given two words, beginWord and endWord, and a dictionary wordList, return the number of words in the shortest transformation sequence from beginWord to endWord, or 0 if no such sequence exists.



     Example 1:

     Input: beginWord = "hit", endWord = "cog", wordList = ["hot","dot","dog","lot","log","cog"]
     Output: 5
     Explanation: One shortest transformation sequence is "hit" -> "hot" -> "dot" -> "dog" -> cog", which is 5 words long.
     Example 2:

     Input: beginWord = "hit", endWord = "cog", wordList = ["hot","dot","dog","lot","log"]
     Output: 0
     Explanation: The endWord "cog" is not in wordList, therefore there is no valid transformation sequence.


     Constraints:

     1 <= beginWord.length <= 10
     endWord.length == beginWord.length
     1 <= wordList.length <= 5000
     wordList[i].length == beginWord.length
     beginWord, endWord, and wordList[i] consist of lowercase English letters.
     beginWord != endWord
     All the words in wordList are unique.
     */

    func ladderLength(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> Int {
        var wordSet = Set<String>(wordList)
        if wordSet.contains(beginWord) {
            wordSet.remove(beginWord)
        }
        var queue = [(String, Int)]()
        queue.append((beginWord, 1))
        let aAsciiValue = Int(Character("a").asciiValue!)
        while !queue.isEmpty {
            let element = queue.removeFirst()
            let word = Array(element.0)
            let steps = element.1
            if element.0 == endWord {
                return steps
            }

            for i in stride(from: 0, through: word.count - 1, by: 1) {
                for j in stride(from: 0, through: 25, by: 1) {
                    let char = Character(UnicodeScalar(aAsciiValue + j)!)
                    var newWord = word
                    newWord[i] = char
                    let string = String(newWord)
                    if wordSet.contains(string) {
                        queue.append((string, steps + 1))
                        wordSet.remove(string)

                    }
                }
            }
        }
        return 0
    }

    /*
     126. Word Ladder II

     A transformation sequence from word beginWord to word endWord using a dictionary wordList is a sequence of words beginWord -> s1 -> s2 -> ... -> sk such that:

     Every adjacent pair of words differs by a single letter.
     Every si for 1 <= i <= k is in wordList. Note that beginWord does not need to be in wordList.
     sk == endWord
     Given two words, beginWord and endWord, and a dictionary wordList, return all the shortest transformation sequences from beginWord to endWord, or an empty list if no such sequence exists. Each sequence should be returned as a list of the words [beginWord, s1, s2, ..., sk].



     Example 1:

     Input: beginWord = "hit", endWord = "cog", wordList = ["hot","dot","dog","lot","log","cog"]
     Output: [["hit","hot","dot","dog","cog"],["hit","hot","lot","log","cog"]]
     Explanation: There are 2 shortest transformation sequences:
     "hit" -> "hot" -> "dot" -> "dog" -> "cog"
     "hit" -> "hot" -> "lot" -> "log" -> "cog"
     Example 2:

     Input: beginWord = "hit", endWord = "cog", wordList = ["hot","dot","dog","lot","log"]
     Output: []
     Explanation: The endWord "cog" is not in wordList, therefore there is no valid transformation sequence.


     Constraints:

     1 <= beginWord.length <= 5
     endWord.length == beginWord.length
     1 <= wordList.length <= 500
     wordList[i].length == beginWord.length
     beginWord, endWord, and wordList[i] consist of lowercase English letters.
     beginWord != endWord
     All the words in wordList are unique.
     The sum of all shortest transformation sequences does not exceed 105.
     */
    func findLaddersII(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> [[String]] {
        var setWordList = Set<String>(wordList)
        var usedOnLevel = [String]()
        var level = 0
        var queue = [[String]]()
        queue.append([beginWord])
        let aAscii = Int(Character("a").asciiValue!)
        var answer = [[String]]()
        while !queue.isEmpty {
            var frontList = queue.removeFirst()
            if frontList.count > level {
                level += 1
                for node in usedOnLevel {
                    setWordList.remove(node)
                }
            }
            var wordArray = Array(frontList.last!)
            if frontList.last == endWord {
                answer.append(frontList)
                
            }
            for i in stride(from: 0, through: wordArray.count - 1, by: 1) {
                let original = wordArray[i]
                for char in stride(from: 0, through: 25, by: 1) {
                    let character = Character(UnicodeScalar(aAscii + char)!)
                    wordArray[i] = character
                    let word = String(wordArray)
                    if setWordList.contains(word) {
                        frontList.append(word)
                        queue.append(frontList)
                        usedOnLevel.append(word)
                        frontList.removeLast()
                    }
                }
                wordArray[i] = original
            }
        }
        return answer
        
    }

    /*
     Dijkstra algo to find shortest distance of all vertices from a node
     */
    func dijkastra(graph: [[Pair]], source: Int) -> [Int] {
        let count = graph.count
        var distances = [Int](repeating: Int(1e9), count: count)
        var priorityQueue = MinHeap<PriorityQueueHeapItem<Int, Int>>(capacity: count)
        // Distance, Node
        priorityQueue.insert(key: PriorityQueueHeapItem(x: 0, y: source))
        distances[source] = 0
        while !priorityQueue.isEmpty {
            let topElement = priorityQueue.remove()!
            let node = topElement.x
            let distance = topElement.y
            for neighbor in graph[node] {
                let neigborDistance = neighbor.x
                let neighborNode = neighbor.y
                if distance + neigborDistance < distances[neighborNode] {
                    distances[neighborNode] = distance + neigborDistance
                    priorityQueue.insert(key: PriorityQueueHeapItem(x: distance + neigborDistance, y: neighborNode))
                }
            }
        }

        return distances
    }

    /*
     Shortest path
     */
    func shortestPath(graph: [[Pair]], source: Int) -> [Int] {
        let count = graph.count
        var distances  = [Int](repeating: Int(1e9), count: count)
        var parent = [Int](repeating: 0, count: count)
        for i in stride(from: 0, through: count - 1, by: 1) {
            parent[i] = i
        }
        var priorityQueue = MinHeap<PriorityQueueHeapItem<Int, Int>>(capacity: count)
        distances[source] = 0
        priorityQueue.insert(key: PriorityQueueHeapItem(x: 0, y: source))
        while !priorityQueue.isEmpty {
            let element = priorityQueue.remove()!
            let node = element.y
            let distance = element.x
            for neighbor in graph[node] {
                let adjacentNode = neighbor.x
                let weight = neighbor.y
                if distance + weight < distances[adjacentNode] {
                    distances[adjacentNode] = distance + weight
                    priorityQueue.insert(key: PriorityQueueHeapItem(x: distance + weight, y: adjacentNode))
                    parent[adjacentNode] = node
                }
            }
        }
        var node = count - 1
        var result = [Int]()
        if distances[count - 1] == Int(1e9) {
            return [-1]
        }
        while parent[node] != node {
            result.append(node)
            node = parent[node]
        }
        result.append(0)
        return result.reversed()

    }

    /*
     1091. Shortest Path in Binary Matrix

     Given an n x n binary matrix grid, return the length of the shortest clear path in the matrix. If there is no clear path, return -1.

     A clear path in a binary matrix is a path from the top-left cell (i.e., (0, 0)) to the bottom-right cell (i.e., (n - 1, n - 1)) such that:

     All the visited cells of the path are 0.
     All the adjacent cells of the path are 8-directionally connected (i.e., they are different and they share an edge or a corner).
     The length of a clear path is the number of visited cells of this path.

     Example 1:


     Input: grid = [[0,1],[1,0]]
     Output: 2
     Example 2:


     Input: grid = [[0,0,0],[1,1,0],[1,1,0]]
     Output: 4
     Example 3:

     Input: grid = [[1,0,0],[1,1,0],[1,1,0]]
     Output: -1


     Constraints:

     n == grid.length
     n == grid[i].length
     1 <= n <= 100
     grid[i][j] is 0 or 1
     */
    func shortestPathBinaryMatrix(grid: [[Int]], source: [Int], destination: [Int]) -> Int {
        let rowCount = grid.count
        let columnCount = grid[0].count
        if grid[0][0] != 0 || grid[rowCount - 1][columnCount - 1] != 0 {
            return -1
        }
        if grid.count == 1 {
            return 1
        }
        if source == destination {
            return -1
        }
        var distance = [[Int]](repeating: [Int](repeating: Int(1e9), count: columnCount), count: rowCount)
        distance[source[0]][source[1]] = 1
        var queue = [RCInfo]()
        queue.append(RCInfo(row: source[0], column: source[1], info: 1))
        let delRow = [-1, 0, 1, 0, -1, -1, 1, 1]
        let delColumn = [0, -1, 0, 1, -1, 1, -1, 1]
        while !queue.isEmpty {
            let element = queue.removeFirst()
            for i in stride(from: 0, through: 7, by: 1) {
                let newRow = element.row + delRow[i]
                let newColumn = element.column + delColumn[i]
                if newRow >= 0 && newRow < rowCount && newColumn >= 0 && newColumn < columnCount && grid[newRow][newColumn] == 0 && element.info + 1 < distance[newRow][newColumn] {
                    distance[newRow][newColumn] = element.info + 1
                    if destination[0] == newRow && destination[1] == newColumn {
                        return element.info + 1
                    }
                    queue.append(RCInfo(row: newRow, column: newColumn, info: element.info + 1))
                }
                
            }
        }
        return -1
    }

    /*
     1631. Path With Minimum Effort

     You are a hiker preparing for an upcoming hike. You are given heights, a 2D array of size rows x columns, where heights[row][col] represents the height of cell (row, col). You are situated in the top-left cell, (0, 0), and you hope to travel to the bottom-right cell, (rows-1, columns-1) (i.e., 0-indexed). You can move up, down, left, or right, and you wish to find a route that requires the minimum effort.

     A route's effort is the maximum absolute difference in heights between two consecutive cells of the route.

     Return the minimum effort required to travel from the top-left cell to the bottom-right cell.



     Example 1:



     Input: heights = [[1,2,2],[3,8,2],[5,3,5]]
     Output: 2
     Explanation: The route of [1,3,5,3,5] has a maximum absolute difference of 2 in consecutive cells.
     This is better than the route of [1,2,2,2,5], where the maximum absolute difference is 3.
     Example 2:



     Input: heights = [[1,2,3],[3,8,4],[5,3,5]]
     Output: 1
     Explanation: The route of [1,2,3,4,5] has a maximum absolute difference of 1 in consecutive cells, which is better than route [1,3,5,3,5].
     Example 3:


     Input: heights = [[1,2,1,1,1],[1,2,1,2,1],[1,2,1,2,1],[1,2,1,2,1],[1,1,1,2,1]]
     Output: 0
     Explanation: This route does not require any effort.


     Constraints:

     rows == heights.length
     columns == heights[i].length
     1 <= rows, columns <= 100
     1 <= heights[i][j] <= 106
     */

    func minimumEffortPath(_ heights: [[Int]]) -> Int {
        let rowCount = heights.count
        let columnCount = heights[0].count
        var distances = [[Int]](repeating: [Int](repeating: Int(1e9), count: columnCount), count: rowCount)
        distances[0][0] = 0
        // Distance, row, columm
        var queue = MinHeap<HeapItem3<Int>>(capacity: rowCount * columnCount)
        queue.insert(key: HeapItem3(x: 0, y: 0, z: 0))
        let delRow = [-1, 0, 1, 0]
        let delColumn = [0, -1, 0, 1]
        while !queue.isEmpty {
            let element = queue.remove()!
            let distance = element.x
            let row = element.y
            let column = element.z
            // In a priority we are always taking lower distance. So while popping out if the row and
            // and column matches destination, it means it is already the lowest effort
            if row == rowCount - 1 && column == columnCount - 1 {
                return distance
            }
            for i in stride(from: 0, through: 3, by: 1) {
                let newRow = row + delRow[i]
                let newColumn = column + delColumn[i]
                if newRow >= 0 && newRow < rowCount && newColumn >= 0 && newColumn < columnCount {
                    var effort = abs(heights[row][column] - heights[newRow][newColumn])
                    effort = max(effort, distance)
                    if effort < distances[newRow][newColumn] {
                        queue.insert(key: HeapItem3(x: effort, y: newRow, z: newColumn))
                        distances[newRow][newColumn] = effort
                    }
                }
            }
        }
        return 0

    }
    /*
     1976. Number of Ways to Arrive at Destination
     You are in a city that consists of n intersections numbered from 0 to n - 1 with bi-directional roads between some intersections. The inputs are generated such that you can reach any intersection from any other intersection and that there is at most one road between any two intersections.

     You are given an integer n and a 2D integer array roads where roads[i] = [ui, vi, timei] means that there is a road between intersections ui and vi that takes timei minutes to travel. You want to know in how many ways you can travel from intersection 0 to intersection n - 1 in the shortest amount of time.

     Return the number of ways you can arrive at your destination in the shortest amount of time. Since the answer may be large, return it modulo 109 + 7.



     Example 1:


     Input: n = 7, roads = [[0,6,7],[0,1,2],[1,2,3],[1,3,3],[6,3,3],[3,5,1],[6,5,1],[2,5,1],[0,4,5],[4,6,2]]
     Output: 4
     Explanation: The shortest amount of time it takes to go from intersection 0 to intersection 6 is 7 minutes.
     The four ways to get there in 7 minutes are:
     - 0 ➝ 6
     - 0 ➝ 4 ➝ 6
     - 0 ➝ 1 ➝ 2 ➝ 5 ➝ 6
     - 0 ➝ 1 ➝ 3 ➝ 5 ➝ 6
     Example 2:

     Input: n = 2, roads = [[1,0,10]]
     Output: 1
     Explanation: There is only one way to go from intersection 0 to intersection 1, and it takes 10 minutes.


     Constraints:

     1 <= n <= 200
     n - 1 <= roads.length <= n * (n - 1) / 2
     roads[i].length == 3
     0 <= ui, vi <= n - 1
     1 <= timei <= 109
     ui != vi
     There is at most one road connecting any two intersections.
     You can reach any intersection from any other intersection.
     */
    /*
     787. Cheapest Flights Within K Stops

     There are n cities connected by some number of flights. You are given an array flights where flights[i] = [fromi, toi, pricei] indicates that there is a flight from city fromi to city toi with cost pricei.

     You are also given three integers src, dst, and k, return the cheapest price from src to dst with at most k stops. If there is no such route, return -1.

     Example 1:


     Input: n = 4, flights = [[0,1,100],[1,2,100],[2,0,100],[1,3,600],[2,3,200]], src = 0, dst = 3, k = 1
     Output: 700
     Explanation:
     The graph is shown above.
     The optimal path with at most 1 stop from city 0 to 3 is marked in red and has cost 100 + 600 = 700.
     Note that the path through cities [0,1,2,3] is cheaper but is invalid because it uses 2 stops.
     Example 2:


     Input: n = 3, flights = [[0,1,100],[1,2,100],[0,2,500]], src = 0, dst = 2, k = 1
     Output: 200
     Explanation:
     The graph is shown above.
     The optimal path with at most 1 stop from city 0 to 2 is marked in red and has cost 100 + 100 = 200.
     Example 3:


     Input: n = 3, flights = [[0,1,100],[1,2,100],[0,2,500]], src = 0, dst = 2, k = 0
     Output: 500
     Explanation:
     The graph is shown above.
     The optimal path with no stops from city 0 to 2 is marked in red and has cost 500.


     Constraints:

     2 <= n <= 100
     0 <= flights.length <= (n * (n - 1) / 2)
     flights[i].length == 3
     0 <= fromi, toi < n
     fromi != toi
     1 <= pricei <= 104
     There will not be any multiple flights between two cities.
     0 <= src, dst, k < n
     src != dst
     */
    func findCheapestPrice(_ n: Int, _ flights: [[Int]], _ src: Int, _ dst: Int, _ k: Int) -> Int {
        let count = flights.count
        var adjacencyList = [[Pair]](repeating: [Pair](), count: n)
        for i in stride(from: 0, through: count - 1, by: 1) {
            adjacencyList[flights[i][0]].append(Pair(x: flights[i][1], y: flights[i][2]))
        }
        var distances = [Int](repeating: Int(1e9), count: n)
        distances[src] = 0
        var queue = [(Int, Int, Int)]()
        
        // Number of stops, destination, cost
        queue.append((0, src, 0))
        while !queue.isEmpty {
            let element = queue.removeFirst()
            let stops = element.0
            let destination = element.1
            let cost = element.2
            if stops > k {
                continue
            }
            for node in adjacencyList[destination] {
                if node.y + cost < distances[node.x] {
                    distances[node.x] = node.y + cost
                    queue.append((stops + 1, node.x, node.y + cost))
                }
            }
        }
        return distances[dst] == Int(1e9) ? -1 : distances[dst]
    }

    /*
     Given start, end and an array arr of n numbers. At each step, start is multiplied with any number in the array and then mod operation with 100000 is done to get the new start.

     Your task is to find the minimum steps in which end can be achieved starting from start. If it is not possible to reach end, then return -1.
     */
    /*


     827. Making A Large Island
    
     You are given an n x n binary matrix grid. You are allowed to change at most one 0 to be 1.

     Return the size of the largest island in grid after applying this operation.

     An island is a 4-directionally connected group of 1s.



     Example 1:

     Input: grid = [[1,0],[0,1]]
     Output: 3
     Explanation: Change one 0 to 1 and connect two 1s, then we get an island with area = 3.
     Example 2:

     Input: grid = [[1,1],[1,0]]
     Output: 4
     Explanation: Change the 0 to 1 and make the island bigger, only one island with area = 4.
     Example 3:

     Input: grid = [[1,1],[1,1]]
     Output: 4
     Explanation: Can't change any 0 to 1, only one island with area = 4.


     Constraints:

     n == grid.length
     n == grid[i].length
     1 <= n <= 500
     grid[i][j] is either 0 or 1.
     */
}
