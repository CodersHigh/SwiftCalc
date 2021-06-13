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
        currentNumberLabel.text = currentNumber.truncatingRemainder(dividingBy: 1.0) == 0.0 ? String(Int64(currentNumber)) : String(currentNumber)
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
        
        let currentNumberData = UserDefaults.standard.value(forKey: "currentNumber") as? Data
        if let currentNumberData = currentNumberData, let decode = try? JSONDecoder().decode(Double.self, from: currentNumberData) {
            currentNumber = decode
        }
        
        let currentOperatorData = UserDefaults.standard.value(forKey: "currentOperator") as? Data
        if let currentOperatorData = currentOperatorData, let decode = try? JSONDecoder().decode(CalcOperator.self, from: currentOperatorData) {
            currentOperator = decode
        }
        
        let currentOperationData = UserDefaults.standard.value(forKey: "currentOperation") as? Data
        if let currentOperationData = currentOperationData, let decode = try? JSONDecoder().decode(CalcOperation.self, from: currentOperationData) {
            currentOperation = decode
        }
        
        let operationLabelData = UserDefaults.standard.value(forKey: "operationLabel") as? Data
        if let operationLabelData = operationLabelData, let decode = try? JSONDecoder().decode(String.self, from: operationLabelData) {
            operationLabel.text = decode
        }
        
        let currentNumberLabelData = UserDefaults.standard.value(forKey: "currentNumberLabel") as? Data
        if let currentNumberLabelData = currentNumberLabelData, let decode = try? JSONDecoder().decode(String.self, from: currentNumberLabelData) {
            currentNumberLabel.text = decode
        }
        
        let historiesData = UserDefaults.standard.value(forKey: "histories") as? Data
        if let historiesData = historiesData, let decode = try? JSONDecoder().decode([History].self, from: historiesData) {
            histories = decode
        }
    }
    
    func save() {
        if let jsonData = try? JSONEncoder().encode(currentNumber) {
            UserDefaults.standard.set(jsonData, forKey: "currentNumber")
        }
        if let jsonData = try? JSONEncoder().encode(currentOperator) {
            UserDefaults.standard.set(jsonData, forKey: "currentOperator")
        }
        if let jsonData = try? JSONEncoder().encode(currentOperation) {
            UserDefaults.standard.set(jsonData, forKey: "currentOperation")
        }
        if let jsonData = try? JSONEncoder().encode(operationLabel.text) {
            UserDefaults.standard.set(jsonData, forKey: "operationLabel")
        }
        if let jsonData = try? JSONEncoder().encode(currentNumberLabel.text) {
            UserDefaults.standard.set(jsonData, forKey: "currentNumberLabel")
        }
    }
    
    @IBAction func numberPadTapped(_ sender: UIButton) {
        if operationLabel.text!.hasSuffix("=") {
            currentOperation = CalcOperation()
        }
        
        let buttonNumber = sender.tag - 50
        currentNumber = currentNumber * 10 + Double(buttonNumber)
        
        save()
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        if currentNumber != 0.0 {
            currentNumber = 0.0
        } else {
            currentOperation = CalcOperation()
        }
        
        save()
    }
    
    @IBAction func plusMinusTapped(_ sender: UIButton) {
        currentNumber = currentNumber * -1
        
        save()
    }
    
    @IBAction func percentButtonTapped(_ sender: UIButton) {
        if currentNumber != 0.0 {
            currentNumber = currentNumber / 100
        }
        
        save()
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
        
        save()
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
        
        histories.append(History(calcOperation: currentOperation, date: Date()))
        
        let result = currentOperation.calcResult()
        currentNumberLabel.text = result.truncatingRemainder(dividingBy: 1.0) == 0.0 ? String(Int64(result)) : String(result)
        
        if operationLabel.text!.last!.isNumber {
            operationLabel.text = operationLabel.text! + " ="
        }
        else {
            operationLabel.text = String(operationLabel.text!.dropLast()) + "="
        }
        
        save()
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
        self.present(HistoryVC(self), animated: true, completion: nil)
    }
}
