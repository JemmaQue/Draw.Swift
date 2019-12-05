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
        
        let theta: Double = Double.random(in: 15...30)
        moveX = CGFloat(cos(theta * M_PI / 180))
        moveY = CGFloat(sin(theta * M_PI / 180))
        start()
    }

}

extension DemoViewController {
    func start() {
        repeatTimer =
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [unowned self] _ in
                self.move()
        })
    }
    
    func move() {
        guard let moveX = moveX, let moveY = moveY else {
            return
        }
        if (dynamicBox.frame.maxX + moveX > rangeView.frame.maxX){
            self.moveX = moveX * -1;
        }
        
        if (dynamicBox.frame.maxY + moveY > rangeView.frame.maxY){
            self.moveY = moveY * -1;
        }
        
        if (dynamicBox.frame.minX + moveX < rangeView.frame.minX){
            self.moveX = moveX * -1;
        }
        
        if (dynamicBox.frame.minY + moveY < rangeView.frame.minY){
            self.moveY = moveY * -1;
        }
        
        dynamicBox.frame = CGRect(x: dynamicBox.frame.origin.x + moveX,
                                  y: dynamicBox.frame.origin.y + moveY,
                                  width: dynamicBox.frame.size.width, height: dynamicBox.frame.size.height);
    }
    
    func stop() {
        repeatTimer?.invalidate()
    }
    
}
