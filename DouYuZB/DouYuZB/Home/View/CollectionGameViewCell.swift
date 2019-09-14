//
//  CollectionGameViewCell.swift
//  DouYuZB
//
//  Created by RandyWei on 2019/9/14.
//  Copyright © 2019 RandyWei. All rights reserved.
//

import UIKit

class CollectionGameViewCell: UICollectionViewCell {

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    
    var anchorGroup:AnchorGroup?{
        didSet{
            guard let anchorGroup = anchorGroup else {
                return
            }
            titleLable.text = anchorGroup.tag_name
            iconView.kf.setImage(with: URL(string: anchorGroup.icon_url),placeholder: UIImage(named: "home_more_btn"))
        }
    }
    
}
