//
//  Math.swift
//  DataStructuresSwift
//
//  Created by Pranav pravakar on 15/08/25.
//  Copyright © 2025 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation

struct Math {
    /*
     50. Pow(x, n)
     Solved
     Medium
     Topics
     conpanies icon
     Companies
     Implement pow(x, n), which calculates x raised to the power n (i.e., xn).



     Example 1:

     Input: x = 2.00000, n = 10
     Output: 1024.00000
     Example 2:

     Input: x = 2.10000, n = 3
     Output: 9.26100
     Example 3:

     Input: x = 2.00000, n = -2
     Output: 0.25000
     Explanation: 2-2 = 1/22 = 1/4 = 0.25


     Constraints:

     -100.0 < x < 100.0
     -231 <= n <= 231-1
     n is an integer.
     Either x is not zero or n > 0.
     -104 <= xn <= 104
     */
    func myPow(_ x: Double, _ n: Int) -> Double {
        if n == 0 {
            return 1
        }
        if x == 1.0 {
            return 1
        }
        if x == -1.0 {
            return n % 2 == 0 ? 1 : -1
        }
        var power = abs(n)
        var result = 1.0
        var x = x
        while power > 0 {
            if power % 2 == 0 {
                x *= x
                power /= 2
            } else {
                result *= x
                power -= 1
            }
        }
        return n < 0 ? 1.0 / result : result

    }
}
