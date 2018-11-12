//
//  UIColor+Extension.swift
//  Shudder
//
//  Created by Erick Manrique on 11/11/18.
//  Copyright © 2018 homeapps. All rights reserved.
//

import UIKit

extension UIColor {
    /**
     Create a color using Float values
     
     - parameter r: red value
     - parameter g: green value
     - parameter b: blue value
     - parameter a: alpha value
     */
    convenience public init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(r: r, g: g, b: b, a: 1)
    }
    
    
    /**
     Create a color with alpha using Float values
     
     - parameter r: red value
     - parameter g: green value
     - parameter b: blue value
     - parameter a: alpha value
     */
    convenience public init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
}
