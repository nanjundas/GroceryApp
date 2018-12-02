//
//  UIKitExtensions.swift
//  GroceryApp
//
//  Created by Nanjundaswamy Sainath on 2/12/18.
//  Copyright © 2018 Nanjunda. All rights reserved.
//

import Foundation
import UIKit


extension UIColor {
    
    public convenience init(hex: UInt32) {
        self.init(hex:hex, alpha:1)
    }
    
    public convenience init(hex: UInt32, alpha: CGFloat = 1) {
        let divisor = CGFloat(255)
        let red     = CGFloat((hex & 0xFF0000) >> 16) / divisor
        let green   = CGFloat((hex & 0x00FF00) >>  8) / divisor
        let blue    = CGFloat( hex & 0x0000FF       ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    public static func random() -> UIColor {
        return UIColor(red:   CGFloat(drand48()),
                       green: CGFloat(drand48()),
                       blue:  CGFloat(drand48()),
                       alpha: 1.0)
    }
}
