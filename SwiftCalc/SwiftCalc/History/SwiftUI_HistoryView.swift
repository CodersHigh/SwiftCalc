//
//  SwiftUI_HistoryView.swift
//  SwiftCalc
//
//  Created by 윤진영 on 2021/04/05.
//

import SwiftUI

struct SwiftUI_HistoryView: View {
    weak var delegate: CalcPadViewController?
    
    @State private var historyList : [History] = histories
    
    var body: some View {
        Button("닫기") {
            delegate?.dismiss(animated: true, completion: nil)
        }
        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
        
        List(historyList) { history in
            HStack {
                HistoryRow(history: history)
                    .onTapGesture {
                        delegate?.currentOperation = history.calcOperation
                        delegate?.showResult(UIButton())
                        histories = historyList
                        
                        delegate?.dismiss(animated: true, completion: nil)
                    }
                
                Spacer()
                
                Button("삭제") {
                    histories.remove(at: histories.firstIndex(where: { $0 == history })!)
                    historyList = histories
                }
                .foregroundColor(.red)
            }
        }
    }
    
    init(_ delegate: CalcPadViewController) {
        self.delegate = delegate
    }
}

struct HistoryRow: View {
    var history: History

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(history.getCalcOperationString())")
            Text("\(history.getDateString())")
        }
    }
}
