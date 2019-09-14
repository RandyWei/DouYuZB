//
//  GameModel.swift
//  DouYuZB
//
//  Created by RandyWei on 2019/9/14.
//  Copyright © 2019 RandyWei. All rights reserved.
//

import UIKit

class GameModel: NSObject {
    @objc var title:String = ""
    
    init(dict: [String:AnyObject]){
        super.init()
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
