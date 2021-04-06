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
    
    var currentNumber : Double = 0.0 { didSet { updateUI() }}
    var currentOperator : CalcOperator? { didSet { updateUI() }}
    var currentOperation : CalcOperation = CalcOperation() { didSet { updateUI() }}
    
    func updateUI() {
        currentNumberLabel.text = String(currentNumber)
        operationLabel.text = currentOperation.operationString()
        if let op = currentOperator {
            operationLabel.text = operationLabel.text! + " " + op.symbol
        }
        
        if currentNumber != 0.0 {
            clearButton.setTitle("C", for: .normal)
        } else {
            clearButton.setTitle("AC", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(deleteNumber(_:)))
        currentNumberLabel.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func numberPadTapped(_ sender: UIButton) {
        let buttonNumber = sender.tag - 50
        currentNumber = currentNumber * 10 + Double(buttonNumber)
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        if currentNumber != 0.0 {
            currentNumber = 0.0
        } else {
            currentOperation = CalcOperation()
        }
    }
    
    @IBAction func plusMinusTapped(_ sender: UIButton) {
        currentNumber = currentNumber * -1
    }
    
    @IBAction func percentButtonTapped(_ sender: UIButton) {
        if currentNumber != 0.0 {
            currentNumber = currentNumber / 100
        }
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
    }
    
    func addOperationNode() {
        guard currentNumber != 0.0 else {
            return
        }
        if let currentOp = currentOperator {
            currentOperation.operationNodes.append(CalcOperationNode(op: currentOp, operand: currentNumber))
        } else {
            currentOperation.baseNumber = currentNumber
        }
        currentOperator = nil
        currentNumber = 0.0
    }
    
    
    @IBAction func showResult(_ sender: UIButton) {
        addOperationNode()
        
        histories.append(currentOperation)
        
        currentNumberLabel.text = String(currentOperation.calcResult())
        operationLabel.text = operationLabel.text! + " ="
    }

    @objc
    @IBAction func deleteNumber(_ sender: Any) {
        guard currentNumber != 0.0 else {
            return
        }
        let lastNumber = currentNumber.truncatingRemainder(dividingBy: 10.0)
        //let shareNumber = currentNumber.formTruncatingRemainder(dividingBy: 10.0)
        currentNumber = (currentNumber - lastNumber)/10
        
    }
    
    @IBAction func historyButton(_ sender: Any) {
        self.present(HistoryVC(), animated: true, completion: nil)
    }
}

