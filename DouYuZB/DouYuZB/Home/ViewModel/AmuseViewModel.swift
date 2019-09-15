//
//  AmuseViewModel.swift
//  DouYuZB
//
//  Created by RandyWei on 2019/9/15.
//  Copyright © 2019 RandyWei. All rights reserved.
//

import UIKit

class AmuseViewModel:BaseViewModel {
    func requestData(callback:@escaping ()->())  {
        requestAnchorData(url: "https://capi.douyucdn.cn/api/v1/getHotRoom/2",callback: callback)
    }
}
