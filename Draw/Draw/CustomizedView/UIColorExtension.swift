//
//  UIColorExtension.swift
//  DynmDrawDemo
//
//  Created by Jemma on 2019/5/9.
//  Copyright © 2019 com.runxsports.IMSDKDemo. All rights reserved.
//

import UIKit

extension UIColor {
    func colorWithHexString(_ hexString: String) -> UIColor {
        // Convert hex string to an integer
        let hexint = Int(self.intFromHexString(hexStr: hexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        
        // Create color object, specifying alpha as well
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    private func intFromHexString(hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: hexStr)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        // Scan hex value
        scanner.scanHexInt32(&hexInt)
        return hexInt
    }
}
