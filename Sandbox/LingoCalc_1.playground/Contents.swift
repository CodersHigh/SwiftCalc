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


public indirect enum Node {
    case number(numValue : Double)
    case opnum (base:Node, op:CalcOperator , number:Double)
    
    var calcValue : Double {
        switch self {
        case .number(let value):
            return value
        case .opnum(let base, let op, let number):
                return op.doCalc(base.calcValue, number)
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
