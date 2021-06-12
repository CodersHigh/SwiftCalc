//
//  HistoryObservable.swift
//  SwiftCalc
//
//  Created by 윤진영 on 2021/04/06.
//

import Foundation
import CalcCore

var histories : [History] = [] {
    didSet {
        let jsonData = try? JSONEncoder().encode(histories)
        
        UserDefaults.standard.set(jsonData, forKey: "histories")
    }
}

struct History: Identifiable, Equatable, Codable {
    var id = UUID()
    let calcOperation: CalcOperation
    let date: Date
    
    static func == (lhs: History, rhs: History) -> Bool {
        return lhs.id == rhs.id
    }
    
    func getCalcOperationString() -> String {
        return calcOperation.operationString() + " = " + String(calcOperation.calcResult())
    }
    
    func getDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.dateFormat = "yyyy년 M월 d일 a h시 m분 s초"
        
        return dateFormatter.string(from: date)
    }
}
