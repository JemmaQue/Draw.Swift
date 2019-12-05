//
//  ViewController.swift
//  Draw
//
//  Created by Jemma on 2019/12/5.
//  Copyright © 2019 AppDemo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        switchToLoginView()
    }

    private func switchToLoginView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DemoViewController") as! DemoViewController
        self.navigationController?.show(vc, sender: nil)
    }
}

