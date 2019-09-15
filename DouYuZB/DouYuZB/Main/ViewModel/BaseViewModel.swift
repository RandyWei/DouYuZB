//
//  BaseViewModel.swift
//  DouYuZB
//
//  Created by RandyWei on 2019/9/15.
//  Copyright © 2019 RandyWei. All rights reserved.
//

import UIKit

class BaseViewModel {
    lazy var anchorGroups:[AnchorGroup] = [AnchorGroup]()
    func requestAnchorData(url:String,params:[String:String]? = nil,callback:@escaping ()->())  {
        Network.request(url: url, methodType: MethodType.GET,params: params) { (result) in
            
            //将json转成字典
            guard result is [String: AnyObject] else {return}
            
            //根据获取data数组
            guard let dataArray = result["data"] as? [[String:AnyObject]] else {return}
            
            for dict in dataArray {
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            
            callback()
        }
    }
}
