//
//  RecommendGameView.swift
//  DouYuZB
//
//  Created by RandyWei on 2019/9/13.
//  Copyright © 2019 RandyWei. All rights reserved.
//

import UIKit

private let kGameViewCellID = "kGameViewCellID"

class RecommendGameView: UIView {
    
    var anchorGroups:[AnchorGroup]?{
        didSet{
            anchorGroups?.removeFirst()
            anchorGroups?.removeFirst()
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            anchorGroups?.append(moreGroup)
            collectionView.reloadData()
        }
    }

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = UIView.AutoresizingMask(rawValue: 0)
        
        collectionView.register(UINib(nibName: "CollectionGameViewCell", bundle: nil), forCellWithReuseIdentifier: kGameViewCellID)
    }
    
}

extension RecommendGameView{
    class func recommendGameView() -> RecommendGameView{
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

extension RecommendGameView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return anchorGroups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameViewCellID, for: indexPath) as! CollectionGameViewCell
        cell.anchorGroup = anchorGroups![indexPath.item]
        return cell
    }
}
