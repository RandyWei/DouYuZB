//
//  AnchorGroup.swift
//  DouYuZB
//
//  Created by RandyWei on 2019/9/8.
//  Copyright © 2019 RandyWei. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    @objc var room_list:[[String:NSObject]]?{
        didSet{
            guard let room_list = room_list else {
                return
            }
            for dict in room_list{
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    
    @objc var tag_name:String = ""
    @objc var icon_url:String = "home_header_normal"
    @objc var small_icon_url:String = "home_header_normal"
    
    @objc lazy var anchors:[AnchorModel] = [AnchorModel]()
    
    override init() {
        
    }
    
    init(dict: [String:AnyObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        super.setValue(value, forKey: key)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
