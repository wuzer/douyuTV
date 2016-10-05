//
//  UIbarButtonItem+Extension.swift
//  douyuTV
//
//  Created by Jefferson on 2016/10/5.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

import UIKit

extension UIBarButtonItem {

    convenience init(imageName: String, selectedImageName: String = "", size: CGSize = CGSize.zero) {
        
        let button = UIButton()
        
        button.setImage(UIImage.init(named: imageName), for: .normal)
        
        if selectedImageName != "" {
            button.setImage(UIImage.init(named: selectedImageName), for: .highlighted)
        }
        
        if size == CGSize.zero {
            button.sizeToFit()
        } else {
            button.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        self.init(customView :button)
    }
    
    
}

