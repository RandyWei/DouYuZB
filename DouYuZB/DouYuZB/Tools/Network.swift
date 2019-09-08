//
//  Network.swift
//  DouYuZB
//
//  Created by RandyWei on 2019/9/8.
//  Copyright © 2019 RandyWei. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

class Network {
    class func request(url:String,methodType:MethodType, params:[String:NSString]? = nil,callback:@escaping (_ result:AnyObject)->()){
        let method = methodType == MethodType.GET ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(url, method: method, parameters: params).responseJSON { (response) in
            guard let result = response.result.value else {
                return
            }
            callback(result as AnyObject)
        }
    }
}
