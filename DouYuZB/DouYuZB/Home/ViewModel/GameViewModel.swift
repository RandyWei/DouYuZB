//
//  GameViewModel.swift
//  DouYuZB
//
//  Created by RandyWei on 2019/9/15.
//  Copyright © 2019 RandyWei. All rights reserved.
//

import UIKit

class GameViewModel {
    lazy var gameModels:[AnchorGroup] = [AnchorGroup]()
}

extension GameViewModel{
    func requestData(callback:@escaping ()->()){
        Network.request(url: "https://capi.douyucdn.cn/api/v1/getColumnDetail", methodType: MethodType.GET, params: ["short_name" : "game"]) { (result) in
            
            //将json转成字典
            guard result is [String: AnyObject] else {return}
            
            //根据获取data数组
            guard let dataArray = result["data"] as? [[String:AnyObject]] else {return}
            
            for dict in dataArray {
                let group = AnchorGroup(dict: dict)
                self.gameModels.append(group)
            }
            
            callback()
        }
    }
}
