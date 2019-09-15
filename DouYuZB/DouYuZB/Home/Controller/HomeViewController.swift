//
//  HomeViewController.swift
//  DouYuZB
//
//  Created by RandyWei on 2019/9/7.
//  Copyright © 2019 RandyWei. All rights reserved.
//

import UIKit

private let kPageTitleViewHeight:CGFloat = 40

class HomeViewController: UIViewController {
    
    //MARK: 懒加载属性
    private lazy var pageTitleView:PageTitleView = { [weak self] in
        let frame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenWidth, height: kPageTitleViewHeight)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: frame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    private lazy var pageContentView:PageContentView = { [weak self] in
        let frame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kPageTitleViewHeight, width: kScreenWidth, height: kScreenHeight - (kStatusBarH + kNavigationBarH + kPageTitleViewHeight + kTabbarH))
        
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        childVcs.append(GameViewController())
        for _ in 0..<2{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        
        let pageContentView = PageContentView(frame: frame, childControllers: childVcs, parentController: self)
        pageContentView.delegate = self
        return pageContentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
}

// MARK: - 设置界面
extension HomeViewController{
    private func setupUI(){
        
        
        
        setupNavigation()
        
        //添加TitleView
        view.addSubview(pageTitleView)
        //添加content view
        view.addSubview(pageContentView)
    }
    
    private func setupNavigation(){
        
        //原始方法-----
        //设置左侧logo图片
        /*
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
        */
        
        //扩展类方法
        /*
        let leftBarButtonItem = UIButton()
        leftBarButtonItem.setImage(UIImage(named: "logo"), for: .normal)
        leftBarButtonItem.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarButtonItem)
        
        let size = CGSize(width:40,height:40)
        navigationItem.rightBarButtonItems = [UIBarButtonItem.createItem(imageName: "image_my_history",hightlightImageName: "Image_my_history_click",size: size),UIBarButtonItem.createItem(imageName: "Image_scan",hightlightImageName: "Image_scan_click",size: size),UIBarButtonItem.createItem(imageName: "btn_search",hightlightImageName: "btn_search_clicked",size: size)]
        */
        
        //扩展构造方法
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        let size = CGSize(width:40,height:40)
        navigationItem.rightBarButtonItems = [UIBarButtonItem(imageName: "image_my_history",hightlightImageName: "Image_my_history_click",size: size),UIBarButtonItem(imageName: "Image_scan",hightlightImageName: "Image_scan_click",size: size),UIBarButtonItem(imageName: "btn_search",hightlightImageName: "btn_search_clicked",size: size)]
    }
    
    
}

extension HomeViewController:PageTitleViewDelegate{
    func pageTitleView(pageTitleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(selectedIndex: index)
    }
}

extension HomeViewController:PageContentViewDelegate{
    func pageContentView(pageContentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
