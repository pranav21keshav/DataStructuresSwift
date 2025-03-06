//
//  Bitwise.swift
//  DataStructuresSwift
//
//  Created by Pranav Pravakar on 22/06/24.
//  Copyright © 2024 PRANAV PRAVAKAR. All rights reserved.
//

import Foundation
struct Bitwise {

    init() {
        // Find odd
        print("<-------- Bitwise Operations ------->")
        for i in 0...21 {
            print("Is \(i) odd - \(isNumberOdd(number: i))")
        }

        // Binary Representation
        for i in 0...21 {
            print("Binary Representation \(String(format: "%10i", i)) - \(binaryRepresentation(number: i))")
        }

        print("Binary Representation \(2_147_483_647) - \(binaryRepresentation(number: 2_147_483_647))")
        print("Binary Representation \(2_147_483_648) - \(binaryRepresentation(number: 2_147_483_648))")

        // Divide by 2
        numbers()

        // Count set bits
        for i in 0...21 {
            print("Set Bits Count \(String(format: "%02i", i)) - \(countSetBits(number: i))")
        }

        // Number occuring odd times
        print("Number occuring odd times - \(numberOccuringOddTimes(numbers: [2, 3, 3, 4, 4, 2, 3]))")
        print("Number occuring odd times - \(numberOccuringOddTimes(numbers: [2, 8, 6, 4, 6, 2, 4, 8, 8]))")

        // Power of 2
        print("Is 0 is power of 2 - \(isPowerOf2(number: 0))")
        print("Is 512 is power of 2 - \(isPowerOf2(number: 512))")
        print("Is 2147483648 is power of 2 - \(isPowerOf2(number: 2_147_483_648))")
        print("Is 6 is power of 2 - \(isPowerOf2(number: 6))")

        // xor without using ^ operator
        print("XOR of 3 and 5 - Without operator - \(xor(number1: 3, number2: 5)), with operator - \(3 ^ 5)")
        print("XOR of 3 and 5 - Without operator - \(xor(number1: 8, number2: 9)), with operator - \(8 ^ 9)")

        // Check if nth bit is set
        isNthBitSet(bitNumber: 6, number: 32)
        isNthBitSet(bitNumber: 4, number: 15)
        isNthBitSet(bitNumber: 3, number: 15)
        isNthBitSet(bitNumber: 2, number: 15)
        isNthBitSet(bitNumber: 1, number: 15)
        isNthBitSet(bitNumber: 32, number: 2_147_483_648)
        isNthBitSet(bitNumber: 32, number: 2_147_483_647)

        // Postion of rightmoset set bit or lsb
        positionOfRightmostSetBit(number: 2_147_483_648)
        positionOfRightmostSetBit(number: 15)
        positionOfRightmostSetBit(number: 32)
        positionOfRightmostSetBit(number: 4)

        // Postion of left set bit
        positionOfLeftmostSetBit(number: 2_147_483_648)
        positionOfLeftmostSetBit(number: 15)
        positionOfLeftmostSetBit(number: 32)
        positionOfLeftmostSetBit(number: 19)

        // Set Nth bit
        setNthBitOn(bitNumber: 5, number: 15)
        setNthBitOn(bitNumber: 1, number: 4)
        setNthBitOff(bitNumber: 5, number: 31)

        // Toggle Nth bit
        toggleNthBit(bitNumber: 5, number: 15)
        toggleNthBit(bitNumber: 5, number: 31)

        var x = 9, y = 27, z = 36
        swapWithXOR(x: &x, y: &y)
        swapThreeWithXOR(x: &x, y: &y, z: &z)
    }

    /*
     Binary Representation          0 - 00000000000000000000000000000000
     Binary Representation          1 - 00000000000000000000000000000001
     Binary Representation          2 - 00000000000000000000000000000010
     Binary Representation          3 - 00000000000000000000000000000011
     Binary Representation          4 - 00000000000000000000000000000100
     Binary Representation          5 - 00000000000000000000000000000101
     Binary Representation          6 - 00000000000000000000000000000110
     Binary Representation          7 - 00000000000000000000000000000111
     Binary Representation          8 - 00000000000000000000000000001000
     Binary Representation          9 - 00000000000000000000000000001001
     Binary Representation         10 - 00000000000000000000000000001010
     Binary Representation         11 - 00000000000000000000000000001011
     Binary Representation         12 - 00000000000000000000000000001100
     Binary Representation         13 - 00000000000000000000000000001101
     Binary Representation         14 - 00000000000000000000000000001110
     Binary Representation         15 - 00000000000000000000000000001111
     Binary Representation         16 - 00000000000000000000000000010000
     Binary Representation         17 - 00000000000000000000000000010001
     Binary Representation         18 - 00000000000000000000000000010010
     Binary Representation         19 - 00000000000000000000000000010011
     Binary Representation         20 - 00000000000000000000000000010100
     Binary Representation         21 - 00000000000000000000000000010101
     Binary Representation 2147483647 - 01111111111111111111111111111111
     Binary Representation 2147483648 - 10000000000000000000000000000000
     */
    func binaryRepresentation(number: Int) -> String {
        var i = 1 << 31
        var string = ""
        while i > 0 {
            if number & i != 0 {
                string.append("1")
            } else {
                string.append("0")
            }
            i = i >> 1
        }
        return string
    }

