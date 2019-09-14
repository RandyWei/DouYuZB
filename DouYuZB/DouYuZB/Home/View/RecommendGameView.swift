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

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = UIView.AutoresizingMask(rawValue: 0)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kGameViewCellID)
    }
    
}

extension RecommendGameView{
    class func recommendGameView() -> RecommendGameView{
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

extension RecommendGameView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameViewCellID, for: indexPath)
        cell.backgroundColor = indexPath.item%2==0 ? UIColor.red : UIColor.blue
        return cell
    }
}
