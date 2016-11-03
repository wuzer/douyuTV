//
//  AmuseViewModel.swift
//  douyuTV
//
//  Created by Jefferson on 2016/11/3.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

import UIKit
import HandyJSON

class AmuseViewModel: NSObject {
    
    lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()

    func loadAmuseData(compelition:@escaping () -> ()) {
     
        HttpClient.requestData(type: .get, Path: APIGetHotRoom) { (response) in
         
//            print(response)
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
