//
//  BaseViewController.swift
//  DouYuZB
//
//  Created by RandyWei on 2019/9/15.
//  Copyright © 2019 RandyWei. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var contentView:UIView?
    
    lazy var animateImageView:UIImageView = { [unowned self]in
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        imageView.animationImages = [UIImage(named: "img_loading_1")!,UIImage(named: "img_loading_2")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.center = self.view.center
        imageView.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin]
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}


extension BaseViewController{
    @objc func setupUI() {
        contentView?.isHidden = true
        view.addSubview(animateImageView)
        animateImageView.startAnimating()
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    }
    
    func loadDataFinished()  {
        animateImageView.stopAnimating()
        animateImageView.isHidden = true
        contentView?.isHidden = false
    }
}
