//
//  CollectionNormalCell.swift
//  DouYuZB
//
//  Created by RandyWei on 2019/9/7.
//  Copyright © 2019 RandyWei. All rights reserved.
//

import UIKit

class CollectionNormalCell: CollectionViewBaseCell {
    @IBOutlet weak var roomNameLabel: UILabel!
    
   override var anchor:AnchorModel?{
        didSet{
            super.anchor = anchor
            roomNameLabel.text = anchor?.room_name
            onlineButton.isHidden = true
        }
    }

 
}
