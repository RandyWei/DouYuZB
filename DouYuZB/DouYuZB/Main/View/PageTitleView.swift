//
//  PageTitleView.swift
//  DouYuZB
//
//  Created by RandyWei on 2019/9/7.
//  Copyright © 2019 RandyWei. All rights reserved.
//

import UIKit

private let kScrollLineH:CGFloat = 2

class PageTitleView: UIView {

    private var titles:[String]
    
    private lazy var titlelLabels = [UILabel]()
    
    private lazy var scrollLineView:UIView = {
        let scrollLineView = UIView()
        scrollLineView.backgroundColor = UIColor.orange
        return scrollLineView
    }()
    
    //MARK: 懒加载属性
    private lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        return scrollView
    }()
    
    // MAKR: 自定义构造函数
    init(frame:CGRect,titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension PageTitleView{
    private func setupUI(){
        //添加ScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //添加Title对应的label
        setupTitleLabels()
        
        //设置底线和滚动指示器
        setupScrollLineAndBottomLine()
    }
    
    private func setupTitleLabels(){
        
        let labelW:CGFloat = frame.width / CGFloat(titles.count)
        let labelH:CGFloat = frame.height - kScrollLineH
        let labelY:CGFloat = 0
        
        for (index,title) in titles.enumerated() {
            //创建UILabel
            
            let label = UILabel()
            
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
            //设置frame
            let labelX:CGFloat = labelW * CGFloat(index)
            
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //将label添加到scrollView
            scrollView.addSubview(label)
            titlelLabels.append(label)
        }
    }
    private func setupScrollLineAndBottomLine(){
        //底线
        let bottomLineView = UIView()
        bottomLineView.backgroundColor = UIColor.lightGray
        let lineH:CGFloat = 0.5
        bottomLineView.frame = CGRect(x: 0,y: frame.height - lineH,width: frame.width, height: lineH)
        addSubview(bottomLineView)
        //指示器
        guard let firstLabel = titlelLabels.first else {
            return
        }
        firstLabel.textColor = UIColor.orange
        scrollLineView.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
        scrollView.addSubview(scrollLineView)
    }
}
