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
    @IBOutlet weak var rectangleBox: Box!
    @IBOutlet weak var circleBox: Box!
    @IBOutlet weak var triangleBox: Box!
    @IBOutlet weak var btnRectangle: UIButton!
    @IBOutlet weak var btnCircle: UIButton!
    @IBOutlet weak var btnTriangle: UIButton!
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
    }

}
