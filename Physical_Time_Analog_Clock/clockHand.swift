//
//  clockHand.swift
//  Physical_Time_Analog_Clock
//
//  Created by Xi Stephen Ouyang on 2/17/18.
//  Copyright © 2018 Xi Stephen Ouyang. All rights reserved.
//

import Foundation
import UIKit

class Create_Rect: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func draw(_ rect: CGRect) {
        let h = rect.height
        let w = rect.width
        let color:UIColor = UIColor.red
        
        let drect = CGRect(x: (w * 0.25), y: (h * 0.02),width: (w * 0.5), height: (h * 0.20))
        let bpath:UIBezierPath = UIBezierPath(rect: drect)
        
        color.set()
        bpath.stroke()
    }
}

