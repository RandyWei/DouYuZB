//
//  HomeViewController.swift
//  DouYuZB
//
//  Created by RandyWei on 2019/9/7.
//  Copyright © 2019 RandyWei. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
}

// MARK: - 设置界面
extension HomeViewController{
    private func setupUI(){
        setupNavigation()
    }
    
    private func setupNavigation(){
        
        //原始方法-----
        //设置左侧logo图片
        let leftBarButtonItem = UIButton()
        leftBarButtonItem.setImage(UIImage(named: "logo"), for: .normal)
        leftBarButtonItem.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarButtonItem)
        
        //设置右侧图标组
        let size = CGSize(width:40,height:40)
        let searchBtn = UIButton()
        searchBtn.setImage(UIImage(named: "btn_search"), for: .normal)
        searchBtn.setImage(UIImage(named: "btn_search_clicked"), for: UIControl.State.highlighted)
        searchBtn.frame = CGRect(origin: CGPoint.zero, size: size)
        
        let qrcodeBtn = UIButton()
        qrcodeBtn.setImage(UIImage(named: "Image_scan"), for: .normal)
        qrcodeBtn.setImage(UIImage(named: "Image_scan_click"), for: UIControl.State.highlighted)
        qrcodeBtn.frame = CGRect(origin: CGPoint.zero, size: size)
        
        let historyBtn = UIButton()
        historyBtn.setImage(UIImage(named: "image_my_history"), for: .normal)
        historyBtn.setImage(UIImage(named: "Image_my_history_click"), for: UIControl.State.highlighted)
        searchBtn.frame = CGRect(origin: CGPoint.zero, size: size)
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: historyBtn),UIBarButtonItem(customView: qrcodeBtn),UIBarButtonItem(customView: searchBtn)]
        
        
    }
}
