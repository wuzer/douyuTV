//
//  UIColor+Extension.swift
//  douyuTV
//
//  Created by Jefferson on 2016/10/17.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat) {
        
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }

}
