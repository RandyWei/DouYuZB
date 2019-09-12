//
//  AnchorModel.swift
//  DouYuZB
//
//  Created by RandyWei on 2019/9/8.
//  Copyright © 2019 RandyWei. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    @objc var room_id:Int = 0
    @objc var vertical_src:String = ""
    @objc var isVertical:Int =  0
    @objc var room_name:String = ""
    @objc var nickname:String = ""
    @objc var online:Int = 0
    @objc var anchor_city = ""
    
    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
