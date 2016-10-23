//
//  UIImage+Extension.swift
//  douyuTV
//
//  Created by Jefferson on 2016/10/21.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

import UIKit

typealias completionHandler = (UIImage) -> Void

extension UIImage {
    
     func dy_cornerImage(size: CGSize, fillcolor: UIColor, completion: @escaping completionHandler) {
        
        DispatchQueue.global().async {
            
            // begin context
            UIGraphicsBeginImageContextWithOptions(size, true, 0)
            let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            
            // set fill color
            fillcolor.setFill()
            UIRectFill(rect)
            
            // cut image
            let berzierPath = UIBezierPath.init(ovalIn: rect)
            
            berzierPath.addClip()
            self.draw(in: rect)
            
            let result = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            DispatchQueue.main.async {
                completion(result!)
            }
        }
    }
}
