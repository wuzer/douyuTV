//
//  FunnyViewModel.swift
//  douyuTV
//
//  Created by Jefferson on 2016/11/5.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

import UIKit

class FunnyViewModel: BaseViewModel {

}

extension FunnyViewModel {
    
    func loadFunnyData(compelition: @escaping() -> ()) {
        loadAnchorData(isGroup: false, path: APIGetColumn, parameters: ["limit": 30, "offset": 0], compelition: compelition)
    }
}
