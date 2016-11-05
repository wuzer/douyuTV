//
//  AmuseViewModel.swift
//  douyuTV
//
//  Created by Jefferson on 2016/11/3.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

import UIKit

class AmuseViewModel: BaseViewModel {

    func loadAmuseData(compelition:@escaping () -> ()) {
        loadAnchorData(isGroup: true, path: APIGetHotRoom, compelition: compelition)
    }
}
