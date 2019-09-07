//
//  PageTitleView.swift
//  DouYuZB
//
//  Created by RandyWei on 2019/9/7.
//  Copyright © 2019 RandyWei. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate : class {
    func pageTitleView(pageTitleView:PageTitleView,selectedIndex index:Int)
}

private let kScrollLineH:CGFloat = 2
private let kNormalColor:(CGFloat,CGFloat,CGFloat) = (85,85,85)
private let kSelectedColor:(CGFloat,CGFloat,CGFloat)=(255,128,0)

class PageTitleView: UIView {

    private var titles:[String]
    weak var delegate:PageTitleViewDelegate?
    private var currentIndex = 0
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
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            
            //设置frame
            let labelX:CGFloat = labelW * CGFloat(index)
            
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //将label添加到scrollView
            scrollView.addSubview(label)
            titlelLabels.append(label)
            
            //添加手势监听
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.labelTap(ges:)))
            label.addGestureRecognizer(tapGes)
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
        firstLabel.textColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        scrollLineView.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
        scrollView.addSubview(scrollLineView)
    }
}

extension PageTitleView{
    @objc private func labelTap(ges:UITapGestureRecognizer){
        //当前点击的Label
        guard let currentTapLabel = ges.view as? UILabel else {
            return
        }
        //上一个选中的Label
        let lastLabel = titlelLabels[currentIndex]
        
        //设置颜色
        currentTapLabel.textColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        lastLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        currentIndex = currentTapLabel.tag
        
        //滚动条位置发生改变
        let scrollLineX = CGFloat(currentIndex) * scrollLineView.frame.width
        
        UIView.animate(withDuration: TimeInterval(0.15)) {
            self.scrollLineView.frame.origin.x = scrollLineX
        }
        
        //通知代理
        delegate?.pageTitleView(pageTitleView: self, selectedIndex: currentIndex)
        
    }
}

extension PageTitleView{
    func setTitleWithProgress(progress:CGFloat,sourceIndex:Int,targetIndex:Int){
        //取出sourceLabel\targetLabel
        let sourceLabel = titlelLabels[sourceIndex]
        let targetLabel = titlelLabels[targetIndex]
        
        //设置滑块
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLineView.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //设置颜色
        let colorDelta = (kSelectedColor.0 - kNormalColor.0,kSelectedColor.1-kNormalColor.1,kSelectedColor.2-kNormalColor.2)
        sourceLabel.textColor = UIColor(r: kSelectedColor.0 - progress * colorDelta.0, g: kSelectedColor.1 - progress * colorDelta.1, b: kSelectedColor.2 - progress * colorDelta.2)
        
        targetLabel.textColor = UIColor(r: kNormalColor.0 + progress * colorDelta.0, g: kNormalColor.1 + progress * colorDelta.1, b: kNormalColor.2 + progress * colorDelta.2)
        
        //记录最新的index
        currentIndex = targetIndex
    }
}
