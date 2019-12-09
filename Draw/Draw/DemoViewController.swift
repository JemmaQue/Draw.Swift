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
    @IBOutlet weak var btnMove: UIButton!
    let btnColor:UIColor = UIColor().colorWithHexString("#FA6A7B")
    var disposeBag = DisposeBag()
    var animator: UIDynamicAnimator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialized()
        dynamic()
    }
    
    private func initialized() {
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
    }
    
    private func dynamic() {
        btnMove.layer.cornerRadius = 5.0
        btnMove.backgroundColor = btnColor
        btnMove.setTitle("start", for: .normal)
        btnMove.setTitle("stop", for: .selected)
        btnMove.rx.tap.subscribe(onNext: { [unowned self] _ in
            if self.btnMove.isSelected {
                self.stop()
            } else {
                self.start()
            }
        }).disposed(by: disposeBag)
    }
    
}

extension DemoViewController {
    func start() {
        btnMove.isSelected = true
        animator = UIDynamicAnimator(referenceView: rangeView)
        let gravity = UIGravityBehavior()
        gravity.addItem(dynamicBox)
        animator.addBehavior(gravity)
        let collision = UICollisionBehavior()
        collision.addItem(dynamicBox)
        collision.addBoundary(withIdentifier: "rangeView" as NSCopying, for: UIBezierPath(rect: rangeView.bounds))
        animator.addBehavior(collision)
        let push = UIPushBehavior(items: [dynamicBox], mode: .instantaneous)
        push.magnitude = 20.0
        push.addItem(dynamicBox)
        animator.addBehavior(push)
    }
    
    func stop() {
        btnMove.isSelected = false
        animator.removeAllBehaviors()
    }
}
