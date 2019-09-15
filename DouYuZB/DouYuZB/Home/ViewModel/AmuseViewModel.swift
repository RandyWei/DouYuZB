//
//  AmuseViewModel.swift
//  DouYuZB
//
//  Created by RandyWei on 2019/9/15.
//  Copyright © 2019 RandyWei. All rights reserved.
//

import UIKit

class AmuseViewModel {
    lazy var anchorGroups:[AnchorGroup] = [AnchorGroup]()
    func requestData(callback:@escaping ()->())  {
        Network.request(url: "https://capi.douyucdn.cn/api/v1/getHotRoom/2", methodType: MethodType.GET) { (result) in
            
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
