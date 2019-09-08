//
//  RecommendViewModel.swift
//  DouYuZB
//
//  Created by RandyWei on 2019/9/8.
//  Copyright © 2019 RandyWei. All rights reserved.
//

import UIKit

class RecommendViewModel {
    lazy var anchorGroups:[AnchorGroup] = [AnchorGroup]()
    private lazy var bigDataGroup:AnchorGroup = AnchorGroup()
    private lazy var prettyGroup:AnchorGroup = AnchorGroup()
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
        Network.request(url: "https://capi.douyucdn.cn/api/v1/getHotCate", methodType: MethodType.GET,params: ["limit":"4","offset":"0","time": NSDate.currentTime()]) { (result) in
            
            //将json转成字典
            guard result is [String: AnyObject] else {return}
            
            //根据获取data数组
            guard let dataArray = result["data"] as? [[String:AnyObject]] else {return}
            
            for dict in dataArray {
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            
            dGroup.leave()
        }
        
        dGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            callback()
        }
    }
}
