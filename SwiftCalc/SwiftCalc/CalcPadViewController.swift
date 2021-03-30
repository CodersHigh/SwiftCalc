//
//  CalcPadViewController.swift
//  SwiftCalc
//
//  Created by LingoStar on 2021/03/23.
//

import UIKit
import CalcCore

class CalcPadViewController: UIViewController {

    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var operationLabel: UILabel!
    @IBOutlet weak var currentNumberLabel: UILabel!
    
    var currentNumber : Double = 0.0
    var currentOperator : CalcOperator?
    var currentOperation : CalcOperation = CalcOperation()
    
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
        currentNumber = currentNumber * -1
        currentNumberLabel.text = String(currentNumber)
    }
    
    @IBAction func percentButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func operatorButtonTapped(_ sender: UIButton) {
        addOperationNode()
        
        var currentOp:CalcOperator = .plus
        switch sender.tag {
        case 101:
            currentOp = .divide
        case 102:
            currentOp = .multiply
        case 103:
            currentOp = .minus
        case 104:
            currentOp = .plus
        default:
            ()
        }
        
        currentOperator = currentOp
        operationLabel.text = operationLabel.text! + " " + currentOp.symbol
    }
    
    func addOperationNode() {
        if let currentOp = currentOperator {
            currentOperation.operationNodes.append(CalcOperationNode(op: currentOp, operand: currentNumber))
        } else {
            currentOperation.baseNumber = currentNumber
        }
        
        currentNumber = 0.0
        currentNumberLabel.text = String(currentNumber)
        operationLabel.text = currentOperation.operationString()
    }
    
    
    @IBAction func showResult(_ sender: UIButton) {
        addOperationNode()
        operationLabel.text = operationLabel.text! + " ="
        
        currentNumberLabel.text = String(currentOperation.calcResult())
    }
    
    @IBAction func pointButtonTapped(_ sender: UIButton) {
    }
    
}

