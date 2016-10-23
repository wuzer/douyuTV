//
//  NSDate+Extension.swift
//  douyuTV
//
//  Created by Jefferson on 2016/10/22.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

import Foundation

extension NSDate {
    
    class func getCurrentTime() -> String {
        
        let nowDate = NSDate()
        
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
}
