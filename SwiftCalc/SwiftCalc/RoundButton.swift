//
//  RoundButton.swift
//  SwiftCalc
//
//  Created by LingoStar on 2021/04/01.
//

import UIKit

class RoundButton: UIButton {

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = (self.frame.height/2)
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
