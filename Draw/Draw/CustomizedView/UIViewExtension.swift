//
//  UIViewExtension.swift
//  DynmDrawDemo
//
//  Created by Jemma on 2019/5/9.
//  Copyright © 2019 com.runxsports.IMSDKDemo. All rights reserved.
//

import UIKit

extension UIView {
    private func removeSublayers() {
        for layer in self.layer.sublayers!{
            if layer is CAShapeLayer {
                layer.removeFromSuperlayer()
            }
        }
    }
    
    private func addSublayer(_ path: UIBezierPath,_ fillColor: UIColor) {
        let mLineShapeLayer = CAShapeLayer()
        mLineShapeLayer.path = path.cgPath
        mLineShapeLayer.fillColor = fillColor.cgColor
        self.layer.addSublayer(mLineShapeLayer)
    }
    
    func addCircleLayer(_ fillColor: UIColor) {
        removeSublayers()
        let path = UIBezierPath()
        let radius = min(self.frame.width,self.frame.height)
        path.addArc(withCenter: CGPoint(x: self.frame.width/2, y: self.frame.height/2), radius: radius/2, startAngle: 0, endAngle: .pi*2, clockwise: true)
        self.addSublayer(path,fillColor)
    }
    
    func addTriangleLayer(_ fillColor: UIColor) {
        removeSublayers()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: self.frame.width*0.5, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.addLine(to: CGPoint(x: self.frame.width*0.5, y: 0))
        self.addSublayer(path,fillColor)
    }
    
    func addRectangleLayer(_ fillColor: UIColor) {
        removeSublayers()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        self.addSublayer(path,fillColor)
    }
    
    func drawRectangle(rect: CGRect ,fillColor: UIColor) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(fillColor.cgColor)
        context.addRect(rect)
        context.fillPath()
    }
    
    func drawCircle(rect: CGRect ,fillColor: UIColor) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(fillColor.cgColor)
        context.fillEllipse(in: rect)
    }

    func drawTriangle(rect: CGRect ,fillColor: UIColor) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(fillColor.cgColor)
        context.move(to: CGPoint(x: rect.size.width*0.5, y: 0))
        context.addLine(to: CGPoint(x: rect.size.width, y: rect.size.height))
        context.addLine(to: CGPoint(x: 0, y: rect.size.height))
        context.addLine(to: CGPoint(x: rect.size.width*0.5, y: 0))
        context.fillPath()
    }
}
