//
//  CycleModel.swift
//  DouYuZB
//
//  Created by RandyWei on 2019/9/12.
//  Copyright © 2019 RandyWei. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    @objc var title:String = ""
    @objc var pic_url:String = ""
    @objc var room:[String:AnyObject]?{
        didSet{
            guard let room = room else {
                return
            }
            anchor = AnchorModel(dict: room)
        }
    }
    
    @objc var anchor:AnchorModel?
    
    init(dict:[String:AnyObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        super.setValue(value, forKey: key)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
