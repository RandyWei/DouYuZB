//
//  CollectionPrettyCell.swift
//  DouYuZB
//
//  Created by RandyWei on 2019/9/7.
//  Copyright © 2019 RandyWei. All rights reserved.
//

import UIKit

class CollectionPrettyCell: CollectionViewBaseCell {
   
    @IBOutlet weak var cityButton: UIButton!
    
   override var anchor:AnchorModel?{
        didSet{
            super.anchor = anchor
            cityButton.setTitle(anchor?.anchor_city, for: UIControl.State.normal)
        }
    }
}
