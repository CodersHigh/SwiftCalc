//
//  CalcPadViewController.swift
//  SwiftCalc
//
//  Created by LingoStar on 2021/03/23.
//

import UIKit

class CalcPadViewController: UIViewController {

    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var operationLabel: UILabel!
    @IBOutlet weak var currentNumberLabel: UILabel!
    
    var currentNumber : Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func numberPadTapped(_ sender: UIButton) {
        let buttonNumber = sender.tag - 50
        currentNumber = currentNumber * 10 + Double(buttonNumber)
        
        currentNumberLabel.text = String(currentNumber)
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func plusMinusTapped(_ sender: UIButton) {
    }
    
    @IBAction func percentButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func operatorButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func showResult(_ sender: UIButton) {
    }
    
    @IBAction func pointButtonTapped(_ sender: UIButton) {
    }
    
}

