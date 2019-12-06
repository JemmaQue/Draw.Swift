//
//  DemoViewController.swift
//  DynmDrawDemo
//
//  Created by Jemma on 2019/5/8.
//  Copyright © 2019 com.runxsports.IMSDKDemo. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class DemoViewController: UIViewController {

    @IBOutlet weak var dynamicBox: Box!
    @IBOutlet weak var rangeView: UIView!
    @IBOutlet weak var rectangleBox: Box!
    @IBOutlet weak var circleBox: Box!
    @IBOutlet weak var triangleBox: Box!
    @IBOutlet weak var btnRectangle: UIButton!
    @IBOutlet weak var btnCircle: UIButton!
    @IBOutlet weak var btnTriangle: UIButton!
    @IBOutlet weak var moveButton: UIButton!
    var repeatTimer: Timer?
    var moveX: CGFloat?
    var moveY: CGFloat?
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialized()
    }
    
    private func initialized() {
        let btnColor:UIColor = UIColor().colorWithHexString("#FA6A7B")
        rectangleBox.setBoxShape(.rectangle, fillColor: btnColor)
        circleBox.setBoxShape(.circle, fillColor: btnColor)
        triangleBox.setBoxShape(.triangle, fillColor: btnColor)
        
        btnRectangle.rx.tap.subscribe(onNext: { [unowned self] _ in
            self.dynamicBox.boxShape = .rectangle
        }).disposed(by: disposeBag)
        btnCircle.rx.tap.subscribe(onNext: { [unowned self] _ in
            self.dynamicBox.boxShape = .circle
        }).disposed(by: disposeBag)
        btnTriangle.rx.tap.subscribe(onNext: { [unowned self] _ in
            self.dynamicBox.boxShape = .triangle
        }).disposed(by: disposeBag)
        
        moveButton.layer.cornerRadius = 5.0
        moveButton.backgroundColor = btnColor
        moveButton.setTitle("start", for: .normal)
        moveButton.setTitle("stop", for: .selected)
        let theta: Double = Double.random(in: 15...30)
        moveX = CGFloat(cos(theta * Double.pi / 180))
        moveY = CGFloat(sin(theta * Double.pi / 180))
        moveButton.rx.tap.subscribe(onNext: { [unowned self] _ in
            if self.moveButton.isSelected {
                self.stop()
            } else {
                self.start()
            }
        }).disposed(by: disposeBag)
        
    }

}

extension DemoViewController {
    func start() {
        self.moveButton.isSelected = true
        repeatTimer =
            Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { [unowned self] _ in
                self.move()
        })
    }
    
    func move() {
        guard let x = moveX, let y = moveY else {
            return
        }
        
        if (dynamicBox.frame.maxX + x > rangeView.bounds.maxX){
            self.moveX = x * -1
        }
        
        if (dynamicBox.frame.maxY + y > rangeView.bounds.maxY){
            self.moveY = y * -1
        }
        
        if (dynamicBox.frame.minX + x < rangeView.bounds.minX){
            self.moveX = x * -1
        }
        
        if (dynamicBox.frame.minY + y < rangeView.bounds.minY){
            self.moveY = y * -1
        }
        
        UIView.animate(withDuration: 0.01, animations: {
            guard let x = self.moveX, let y = self.moveY else {
                return
            }
            self.dynamicBox.frame = CGRect(x:self.dynamicBox.frame.origin.x + x,
            y: self.dynamicBox.frame.origin.y + y,
            width: self.dynamicBox.frame.size.width, height: self.dynamicBox.frame.size.height);
        })
        
    }
    
    func stop() {
        self.moveButton.isSelected = false
        repeatTimer?.invalidate()
    }
    
}