    /*
     i - 2147483648
     i - 1073741824
     i - 536870912
     i - 268435456
     i - 134217728
     i - 67108864
     i - 33554432
     i - 16777216
     i - 8388608
     i - 4194304
     i - 2097152
     i - 1048576
     i - 524288
     i - 262144
     i - 131072
     i - 65536
     i - 32768
     i - 16384
     i - 8192
     i - 4096
     i - 2048
     i - 1024
     i - 512
     i - 256
     i - 128
     i - 64
     i - 32
     i - 16
     i - 8
     i - 4
     i - 2
     i - 1
     */
    func numbers() {
        var i = 1 << 31
        while i > 0 {
            print(" i - \(i)")
            i = i >> 1
        }
    }

    func isNumberOdd(number: Int) -> Bool {
        number & 1 == 1
    }

    func isNthBitSet(bitNumber: Int, number: Int) {
        let isSet = number & (1 << bitNumber) != 0
        print("\(bitNumber) bit is set in \(number) - \(isSet)")
    }

    func setNthBitOn(bitNumber: Int, number: Int) {
        print("Before Setting \(bitNumber) bit in number \(number) is - \(number)")
        let numberAfterSettingNthBit = number | (1 << bitNumber)
        print("After Setting \(bitNumber) bit in number \(number) is - \(numberAfterSettingNthBit)")
    }

    func setNthBitOff(bitNumber: Int, number: Int) {
        print("Before Setting \(bitNumber) bit off in number \(number) is - \(number)")
        let numberAfterSettingNthBit = number & ~(1 << bitNumber)
        print("After Setting \(bitNumber) bit off in number \(number) is - \(numberAfterSettingNthBit)")
    }

    func toggleNthBit(bitNumber: Int, number: Int) {
        print("Before Toggling \(bitNumber) bit  in number \(number) is - \(number)")
        let numberAfterSettingNthBit = number ^ (1 << bitNumber)
        print("After Toggling \(bitNumber) bit  in number \(number) is - \(numberAfterSettingNthBit)")
    }

    // If number is power of 2, then number before power of 2 will be all one's
    func isPowerOf2(number: Int) -> Bool {
        number == 0 ? true : number & (number - 1) == 0
    }

    // O(log N)
    func countSetBits(number: Int) -> Int {
        var count = 0
        var number = number
        while number > 0 {
            count += number & 1
            number >>= 1
        }
        return count
    }

    // O(n)
    func numberOccuringOddTimes(numbers: [Int]) -> Int {
        var number = 0
        for i in 0..<numbers.count {
            number ^= numbers[i]
        }
        return number
    }

    func xor(number1: Int, number2: Int) -> Int {
        (number1 & ~number2) | (~number1 & number2)
    }

    func swapWithXOR(x: inout Int, y: inout Int) {
        print("x - \(x), y - \(y)")
        x = x ^ y
        y = y ^ x
        x = x ^ y
        print("x - \(x), y - \(y)")
    }

    func positionOfRightmostSetBit(number: Int) {
        guard number != 0 else { return }
        if (number & 1) != 0 {
            print("Rightmost set bit for number \(number) is 1")
            return
        }

        var counter = 0
        var setBit = number & ~(number - 1)
        while setBit > 0 {
            setBit >>= 1
            counter += 1
        }
        print("Rightmost set bit for number \(number) is \(counter)")
    }

    func positionOfLeftmostSetBit(number: Int) {
        var temp = number
        guard number != 0 else { return }

        var counter = 0
        while temp != 0 {
            counter += 1
            temp >>= 1
        }
        print("Leftmost set bit for number \(number) is \(counter)")
    }

    // After swap a will be b, b will be c and c will be a
    func swapThreeWithXOR(x: inout Int, y: inout Int, z: inout Int) {
        print("x - \(x), y - \(y), z - \(z)")

        x = x ^ y ^ z
        y = x ^ y ^ z
        z = x ^ y ^ z
        x = x ^ y ^ z

        print("x - \(x), y - \(y), z - \(z)")
    }
}
