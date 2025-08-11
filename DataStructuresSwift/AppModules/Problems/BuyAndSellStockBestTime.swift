//
//  BuyAndSellStockBestTime.swift
//  DataStructuresSwift
//
//  Created by Pranav Pravakar on 04/03/24.
//  Copyright © 2024 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation
/*
 Best Time to Buy and Sell Stock

 You are given an array prices where prices[i] is the price of a given stock on the ith day.

 You want to maximize your profit by choosing a single day to buy one stock and choosing a different day in the future to sell that stock.

 Return the maximum profit you can achieve from this transaction. If you cannot achieve any profit, return 0.


 Example 1:

 Input: prices = [7,1,5,3,6,4]
 Output: 5
 Explanation: Buy on day 2 (price = 1) and sell on day 5 (price = 6), profit = 6-1 = 5.
 Note that buying on day 2 and selling on day 1 is not allowed because you must buy before you sell.
 Example 2:

 Input: prices = [7,6,4,3,1]
 Output: 0
 Explanation: In this case, no transactions are done and the max profit = 0.


 Constraints:

 1 <= prices.length <= 105
 0 <= prices[i] <= 104

 */
import Foundation

struct BuyAndSellStockBestTime {

    init() {
        print("\n------> buyAndSellStockBestTime")
        let prices = [7, 1, 5, 3, 6, 4]
        print("Buy and Sell Stock -\(buyAndSellStockBestTimeIIMemo(prices))")
    }

    /*
     You are given an array prices where prices[i] is the price of a given stock on the ith day.

     You want to maximize your profit by choosing a single day to buy one stock and choosing a different day in the future to sell that stock.

     Return the maximum profit you can achieve from this transaction. If you cannot achieve any profit, return 0.



     Example 1:

     Input: prices = [7,1,5,3,6,4]
     Output: 5
     Explanation: Buy on day 2 (price = 1) and sell on day 5 (price = 6), profit = 6-1 = 5.
     Note that buying on day 2 and selling on day 1 is not allowed because you must buy before you sell.
     Example 2:

     Input: prices = [7,6,4,3,1]
     Output: 0
     Explanation: In this case, no transactions are done and the max profit = 0.


     Constraints:

     1 <= prices.length <= 105
     0 <= prices[i] <= 104
     */
    public func buyAndSellStockBestTime(prices: [Int]) {
        var minimum = prices[0]
        var result = 0

        for index in 1..<prices.count {
            minimum = min(prices[index], minimum)
            let value = prices[index] - minimum
            result = value > result ? value : result
        }
        print("--------> Maximum profit in \(prices) is \(result)")
    }
    
    /*
     You are given an integer array prices where prices[i] is the price of a given stock on the ith day.

     On each day, you may decide to buy and/or sell the stock. You can only hold at most one share of the stock at any time. However, you can buy it then immediately sell it on the same day.

     Find and return the maximum profit you can achieve.

      

     Example 1:

     Input: prices = [7,1,5,3,6,4]
     Output: 7
     Explanation: Buy on day 2 (price = 1) and sell on day 3 (price = 5), profit = 5-1 = 4.
     Then buy on day 4 (price = 3) and sell on day 5 (price = 6), profit = 6-3 = 3.
     Total profit is 4 + 3 = 7.
     Example 2:

     Input: prices = [1,2,3,4,5]
     Output: 4
     Explanation: Buy on day 1 (price = 1) and sell on day 5 (price = 5), profit = 5-1 = 4.
     Total profit is 4.
     Example 3:

     Input: prices = [7,6,4,3,1]
     Output: 0
     Explanation: There is no way to make a positive profit, so we never buy the stock to achieve the maximum profit of 0.

     */
    
    func buyAndSellStockBestTimeII(prices: [Int]) -> Int {
        var res = 0
        for i in 0..<prices.count - 1 {
            if prices[i + 1] > prices[i] {
                res += prices[i + 1] - prices[i]
            }
        }
        return res
    }

