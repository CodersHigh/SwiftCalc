//
//  CalcCore.swift
//  SwiftCalc
//
//  Created by LingoStar on 2021/03/23.
//

import Foundation

/// 사칙연산을 위한 연산자 Enumeration.
public enum CalcOperator: String, Codable {
    case plus
    case minus
    case multiply
    case divide
    
    /// 연산을 실행할 함수를 가리키는 변수
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
    
    /// UI 표시를 위한 연산자의 문자열 표기
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

/**
계산을 위한 노드.
 
연산자와 연산항의 쌍으로 구성

 ~~~
 // + : operation , 35 : operand
 let operation = CalcOperationNode(op: CalcOperator.plus , operand:35.0)
 ~~~
*/
public struct CalcOperationNode: Codable {
    var op: CalcOperator
    var operand : Double
    
    public init(op:CalcOperator , operand:Double) {
        self.op = op
        self.operand = operand
    }
}
//MARK: -
/// 전체 연산자에 대한 구조체. 베이스 값을 시작으로 operationNode들이 체인처럼 연결된다.
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
    
    /// 우선 순위가 높은 *와 / 연산을 하고 우선 순위가 낮은 +와 - 연산을 리턴한다.
    ///
    /// - Returns : + 와 - 로만 구성된 CalcOperation 구조체
    public func mergePriorityNode() -> CalcOperation {
        // self를 newCalcOperation에 할당하여 새로운 인스턴스를 생성한 뒤, 생성한 인스턴스로 연산을 하고 그 결과를 리턴한다.
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
    
    /// 전체 연산을 앞에서부터 순차적으로 수행하고 결과값을 리턴한다
    ///
    /// - Returns : 연산의 결과 Double 값
    public func mergeOperationNodes() -> Double {
        let value = operationNodes.reduce(baseNumber, {
            (result:Double, element:CalcOperationNode) in
            element.op.doCalc(result, element.operand)
        })
        return value
    }
    
    /// 연산을 순서대로 수행하도록 하는 함수
    public func calcResult() -> Double {
        return mergePriorityNode().mergeOperationNodes()
    }
    
    /// UI 표시를 위해 연산의 내용을 문자열로 리턴하는 함수
    public func operationString() -> String {
        return operationNodes.reduce(String(baseNumber), {
            (result:String, element:CalcOperationNode) in
        result + " " + element.op.symbol + " " + String(element.operand)
        })
    }
}
