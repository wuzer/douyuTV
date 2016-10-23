//
//  AnchorModel.swift
//  douyuTV
//
//  Created by Jefferson on 2016/10/22.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

import UIKit
import HandyJSON

class AnchorModel: HandyJSON {
    
    var room_id: Int = 0
    var vertical_src: String?
    var isVertical: Int?
    var room_name: String?
    var nickname: String?
    var online: Int?
    var anchor_city: String?
    
    required init() {
        
    }
}