    func buyAndSellStockBestTimeIIRec(prices: [Int]) -> Int {
        buyAndSellStockBestTimeIIRecursion(prices: prices, index: 0, buy: 1)
    }

    func buyAndSellStockBestTimeIIRecursion(prices: [Int], index: Int, buy: Int) -> Int {
        if index >= prices.count {
            return 0
        }
        let profit: Int
        if buy == 1 {
            let buy = -prices[index] + buyAndSellStockBestTimeIIRecursion(prices: prices, index: index + 1, buy: 0)
            let notBuy = buyAndSellStockBestTimeIIRecursion(prices: prices, index: index + 1, buy: 1)
            profit = max(buy, notBuy)
        } else {
            let sell = prices[index] + buyAndSellStockBestTimeIIRecursion(prices: prices, index: index + 1, buy: 1)
            let notSell = buyAndSellStockBestTimeIIRecursion(prices: prices, index: index + 1, buy: 0)
            profit = max(sell, notSell)
        }
        return profit
    }

    func buyAndSellStockBestTimeIIMemo(_ prices: [Int]) -> Int {
        var dp = [[Int]](repeating: [Int](repeating: -1, count: 2), count: prices.count)
        return buyAndSellStockBestTimeIIMemoization(prices: prices, index: 0, dp: &dp, buy: 1)
    }

    func buyAndSellStockBestTimeIIMemoization(prices: [Int], index: Int, dp: inout [[Int]], buy: Int) -> Int {
        if index >= prices.count {
            return 0
        }
        if dp[index][buy] != -1 {
            return dp[index][buy]
        }
        if buy == 1 {
            let buy = -prices[index] + buyAndSellStockBestTimeIIMemoization(prices: prices, index: index + 1, dp: &dp, buy: 0)
            let notBuy = buyAndSellStockBestTimeIIMemoization(prices: prices, index: index + 1, dp: &dp, buy: 1)
            dp[index][1] = max(buy, notBuy)
        } else {
            let sell = prices[index] + buyAndSellStockBestTimeIIMemoization(prices: prices, index: index + 1, dp: &dp, buy: 1)
            let notSell = buyAndSellStockBestTimeIIMemoization(prices: prices, index: index + 1, dp: &dp, buy: 0)
            dp[index][0]  = max(sell, notSell)
        }
        return  dp[index][buy]
    }

    func buyAndSellStockBestTimeIITabulation(_ prices: [Int]) -> Int {
        var dp = [[Int]](repeating: [Int](repeating: 0, count: 2), count: prices.count + 1)
        for index in stride(from: prices.count - 1, through: 0, by: -1) {
            for buy in stride(from: 0, through: 1, by: 1) {
                if buy == 1 {
                    let buy = -prices[index] + dp[index + 1][0]
                    let notBuy = dp[index + 1][1]
                    dp[index][1] = max(buy, notBuy)
                } else {
                    let sell = prices[index] + dp[index + 1][1]
                    let notSell = dp[index + 1][0]
                    dp[index][0]  = max(sell, notSell)
                }
            }
        }
        return dp[0][1]
    }

    func buyAndSellStockBestTimeIISpaceOpti1(_ prices: [Int]) -> Int {
        var after = [Int](repeating: 0, count: 5)
        var current = after
        for index in stride(from: prices.count - 1, through: 0, by: -1) {
            for transaction in stride(from: 3, through: 0, by: -1) {
                if transaction % 2 == 0 {
                    let currentBuy = -prices[index] + after[transaction + 1]
                    let currentNotBuy = after[transaction]
                    current[transaction] = max(currentBuy, currentNotBuy)
                } else {
                    let currentSell = prices[index] + after[transaction + 1]
                    let currentNotSell = after[transaction]
                    current[transaction] = max(currentSell, currentNotSell)
                }
            }
            after = current
        }
        return after[0]
    }

