//
//  PageContentView.swift
//  DouYuZB
//
//  Created by RandyWei on 2019/9/7.
//  Copyright © 2019 RandyWei. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class  {
    func pageContentView(pageContentView:PageContentView,progress:CGFloat,sourceIndex:Int,targetIndex:Int)
}

private let ContentCellId = "ContentCellId"

class PageContentView: UIView {
    
    private var childControllers:[UIViewController]
    private weak var parentController:UIViewController?
    weak var delegate: PageContentViewDelegate?
    private var startOffsetX:CGFloat = 0
    
    private var isForbinDelegate = false
    //MARK:懒加载属性
    private lazy var collectionView:UICollectionView = { [weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellId)
        
        return collectionView
    }()
    
    init(frame:CGRect, childControllers:[UIViewController], parentController:UIViewController?) {
        self.childControllers = childControllers
        self.parentController = parentController
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension PageContentView{
    private func setupUI(){
        //将所有子控制器添加到父控制器中
        for vc in childControllers {
            parentController?.addChild(vc)
        }
        
        //添加UICollectionView
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

//MARK:collection view 数据源
extension PageContentView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellId, for: indexPath)
        
        //给cell设置内容
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVc = childControllers[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}

extension PageContentView:UICollectionViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX = scrollView.contentOffset.x
        isForbinDelegate = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isForbinDelegate {return}
        
        //定义需要的数据
        var progress:CGFloat = 0
        var sourceIndex:Int = 0
        var targetIndex:Int = 0
        
        //判断左滑右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        
        if startOffsetX > currentOffsetX { //右滑
            progress = 1 - (currentOffsetX/scrollViewW - floor(currentOffsetX/scrollViewW))
            
            targetIndex = Int(currentOffsetX/scrollViewW)
            sourceIndex = targetIndex + 1
            
            if sourceIndex >= childControllers.count {
                sourceIndex = childControllers.count - 1
            }
        } else { //左滑
            progress = currentOffsetX/scrollViewW - floor(currentOffsetX/scrollViewW)
            sourceIndex = Int(currentOffsetX/scrollViewW)
            targetIndex = sourceIndex + 1
            
            if targetIndex >= childControllers.count {
                targetIndex = childControllers.count - 1
            }
            
            //如果完全滑过去
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        }
        //将progress、sourceIndex、targetIndex传递给PageTitleView
        delegate?.pageContentView(pageContentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}


extension PageContentView{
    func setCurrentIndex(selectedIndex:Int){
        
        isForbinDelegate = true
        
        let offsetX = CGFloat(selectedIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}

