import UIKit

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
}

public typealias Calc = (Node) -> Node

public indirect enum Node {
    case number(numValue : Double)
    case opnum (base:Node, op:CalcOperator , number:Double)
    
    public var calcValue : Double {
        switch self {
        case .number(let value):
            return value
        case .opnum(let base, let op, let number):
            switch op {
            case .multiply , .divide:
                return self.firstPriority(base).calcValue
            case .plus , .minus:
                return op.doCalc(base.calcValue, number)
            }
        }
    }
    
    var lastNumber : Double {
        switch self {
        case .number(let value):
            return value
        case .opnum(_, _, let number):
            return number
        }
    }
    
    var lastBase : Node? {
        switch self {
        case .number(_):
            return nil
        case .opnum(let base, _, _):
            return base
        }
    }
    
    var lastOp : CalcOperator? {
        switch self {
        case .number( _):
            return nil
        case .opnum(_, let op, _):
            return op
        }
    }
    
    
    var firstPriority: Calc {
        return { node in //node는 +, - 를 가진 노드
            switch self {
            case .opnum(let base ,let op, let number):
                print("firstPriority, \(op.rawValue), \(number)")
                return Node.opnum(base: base.lastBase! , op:base.lastOp!, number: op.doCalc(base.lastNumber,number))
            case .number(numValue: let numValue):
                return node
            }
        }
    }
}

let newNode = Node.number(numValue: 11.0)

let secondNode = Node.opnum(base: newNode, op: CalcOperator.plus, number: 2.0)

secondNode.calcValue

let thirdNode = Node.opnum(base: secondNode, op: .minus, number: 3.0)

thirdNode.calcValue

let fourthNode = Node.opnum(base: thirdNode, op: .minus, number: 2.0)

fourthNode.calcValue

let fifthNode = Node.opnum(base: fourthNode, op: .multiply, number: 2.0)

fifthNode.calcValue