    func buyAndSellStockBestTimeIISpaceOpti2(_ prices: [Int]) -> Int {
        var aheadBuy = 0
        var aheadNotBuy = 0
        var currentBuy = 0
        var currentNotBuy = 0
        for index in stride(from: prices.count - 1, through: 0, by: -1) {
            let buy = -prices[index] + aheadNotBuy
            let notBuy = aheadBuy
            currentBuy = max(buy, notBuy)
            let sell = prices[index] + aheadBuy
            let notSell = aheadNotBuy
            currentNotBuy = max(sell, notSell)

            aheadNotBuy = currentNotBuy
            aheadBuy = currentBuy
        }
        return aheadBuy
    }

    /*
     You are given an array prices where prices[i] is the price of a given stock on the ith day.

     Find the maximum profit you can achieve. You may complete at most two transactions.

     Note: You may not engage in multiple transactions simultaneously (i.e., you must sell the stock before you buy again).



     Example 1:

     Input: prices = [3,3,5,0,0,3,1,4]
     Output: 6
     Explanation: Buy on day 4 (price = 0) and sell on day 6 (price = 3), profit = 3-0 = 3.
     Then buy on day 7 (price = 1) and sell on day 8 (price = 4), profit = 4-1 = 3.
     Example 2:

     Input: prices = [1,2,3,4,5]
     Output: 4
     Explanation: Buy on day 1 (price = 1) and sell on day 5 (price = 5), profit = 5-1 = 4.
     Note that you cannot buy on day 1, buy on day 2 and sell them later, as you are engaging multiple transactions at the same time. You must sell before buying again.
     Example 3:

     Input: prices = [7,6,4,3,1]
     Output: 0
     Explanation: In this case, no transaction is done, i.e. max profit = 0.


     Constraints:

     1 <= prices.length <= 105
     0 <= prices[i] <= 105

     */

    func maxProfitRec(_ prices: [Int]) -> Int {
        maxProfitRecursion(prices: prices, index: 0, shouldBuy: true, transaction: 1)
    }

    func maxProfitRecursion(prices: [Int], index: Int, shouldBuy: Bool, transaction: Int) -> Int {
        if index == prices.count || transaction == 0 {
            return 0
        }
        let profit: Int
        if shouldBuy {
            let currentBuy = -prices[index] + maxProfitRecursion(prices: prices, index: index + 1, shouldBuy: false, transaction: transaction)
            let currentNotBuy = maxProfitRecursion(prices: prices, index: index + 1, shouldBuy: true, transaction: transaction)
            profit = max(currentBuy, currentNotBuy)
        } else {
            let currentSell = prices[index] + maxProfitRecursion(prices: prices, index: index + 1, shouldBuy: true, transaction: transaction - 1)
            let currentNotSell = maxProfitRecursion(prices: prices, index: index + 1, shouldBuy: false, transaction: transaction)
            profit = max(currentSell, currentNotSell)
        }
        return profit
    }

    func maxProfitMemo(_ prices: [Int]) -> Int {
        let transactions = [Int](repeating: -1, count: 3)
        let buy = [[Int]](repeating: transactions, count: 2)
        var dp = [[[Int]]](repeating: buy, count: prices.count)
        return maxProfitMemoization(prices: prices, index: 0, dp: &dp, shouldBuy: true, transaction: 1)
    }

