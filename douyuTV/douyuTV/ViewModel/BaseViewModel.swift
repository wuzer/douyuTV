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
    
    func loadAnchorData(isGroup: Bool, path: String, parameters: [String: Any]? = nil, compelition: @escaping () -> ()) {
        
        HttpClient.requestData(type: .get, Path: path, parameters: parameters) { (response) in
            guard let responseDict = response as? [String: Any] else { return }
            guard let dictArray = responseDict["data"] as? [[String: Any]] else { return }
            
            if isGroup {
                for dict in dictArray {
                    
                    let anchor = JSONDeserializer<AnchorGroup>.deserializeFrom(dict: dict as NSDictionary?)
                    self.anchorGroups.append(anchor!)
                }
            } else {
                
                let anchors = AnchorGroup()
                for dict in dictArray {
                    let anchor = JSONDeserializer<AnchorModel>.deserializeFrom(dict: dict as NSDictionary?)
                    anchors.room_list.append(anchor!)
                }
                self.anchorGroups.append(anchors)
            }
            
            compelition()
        }
    }

}
