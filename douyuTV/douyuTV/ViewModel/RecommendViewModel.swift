//
//  RecommendViewModel.swift
//  douyuTV
//
//  Created by Jefferson on 2016/10/22.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

import UIKit
import HandyJSON

class RecommendViewModel: BaseViewModel {

    lazy var SlideModels : [SlideModel] = [SlideModel]()
    fileprivate lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    fileprivate lazy var verticalGroup : AnchorGroup = AnchorGroup()

}

extension RecommendViewModel {
    
    func requestData(compelition: @escaping () -> ()) {
        
        let parameter = ["limit": "4", "offset": "0", "time": NSDate.getCurrentTime()]
        
        let globalGroup = DispatchGroup()
        
        globalGroup.enter()
        // get bigData
        HttpClient.requestData(type: .get, Path: APIBigData, parameters: ["time": NSDate.getCurrentTime() as NSString]) { (response) in
            
            // convert dict
            guard let responseDict = response as? [String: Any] else { return }
            
            // get data
            guard let dataArray = responseDict["data"] as? [[String: Any]] else { return }
            
//            let anchors = AnchorGroup()
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
//            self.bigDataGroup.room_list
            
            for dict in dataArray {
                let anchor = JSONDeserializer<AnchorModel>.deserializeFrom(dict: dict as NSDictionary)
                self.bigDataGroup.room_list.append(anchor!)
            }
            
//            print("请求--------0------")
            globalGroup.leave()
        }
        
        globalGroup.enter()
        // get vertical
        HttpClient.requestData(type: .get, Path: APIVertical, parameters: parameter as [String : Any]?) { (response) in
            
            // convert dict
            guard let responseDict = response as? [String: Any] else { return }
            
            // get data
            guard let dataArray = responseDict["data"] as? [[String: Any]] else { return }
            
            self.verticalGroup.tag_name = "颜值"
            self.verticalGroup.icon_name = "home_header_phone"
            
            for dict in dataArray {
                let anchor = JSONDeserializer<AnchorModel>.deserializeFrom(dict: dict as NSDictionary)
                self.verticalGroup.room_list.append(anchor!)
            }
//            print("请求--------1------")
            globalGroup.leave()
        }
        
        
        globalGroup.enter()
        // get hotcate
        loadAnchorData(isGroup: true, path: APIHotcate, parameters: parameter) {
            globalGroup.leave()
        }
//        HttpClient.requestData(type: .get, Path: APIHotcate, parameters: parameter as [String : Any]?) { (response) in
////            print(response)
//            
//            // convert dict
//            guard let responseDict = response as? [String: Any] else { return }
//            
//            // get data
//            guard let dataArray = responseDict["data"] as? [[String: Any]] else { return }
//            
//            for dict in dataArray {
//                let anchor = JSONDeserializer<AnchorGroup>.deserializeFrom(dict: dict as NSDictionary)
//                self.anchorGroups.append(anchor!)
//            }
////            print("请求--------2-12------")
//            globalGroup.leave()
//        }
        
        // request finish
        globalGroup.notify(queue: DispatchQueue.main) { 
//            print("请求--------comeplition------")
            
            self.anchorGroups.insert(self.verticalGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
 
            compelition()
        }
        
    }
    
    func requestCycleData(compelition: @escaping () -> ()) {
    
        HttpClient.requestData(type: .get, Path: APISlide_6, parameters: ["version": "2.300"]) { (response) in
         
            guard let response = response as? [String : Any] else { return }
            
            guard let dataArray = response["data"] as? [[String : Any]] else { return }
            
            for dict in dataArray {
                let slideModel = JSONDeserializer<SlideModel>.deserializeFrom(dict: dict as NSDictionary)
                self.SlideModels.append(slideModel!)
            }

            compelition()
        }
    }
}
