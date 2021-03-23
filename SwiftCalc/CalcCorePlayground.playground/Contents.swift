import UIKit
import Foundation
import CalcCore


var calc = Operation(baseNumber: 3, operationNodes: [OperationNode(op: .plus, operand: 5), OperationNode(op: .multiply, operand: 2)])
let result = calc.mergeOperationNodes()


