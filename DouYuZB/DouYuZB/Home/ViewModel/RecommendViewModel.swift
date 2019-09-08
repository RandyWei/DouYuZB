//
//  RecommendViewModel.swift
//  DouYuZB
//
//  Created by RandyWei on 2019/9/8.
//  Copyright © 2019 RandyWei. All rights reserved.
//

import UIKit

class RecommendViewModel {
    
}


extension RecommendViewModel{
    func requestData()  {
        Network.request(url: "https://httpbin.org/get", methodType: MethodType.GET) { (result) in
            print("\(result)")
        }
    }
}
