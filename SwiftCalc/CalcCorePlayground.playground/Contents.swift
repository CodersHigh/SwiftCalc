import UIKit
import Foundation
import CalcCore


var calc = CalcOperation(baseNumber: 3, operationNodes: [CalcOperationNode(op: .minus, operand: 5), CalcOperationNode(op: .multiply, operand: 2)])
print(calc.operationString())
let result = calc.calcResult()
