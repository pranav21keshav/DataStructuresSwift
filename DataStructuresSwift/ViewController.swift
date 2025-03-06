//
//  ViewController.swift
//  DataStructuresSwift
//
//  Created by PRANAV PRAVAKAR on 31/03/20.
//  Copyright © 2020 PRANAV PRAVAKAR. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let buy2Chocolates = BuyTwoChocolates()
        print("Left Money - ", buy2Chocolates.buyChococolates(prices: [1, 2, 2], money: 3))
        print("Left Money - ", buy2Chocolates.buyChococolates(prices: [3, 2, 3], money: 3))
        let arrayProblems = ArrayProblems()
    }
}
