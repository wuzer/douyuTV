//
//  AnchorGroup.swift
//  douyuTV
//
//  Created by Jefferson on 2016/10/22.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

import UIKit
import HandyJSON

class AnchorGroup: HandyJSON {

    var room_list: [AnchorModel] = [AnchorModel]()
    var tag_name: String?
    var icon_name: String = "home_header_normal"
    
    required init() {
        
    }
    
}
