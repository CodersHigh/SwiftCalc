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
        NavigationView {
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 0) {
                    ForEach(historyList, id:\.id) { history in
                        HistoryRow(history: history)
                            .onTapGesture {
                                delegate?.currentOperation = history.calcOperation
                                delegate?.showResult(UIButton())
                                histories = historyList
                                
                                delegate?.dismiss(animated: true, completion: nil)
                            }
                            .addButtonActions(leadingButtons: [], trailingButton:  [.delete, .share], onClick: { button in
                                switch button {
                                case .delete:
                                    withAnimation {
                                        histories.remove(at: histories.firstIndex(where: { $0 == history })!)
                                        historyList = histories
                                    }
                                    
                                case .share:
                                    share(history.getCalcOperationString())
                                }
                            })
                    }
                }
            }
            .navigationTitle("History")
            .navigationBarItems(leading:
                                    Button(action: {
                                        delegate?.dismiss(animated: true, completion: nil)
                                    }, label: {
                                        Text("닫기")
                                            .font(.body)
                                            .fontWeight(.regular)
                                            .foregroundColor(Color(red: 98 / 255, green: 100 / 255, blue: 102 / 255))
                                        
                                    })
                                    .frame(width: 32, height: 32, alignment: .center)
            )
        }
    }
    
    init(_ delegate: CalcPadViewController) {
        self.delegate = delegate
    }
    
    //share result with other people
    private func share(_ result: String) {
        delegate?.dismiss(animated: true, completion: {
            let av = UIActivityViewController(activityItems: [result], applicationActivities: nil)
            UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
        })
        
    }
}

struct HistoryRow: View {
    var history: History
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Spacer()
            VStack(alignment: .leading, spacing: 8) {
                Text("\(history.getCalcOperationString())")
                Text("\(history.getDateString())")
            }
            .padding(.leading, 24)
            Divider()
        }
        
    }
}

