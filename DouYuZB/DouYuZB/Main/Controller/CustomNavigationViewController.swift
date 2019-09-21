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
        
        guard let systemGes = interactivePopGestureRecognizer else {return}
        
        guard let gesView = systemGes.view else {
            return
        }
        
        let targets = systemGes.value(forKey: "_targets") as! [NSObject]
        
        guard let targetObj = targets.first else {return}
        
        guard let target = targetObj.value(forKey: "target") else {return}
        
        let action = Selector(("handleNavigationTransition:"))
        
        let panGes = UIPanGestureRecognizer()
        panGes.addTarget(target, action: action)
        gesView.addGestureRecognizer(panGes)
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: animated)
    }

}