    func maxProfitMemoization(prices: [Int], index: Int, dp: inout [[[Int]]], shouldBuy: Bool, transaction: Int) -> Int {
        if index == prices.count || transaction > 2 {
            return 0
        }
        let buyindex = shouldBuy ? 1 : 0
        if dp[index][buyindex][transaction] != -1 {
            return dp[index][buyindex][transaction]
        }
        if shouldBuy {
            let currentBuy = -prices[index] + maxProfitMemoization(prices: prices, index: index + 1, dp: &dp, shouldBuy: false, transaction: transaction)
            let currentNotBuy = maxProfitMemoization(prices: prices, index: index + 1, dp: &dp, shouldBuy: true, transaction: transaction)
            dp[index][buyindex][transaction] = max(currentBuy, currentNotBuy)
        } else {
            let currentSell = prices[index] + maxProfitMemoization(prices: prices, index: index + 1, dp: &dp, shouldBuy: true, transaction: transaction + 1)
            let currentNotSell = maxProfitMemoization(prices: prices, index: index + 1, dp: &dp, shouldBuy: false, transaction: transaction)
            dp[index][buyindex][transaction] = max(currentSell, currentNotSell)
        }
        return dp[index][buyindex][transaction]
    }

    func maxProfitTab(_ prices: [Int]) -> Int {
        let transactions = [Int](repeating: 0, count: 3)
        let buy = [[Int]](repeating: transactions, count: 2)
        var dp = [[[Int]]](repeating: buy, count: prices.count + 1)
        for index in stride(from: prices.count - 1, through: 0, by: -1) {
            for buy in stride(from: 0, through: 1, by: 1) {
                for transaction in stride(from: 1, through: 2, by: 1) {
                    if buy == 1 {
                        let currentBuy = -prices[index] + dp[index + 1][0][transaction]
                        let currentNotBuy = dp[index + 1][1][transaction]
                        dp[index][buy][transaction] = max(currentBuy, currentNotBuy)
                    } else {
                        let currentSell = prices[index] + dp[index + 1][1][transaction - 1]
                        let currentNotSell = dp[index + 1][0][transaction]
                        dp[index][buy][transaction] = max(currentSell, currentNotSell)
                    }

                }
            }
        }
        return dp[0][1][2]
    }

    func maxProfitSpaceOpti1(_ prices: [Int]) -> Int {
        let transactions = [Int](repeating: 0, count: 3)
        var after = [[Int]](repeating: transactions, count: 2)
        var current = after
        for index in stride(from: prices.count - 1, through: 0, by: -1) {
            for buy in stride(from: 0, through: 1, by: 1) {
                for transaction in stride(from: 1, through: 2, by: 1) {
                    if buy == 1 {
                        let currentBuy = -prices[index] + after[0][transaction]
                        let currentNotBuy = after[1][transaction]
                        current[buy][transaction] = max(currentBuy, currentNotBuy)
                    } else {
                        let currentSell = prices[index] + after[1][transaction - 1]
                        let currentNotSell = after[0][transaction]
                        current[buy][transaction] = max(currentSell, currentNotSell)
                    }
                }
            }
            after = current
        }
        return current[1][2]
    }

    func maxProfitSpaceOpti2(_ prices: [Int]) -> Int {
        var after = [Int](repeating: 0, count: 5)
        var current = after
        for index in stride(from: prices.count - 1, through: 0, by: -1) {
            for transaction in stride(from: 3, through: 0, by: -1) {
                if transaction % 2 == 0 {
                    let currentBuy = -prices[index] + after[transaction + 1]
                    let currentNotBuy = after[transaction]
                    current[transaction] = max(currentBuy, currentNotBuy)
                } else {
                    let currentSell = prices[index] + after[transaction + 1]
                    let currentNotSell = after[transaction]
                    current[transaction] = max(currentSell, currentNotSell)
                }
            }
            after = current
        }
        return after[0]
    }

