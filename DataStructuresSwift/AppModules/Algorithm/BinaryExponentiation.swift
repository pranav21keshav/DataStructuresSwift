//
//  BinaryExponentiation.swift
//  DataStructuresSwift
//
//  Created by Pranav pravakar on 16/05/25.
//  Copyright © 2025 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation
struct BinaryExponentiation {
    func calculatePower(number: Int, to power: Int) -> Double {
        var number = Double(number)
        var power = power
        var  result: Double = 1
        while power > 0 {
            if (power & 1) == 1 {
                result *= number
            }
            number *= result
            power >>= 1
        }
        return result
    }
}
