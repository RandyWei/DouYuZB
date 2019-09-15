//
//  CollectionHeaderView.swift
//  DouYuZB
//
//  Created by RandyWei on 2019/9/7.
//  Copyright © 2019 RandyWei. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionHeaderView: UICollectionReusableView {
    
    
    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    
    var group:AnchorGroup?{
        didSet{
            titleLabel.text = group?.tag_name
            
            let url = group?.small_icon_url ?? "home_header_normal"
            
            if url.hasPrefix("http") {
                iconView.kf.setImage(with: URL(string: url))
            }else{
                iconView.image = UIImage(named: group?.small_icon_url ?? "home_header_normal")
            }
        }
    }
}

extension CollectionHeaderView{
    class func collectionHeaderView() -> CollectionHeaderView {
        return Bundle.main.loadNibNamed("CollectionHeaderView", owner: nil, options: nil)?.first as! CollectionHeaderView
    }
}
