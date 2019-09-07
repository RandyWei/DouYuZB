//
//  File.swift
//  DouYuZB
//
//  Created by RandyWei on 2019/9/7.
//  Copyright © 2019 RandyWei. All rights reserved.
//

import UIKit

let kScreenWidth:CGFloat = UIScreen.main.bounds.width
let kScreenHeight:CGFloat = UIScreen.main.bounds.height


// 刘海屏 宏定义
let iPhoneX = ((kScreenHeight == 812.0) || (kScreenHeight == 896.0) ? true : false)
// 适配刘海屏状态栏高度
let kStatusBarH:CGFloat = iPhoneX ? 44.0 : 20.0
// 适配iPhone X 导航栏高度
let kNavigationBarH:CGFloat = 44.0
let kTabbarH:CGFloat = 44.0