    /*
     You are given an integer array prices where prices[i] is the price of a given stock on the ith day, and an integer k.

     Find the maximum profit you can achieve. You may complete at most k transactions: i.e. you may buy at most k times and sell at most k times.

     Note: You may not engage in multiple transactions simultaneously (i.e., you must sell the stock before you buy again).



     Example 1:

     Input: k = 2, prices = [2,4,1]
     Output: 2
     Explanation: Buy on day 1 (price = 2) and sell on day 2 (price = 4), profit = 4-2 = 2.
     Example 2:

     Input: k = 2, prices = [3,2,6,5,0,3]
     Output: 7
     Explanation: Buy on day 2 (price = 2) and sell on day 3 (price = 6), profit = 6-2 = 4. Then buy on day 5 (price = 0) and sell on day 6 (price = 3), profit = 3-0 = 3.


     Constraints:

     1 <= k <= 100
     1 <= prices.length <= 1000
     0 <= prices[i] <= 1000
     */

    func maxProfitIV(_ k: Int, _ prices: [Int]) -> Int {
        maxProfitIVRecursion(prices: prices, index: 0, transaction: 2 * k)
    }

    func maxProfitIVRecursion(prices: [Int], index: Int, transaction: Int) -> Int {
        if index == prices.count || transaction == 0 {
            return 0
        }
        let profit: Int
        if transaction % 2 == 0 {
            let currentBuy = -prices[index] + maxProfitIVRecursion(prices: prices, index: index + 1, transaction: transaction - 1)
            let currentNotBuy = maxProfitIVRecursion(prices: prices, index: index + 1, transaction: transaction)
            profit = max(currentBuy, currentNotBuy)
            return profit
        }
        let currentSell = prices[index] + maxProfitIVRecursion(prices: prices, index: index + 1, transaction: transaction - 1)
        let currentNotSell = maxProfitIVRecursion(prices: prices, index: index + 1, transaction: transaction)
        profit = max(currentSell, currentNotSell)
        return profit
    }

    func maxProfitIVMemo(_ k: Int, _ prices: [Int]) -> Int {
        var dp = [[Int]](repeating: [Int](repeating: -1, count: 2 * k + 1), count: prices.count)
        return maxProfitIVMemoization(prices: prices, index: 0, dp: &dp, transaction: 2 * k)
    }

    func maxProfitIVMemoization(prices: [Int], index: Int, dp: inout [[Int]], transaction: Int) -> Int {
        if index == prices.count || transaction == 0 {
            return 0
        }
        if dp[index][transaction] != -1 {
            return dp[index][transaction]
        }

        if transaction % 2 == 0 {
            let currentBuy = -prices[index] + maxProfitIVMemoization(prices: prices, index: index + 1, dp: &dp, transaction: transaction - 1)
            let currentNotBuy = maxProfitIVMemoization(prices: prices, index: index + 1, dp: &dp, transaction: transaction)
            dp[index][transaction] = max(currentBuy, currentNotBuy)
            return dp[index][transaction]
        }
        let currentSell = prices[index] + maxProfitIVMemoization(prices: prices, index: index + 1, dp: &dp, transaction: transaction - 1)
        let currentNotSell = maxProfitIVMemoization(prices: prices, index: index + 1, dp: &dp, transaction: transaction)
        dp[index][transaction] = max(currentSell, currentNotSell)
        return dp[index][transaction]
    }

    func maxProfitIVTab(_ k: Int, _ prices: [Int]) -> Int {
        var dp = [[Int]](repeating: [Int](repeating: 0, count: 2 * k + 1), count: prices.count + 1)

        for index in stride(from: prices.count - 1, through: 0, by: -1) {
            for transaction in stride(from: 2 * k - 1, through: 0, by: -1) {
                if transaction % 2 == 0 {
                    let currentBuy = -prices[index] + dp[index + 1][transaction + 1]
                    let currentNotBuy = dp[index + 1][transaction]
                    dp[index][transaction] = max(currentBuy, currentNotBuy)
                } else {
                    let currentSell = prices[index] + dp[index + 1][transaction + 1]
                    let currentNotSell = dp[index + 1][transaction]
                    dp[index][transaction] = max(currentSell, currentNotSell)
                }
            }
        }
        return dp[0][0]
    }

