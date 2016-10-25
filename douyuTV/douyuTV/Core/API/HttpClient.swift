//
//  HttpClient.swift
//  douyuTV
//
//  Created by Jefferson on 2016/10/21.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

import UIKit
import Alamofire


class HttpClient: NSObject {

    class func requestData(type: HTTPMethod, Path: String, parameters: [String : Any]? = nil, compelition: @escaping (_ respose: AnyObject) -> ()) {
    
        // get type
        let method = type == .get ?  HTTPMethod.get : HTTPMethod.post
        Alamofire.request(KBaseUrl + Path, method: method, parameters: parameters, encoding: URLEncoding.default).responseJSON { (response) in
            
            guard let result = response.result.value else {
                print(response.result.error)
                return
            }
            compelition(result as AnyObject)
        }
        
    }
    
}
