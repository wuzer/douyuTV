//
//  BaseViewModel.swift
//  douyuTV
//
//  Created by Jefferson on 2016/11/3.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

import UIKit
import HandyJSON

class BaseViewModel: NSObject {
    
    lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()
    
}

extension BaseViewModel {
    
    func loadAnchorData(path: String, parameters: [String: Any]? = nil, compelition: @escaping () -> ()) {
        
        HttpClient.requestData(type: .get, Path: path, parameters: parameters) { (response) in
            guard let responseDict = response as? [String: Any] else { return }
            guard let dictArray = responseDict["data"] as? [[String: Any]] else { return }
            
            for dict in dictArray {
                
                let anchor = JSONDeserializer<AnchorGroup>.deserializeFrom(dict: dict as NSDictionary?)
                self.anchorGroups.append(anchor!)
            }
            
            compelition()
        }
    }

}