    func maxProfitIVSpaceOpti1(_ k: Int, _ prices: [Int]) -> Int {
        var after = [Int](repeating: 0, count: 2 * k + 1)
        var current = after

        for index in stride(from: prices.count - 1, through: 0, by: -1) {
            for transaction in stride(from: 2 * k - 1, through: 0, by: -1) {
                if transaction % 2 == 0 {
                    let currentBuy = -prices[index] + after[transaction + 1]
                    let currentNotBuy = after[transaction]
                    current[transaction] = max(currentBuy, currentNotBuy)
                } else {
                    let currentSell = prices[index] + after[transaction + 1]
                    let currentNotSell = after[transaction]
                    current[transaction] = max(currentSell, currentNotSell)
                }
            }
            after = current
        }
        return after[0]
    }

    /*
     You are given an array prices where prices[i] is the price of a given stock on the ith day.

     Find the maximum profit you can achieve. You may complete as many transactions as you like (i.e., buy one and sell one share of the stock multiple times) with the following restrictions:

     After you sell your stock, you cannot buy stock on the next day (i.e., cooldown one day).
     Note: You may not engage in multiple transactions simultaneously (i.e., you must sell the stock before you buy again).



     Example 1:

     Input: prices = [1,2,3,0,2]
     Output: 3
     Explanation: transactions = [buy, sell, cooldown, buy, sell]
     Example 2:

     Input: prices = [1]
     Output: 0


     Constraints:

     1 <= prices.length <= 5000
     0 <= prices[i] <= 1000
     */

    func maxProfitCooldownRec(_ prices: [Int]) -> Int {
        maxProfitCooldownRecursion(prices: prices, index: 0, shouldBuy: true)
    }

    func maxProfitCooldownRecursion(prices: [Int], index: Int, shouldBuy: Bool) -> Int {
        if index >= prices.count {
            return 0
        }
        let profit: Int
        if shouldBuy {
            let currentBuy = -prices[index] + maxProfitCooldownRecursion(prices: prices, index: index + 1, shouldBuy: false)
            let currentNotBuy = maxProfitCooldownRecursion(prices: prices, index: index + 1, shouldBuy: true)
            profit = max(currentBuy, currentNotBuy)
        } else {
            let currentSell = prices[index] + maxProfitCooldownRecursion(prices: prices, index: index + 2, shouldBuy: true)
            let currentNotSell = maxProfitCooldownRecursion(prices: prices, index: index + 1, shouldBuy: false)
            profit = max(currentSell, currentNotSell)
        }
        return profit
    }

    func maxProfitCooldownMemo(_ prices: [Int]) -> Int {
        var dp = [[Int]](repeating: [Int](repeating: -1, count: 2), count: prices.count)
        return maxProfitCooldownMemoization(prices: prices, index: 0, dp: &dp, shouldBuy: 1)
    }

    func maxProfitCooldownMemoization(prices: [Int], index: Int, dp: inout [[Int]], shouldBuy: Int) -> Int {
        if index >= prices.count {
            return 0
        }
        if dp[index][shouldBuy] != -1 {
            return dp[index][shouldBuy]
        }

        if shouldBuy == 1 {
            let currentBuy = -prices[index] + maxProfitCooldownMemoization(prices: prices, index: index + 1, dp: &dp, shouldBuy: 0)
            let currentNotBuy = maxProfitCooldownMemoization(prices: prices, index: index + 1, dp: &dp, shouldBuy: 1)
            dp[index][shouldBuy] = max(currentBuy, currentNotBuy)
        } else {
            let currentSell = prices[index] + maxProfitCooldownMemoization(prices: prices, index: index + 2, dp: &dp, shouldBuy: 1)
            let currentNotSell = maxProfitCooldownMemoization(prices: prices, index: index + 1, dp: &dp, shouldBuy: 0)
            dp[index][shouldBuy] = max(currentSell, currentNotSell)
        }

        return dp[index][shouldBuy]
    }

