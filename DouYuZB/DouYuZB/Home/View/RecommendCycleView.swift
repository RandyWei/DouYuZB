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
    
    var cycleModels:[CycleModel]?{
        didSet{
            collectionView.reloadData()
            pageControl.numberOfPages = cycleModels?.count ?? 0
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //TODO 这个常量是什么？
        autoresizingMask = UIView.AutoresizingMask(rawValue: 0)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCycleCellId)
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
        return cycleModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellId, for: indexPath)
        
        let cycleModel = cycleModels![indexPath.item]
        
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.black : UIColor.yellow
        return cell
        
    }
}
