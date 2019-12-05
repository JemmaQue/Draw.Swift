//
//  Box.swift
//  DynmDrawDemo
//
//  Created by Jemma on 2019/5/8.
//  Copyright © 2019 com.runxsports.IMSDKDemo. All rights reserved.
//

import UIKit

enum BoxShape {
    case rectangle
    case circle
    case triangle
}

class Box: UIView {
    private var fillColor: UIColor = .orange
    var boxShape: BoxShape = .rectangle {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    func setBoxShape(_ boxShape: BoxShape,fillColor: UIColor) {
        self.fillColor = fillColor
        self.boxShape = boxShape
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialized()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialized()
    }

    private func initialized() {
        self.backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        switch boxShape {
        case .rectangle:
            self.drawRectangle(rect: rect, fillColor: fillColor)
            
        case .circle:
            self.drawCircle(rect: rect, fillColor: fillColor)
            
        case .triangle:
            self.drawTriangle(rect: rect, fillColor: fillColor)
            
        }
        
    }


}
