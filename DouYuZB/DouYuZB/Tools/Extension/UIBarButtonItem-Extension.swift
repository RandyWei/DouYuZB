//
//  UIBarButtonItem-Extension.swift
//  DouYuZB
//
//  Created by RandyWei on 2019/9/7.
//  Copyright © 2019 RandyWei. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    class func createItem(imageName:String,hightlightImageName:String,size:CGSize) -> UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: hightlightImageName), for: UIControl.State.highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        return UIBarButtonItem(customView: btn)
    }
    
    convenience init(imageName:String,hightlightImageName:String="",size:CGSize=CGSize.zero){
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        if hightlightImageName != "" {
            btn.setImage(UIImage(named: hightlightImageName), for: UIControl.State.highlighted)
        }
        if size != CGSize.zero {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        } else {
            btn.sizeToFit()
        }
        
        self.init(customView:btn)
    }
}
