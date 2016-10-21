//
//  HttpClient.swift
//  douyuTV
//
//  Created by Jefferson on 2016/10/21.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

class HttpClient: NSObject {

    class func requestData(type: MethodType, Path: String, parameters: [String : NSString]? = nil, compelition: (_ respose: AnyObject) -> ()) {
    
        // get type
        let method = type == .GET ? MethodType.GET : MethodType.POST
    
        
    }
    
}
