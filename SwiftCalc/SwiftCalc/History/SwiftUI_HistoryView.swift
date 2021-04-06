//
//  SwiftUI_HistoryView.swift
//  SwiftCalc
//
//  Created by 윤진영 on 2021/04/05.
//

import SwiftUI

struct SwiftUI_HistoryView: View {
    
    @State private var historyList : [History] = []
    
    var body: some View {
        List(historyList) { history in
            HistoryRow(history: history)
        }
        .onAppear(){
            let historyString = getHistoryStrings()
            
            for string in historyString{
                historyList.append(History(history: string))
            }
        }
    }
}

struct History: Identifiable {
    let id = UUID()
    let history: String
}

struct HistoryRow: View {
    var history: History

    var body: some View {
        Text("\(history.history)")
    }
}
