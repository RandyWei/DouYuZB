//
//  CustomNavigationViewController.swift
//  DouYuZB
//
//  Created by Wei on 2019/9/20.
//  Copyright © 2019 RandyWei. All rights reserved.
//

import UIKit

class CustomNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: animated)
    }

}
