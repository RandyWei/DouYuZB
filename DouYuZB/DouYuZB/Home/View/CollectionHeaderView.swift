//
//  CollectionHeaderView.swift
//  DouYuZB
//
//  Created by RandyWei on 2019/9/7.
//  Copyright © 2019 RandyWei. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    
    
    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var group:AnchorGroup?{
        didSet{
            titleLabel.text = group?.tag_name
            
            let url = group?.small_icon_url ?? "home_header_normal"
            
            if url.hasPrefix("http") {
                iconView.image = UIImage(data: try! Data(contentsOf: URL(string: url)!))
            }else{
                iconView.image = UIImage(named: group?.small_icon_url ?? "home_header_normal")
            }
        }
    }
}
