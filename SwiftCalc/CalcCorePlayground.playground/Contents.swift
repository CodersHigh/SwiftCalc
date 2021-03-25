import UIKit
import Foundation
import CalcCore


var calc = Operation(baseNumber: 3, operationNodes: [OperationNode(op: .minus, operand: 5), OperationNode(op: .multiply, operand: 2)])
calc.mergePriorityNode()
let result = calc.mergeOperationNodes()