    func maxProfitCooldownTabu(_ prices: [Int]) -> Int {
        var dp = [[Int]](repeating: [Int](repeating: 0, count: 2), count: prices.count + 2)
        for index in stride(from: prices.count - 1, through: 0, by: -1) {
            for buy in stride(from: 0, through: 1, by: 1) {
                if buy == 1 {
                    let currentBuy = -prices[index] + dp[index + 1][0]
                    let currentNotBuy = dp[index + 1][buy]
                    dp[index][buy] = max(currentBuy, currentNotBuy)
                } else {
                    let currentSell = prices[index] + dp[index + 2][1]
                    let currentNotSell = dp[index + 1][buy]
                    dp[index][buy] = max(currentSell, currentNotSell)
                }

            }
        }
        return dp[0][1]
    }

    func maxProfitCooldownOpti1(_ prices: [Int]) -> Int {
        var dp = [[Int]](repeating: [Int](repeating: 0, count: 2), count: prices.count + 2)
        for index in stride(from: prices.count - 1, through: 0, by: -1) {

            let currentBuy = -prices[index] + dp[index + 1][0]
            let currentNotBuy = dp[index + 1][1]
            dp[index][1] = max(currentBuy, currentNotBuy)

            let currentSell = prices[index] + dp[index + 2][1]
            let currentNotSell = dp[index + 1][0]
            dp[index][0] = max(currentSell, currentNotSell)

        }
        return dp[0][1]
    }

    func maxProfitCooldownSpaceOpti1(_ prices: [Int]) -> Int {
        var front2 = [Int](repeating: 0, count: 2)
        var front1 = [Int](repeating: 0, count: 2)
        var current = [Int](repeating: 0, count: 2)
        for index in stride(from: prices.count - 1, through: 0, by: -1) {

            let currentBuy = -prices[index] + front1[0]
            let currentNotBuy = front1[1]
            current[1] = max(currentBuy, currentNotBuy)

            let currentSell = prices[index] + front2[1]
            let currentNotSell = front1[0]
            current[0] = max(currentSell, currentNotSell)
            front2 = front1
            front1 = current

        }
        return current[1]
    }

    /*
     You are given an array prices where prices[i] is the price of a given stock on the ith day, and an integer fee representing a transaction fee.

     Find the maximum profit you can achieve. You may complete as many transactions as you like, but you need to pay the transaction fee for each transaction.

     Note:

     You may not engage in multiple transactions simultaneously (i.e., you must sell the stock before you buy again).
     The transaction fee is only charged once for each stock purchase and sale.


     Example 1:

     Input: prices = [1,3,2,8,4,9], fee = 2
     Output: 8
     Explanation: The maximum profit can be achieved by:
     - Buying at prices[0] = 1
     - Selling at prices[3] = 8
     - Buying at prices[4] = 4
     - Selling at prices[5] = 9
     The total profit is ((8 - 1) - 2) + ((9 - 4) - 2) = 8.
     Example 2:

     Input: prices = [1,3,7,5,10,3], fee = 3
     Output: 6


     Constraints:

     1 <= prices.length <= 5 * 104
     1 <= prices[i] < 5 * 104
     0 <= fee < 5 * 104
     */

    func maxProfitTransactionFee(_ prices: [Int], _ fee: Int) -> Int {
        var aheadBuy = 0
        var aheadNotBuy = 0
        var currentBuy = 0
        var currentNotBuy = 0
        for index in stride(from: prices.count - 1, through: 0, by: -1) {
            let buy = -prices[index] - fee + aheadNotBuy
            let notBuy = aheadBuy
            currentBuy = max(buy, notBuy)
            let sell = prices[index] + aheadBuy
            let notSell = aheadNotBuy
            currentNotBuy = max(sell, notSell)

            aheadNotBuy = currentNotBuy
            aheadBuy = currentBuy
        }
        return aheadBuy
    }
}
