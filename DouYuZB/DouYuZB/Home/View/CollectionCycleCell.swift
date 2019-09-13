//
//  CollectionCycleCell.swift
//  DouYuZB
//
//  Created by RandyWei on 2019/9/12.
//  Copyright © 2019 RandyWei. All rights reserved.
//

import UIKit

class CollectionCycleCell: UICollectionViewCell {

    
    @IBOutlet weak var image: UIImageView!
    
    var cycleModel:CycleModel?{
        didSet{
            image.kf.setImage(with: URL(string: cycleModel!.pic_url))
        }
    }

}
