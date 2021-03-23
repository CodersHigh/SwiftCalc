//
//  CalcCore.swift
//  SwiftCalc
//
//  Created by LingoStar on 2021/03/23.
//

import Foundation

public enum Operator {
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
}

public struct OperationNode {
    var op: Operator
    var operand : Double
    
    public init(op:Operator , operand:Double) {
        self.op = op
        self.operand = operand
    }
}


public struct Operation {
    public var baseNumber : Double
    public var operationNodes : [OperationNode]
    
    public init (baseNumber: Double, operationNodes:[OperationNode]) {
        self.baseNumber = baseNumber
        self.operationNodes = operationNodes
    }
    
    public func mergeOperationNodes() {
        let value = operationNodes.reduce(baseNumber, {
            (result:Double, element:OperationNode) in
            element.op.doCalc(result, element.operand)
        })
        print(value)
    }
}
