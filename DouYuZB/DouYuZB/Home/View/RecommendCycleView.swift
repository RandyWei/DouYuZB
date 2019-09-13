//
//  RecommendCycleView.swift
//  DouYuZB
//
//  Created by RandyWei on 2019/9/12.
//  Copyright © 2019 RandyWei. All rights reserved.
//

import UIKit

private let kCycleCellId = "kCycleCellId"

class RecommendCycleView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    var cycleTimer:Timer?
    var cycleModels:[CycleModel]?{
        didSet{
            collectionView.reloadData()
            pageControl.numberOfPages = cycleModels?.count ?? 0
            
            //设置默认从中间滚动
            let indexPath = IndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
            removeCycleTimer()
            addCycleTimer()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //TODO 这个常量是什么？
        autoresizingMask = UIView.AutoresizingMask(rawValue: 0)
        
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellId)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }
}


extension RecommendCycleView{
    class func recommendCycleView() -> RecommendCycleView{
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}

extension RecommendCycleView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellId, for: indexPath) as! CollectionCycleCell
        
        let cycleModel = cycleModels![indexPath.item % cycleModels!.count]
        cell.cycleModel = cycleModel
        return cell
        
    }
}

extension RecommendCycleView:UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        pageControl.currentPage = Int(offsetX/scrollView.bounds.width) % (cycleModels?.count ?? 1)
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}

extension RecommendCycleView{
    func addCycleTimer() {
        cycleTimer = Timer(timeInterval: 3.0, repeats: true, block: { (t) in
            let currentOffsetX = self.collectionView.contentOffset.x
            let offsetX = currentOffsetX + self.collectionView.bounds.width
            self.collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        })
        RunLoop.main.add(cycleTimer!, forMode: RunLoop.Mode.common)
    }
    
    func removeCycleTimer() {
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
}
