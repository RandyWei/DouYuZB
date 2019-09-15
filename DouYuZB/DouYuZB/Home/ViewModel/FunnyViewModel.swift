//
//  FunnyViewModel.swift
//  DouYuZB
//
//  Created by RandyWei on 2019/9/15.
//  Copyright © 2019 RandyWei. All rights reserved.
//

import UIKit

class FunnyViewModel: BaseViewModel {

}

extension FunnyViewModel{
    func requestFunnyData(callback:@escaping ()->()) {
        requestAnchorData(url: "https://capi.douyucdn.cn/api/v1/getColumnRoom/2", params: ["limit" : "30","offset":"0"],isGroup: false, callback: callback)
    }
}
