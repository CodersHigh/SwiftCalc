//
//  HistoryVC.swift
//  SwiftCalc
//
//  Created by 윤진영 on 2021/04/05.
//

import Foundation
import SwiftUI

class HistoryVC: UIHostingController<SwiftUI_HistoryView> {

  

  init() {

    let view = SwiftUI_HistoryView()

    super.init(rootView: view)

  }

  

  @objc required dynamic init?(coder aDecoder: NSCoder) {

    fatalError("init(coder:) has not been implemented")

  }

}
