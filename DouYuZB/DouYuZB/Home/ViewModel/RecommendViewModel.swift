//
//  RecommendViewModel.swift
//  DouYuZB
//
//  Created by RandyWei on 2019/9/8.
//  Copyright © 2019 RandyWei. All rights reserved.
//

import UIKit

class RecommendViewModel:BaseViewModel {
    private lazy var bigDataGroup:AnchorGroup = AnchorGroup()
    private lazy var prettyGroup:AnchorGroup = AnchorGroup()
    lazy var cycleModels:[CycleModel] = [CycleModel]()
    lazy var gameModels:[GameModel] = [GameModel]()
}


extension RecommendViewModel{
    func requestData(callback:@escaping ()->())  {
        
        
        let dGroup = DispatchGroup()
        
        //请求第一部分推荐数据
        dGroup.enter()
        Network.request(url: "https://capi.douyucdn.cn/api/v1/getbigDataRoom", methodType: MethodType.GET,params: ["limit":"4","offset":"0","time": NSDate.currentTime()]) { (result) in
            
            //将json转成字典
            guard result is [String: AnyObject] else {return}
            
            //根据获取data数组
            guard let dataArray = result["data"] as? [[String:AnyObject]] else {return}
            
            
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_url = "home_header_hot"
            self.bigDataGroup.small_icon_url = "home_header_hot"
            
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            dGroup.leave()
        }
        
        //请求推荐颜值数据
        dGroup.enter()
        Network.request(url: "https://capi.douyucdn.cn/api/v1/getVerticalRoom", methodType: MethodType.GET,params: ["limit":"4","offset":"0","time": NSDate.currentTime()]) { (result) in
            
            //将json转成字典
            guard result is [String: AnyObject] else {return}
            
            //根据获取data数组
            guard let dataArray = result["data"] as? [[String:AnyObject]] else {return}
            
            
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_url = "home_header_phone"
            self.prettyGroup.small_icon_url = "home_header_phone"
            
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            dGroup.leave()
        }
        
        //请求推荐游戏数据
        dGroup.enter()
        requestAnchorData(url: "https://capi.douyucdn.cn/api/v1/getHotCate", params: ["limit":"4","offset":"0","time": NSDate.currentTime()]) {
            dGroup.leave()
        }
        
        dGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            callback()
        }
    }
    
    func requestCycleData(callback:@escaping ()->()) {
        Network.request(url: "https://capi.douyucdn.cn/api/v1/slide/6", methodType: MethodType.GET, params:["version":"2.300"]) { (result) in
            //将json转成字典
            guard result is [String: AnyObject] else {return}
            
            //根据获取data数组
            guard let dataArray = result["data"] as? [[String:AnyObject]] else {return}
            
            for dict in dataArray {
                let cycleModel = CycleModel(dict: dict)
                self.cycleModels.append(cycleModel)
            }
            callback()
        }
        
    }
    
    
}
