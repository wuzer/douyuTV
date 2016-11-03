//
//  GameViewModel.swift
//  douyuTV
//
//  Created by Jefferson on 2016/10/25.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

import UIKit
import HandyJSON

class GameViewModel: NSObject {

    lazy var gameModels: [GameModel] = [GameModel]()
    
}

extension GameViewModel {
    
    
    func loadGameData(compelition: @escaping () -> ()) {
    
        HttpClient.requestData(type: .get, Path: APIColumnDetail, parameters: ["shortName" : "game"]) { (response) in
            
            guard let response = response as? [String : Any] else { return }
            guard let dataArray = response["data"] as? [[String : Any]] else { return }
            
            for dict in dataArray {
                let game = JSONDeserializer<GameModel>.deserializeFrom(dict: dict as NSDictionary)
                self.gameModels.append(game!)
            }
            
            compelition()
        }
        
    }
}
