//
//  HistoryObservable.swift
//  SwiftCalc
//
//  Created by 윤진영 on 2021/04/06.
//

import Foundation
import CalcCore

var histories : [CalcOperation] = []

public func getHistoryStrings() -> [String] {
    
    var historyStrings : [String] = []
    
    for i in 0..<histories.count{

        let historyString = histories[i].operationString() + " = " + String(histories[i].calcResult())

        historyStrings.append(historyString)
    }
    
    return historyStrings
}
