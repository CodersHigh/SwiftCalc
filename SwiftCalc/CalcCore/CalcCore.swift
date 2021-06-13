//
//  CalcCore.swift
//  SwiftCalc
//
//  Created by LingoStar on 2021/03/23.
//

import Foundation

public enum CalcOperator: String, Codable {
    case plus
    case minus
    case multiply
    case divide
    
    var doCalc : (Double , Double) -> Double {
        switch self {
            case .plus:
                return (+)
            case .minus:
                return (-)
            case .multiply:
                return (*)
            case .divide:
                return (/)
        }
    }
    
    public var symbol : String {
        switch self {
            case .plus:
                return "+"
            case .minus:
                return "-"
            case .multiply:
                return "×"
            case .divide:
                return "÷"
        }
    }
}

public struct CalcOperationNode: Codable {
    var op: CalcOperator
    var operand : Double
    
    public init(op:CalcOperator , operand:Double) {
        self.op = op
        self.operand = operand
    }
}


public struct CalcOperation: Codable {
    public var baseNumber : Double
    public var operationNodes : [CalcOperationNode]
    
    public init () {
        self.baseNumber = 0.0
        self.operationNodes = [CalcOperationNode]()
    }
    
    public init (baseNumber: Double, operationNodes:[CalcOperationNode]) {
        self.baseNumber = baseNumber
        self.operationNodes = operationNodes
    }
    
    public func mergePriorityNode() -> CalcOperation {
        var newCalcOperation = self
        var newNodes:[CalcOperationNode] = []
        
        for node in self.operationNodes {
            if node.op == .multiply || node.op == .divide {
                let base : Double
                if newNodes.isEmpty {
                    base = newCalcOperation.baseNumber
                    let newOperand = node.op.doCalc(base , node.operand)
                    newCalcOperation.baseNumber = newOperand
                } else {
                    let latestNode = newNodes.removeLast()
                    base = latestNode.operand
                    let newOperand = node.op.doCalc(base, node.operand)
                    newNodes.append(CalcOperationNode(op: latestNode.op, operand: newOperand))
                }
            } else {
                newNodes.append(node)
            }
        }
        
        newCalcOperation.operationNodes = newNodes
        return newCalcOperation
    }
    
    
    public func mergeOperationNodes() -> Double {
        let value = operationNodes.reduce(baseNumber, {
            (result:Double, element:CalcOperationNode) in
            element.op.doCalc(result, element.operand)
        })
        return value
    }
    
    public func calcResult() -> Double {
        return mergePriorityNode().mergeOperationNodes()
    }
    
    public func operationString() -> String {
        return operationNodes.reduce(String(baseNumber), {
            (result:String, element:CalcOperationNode) in
        result + " " + element.op.symbol + " " + String(element.operand)
        })
    }
}
