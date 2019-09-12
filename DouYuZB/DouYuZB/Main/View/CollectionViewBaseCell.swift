//
//  CollectionViewBaseCell.swift
//  DouYuZB
//
//  Created by RandyWei on 2019/9/12.
//  Copyright © 2019 RandyWei. All rights reserved.
//

import UIKit

class CollectionViewBaseCell: UICollectionViewCell {
    @IBOutlet weak var onlineButton: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var coverImage: UIImageView!
    
    
    var anchor:AnchorModel?{
        didSet{
            guard let anchor = anchor else {
                return
            }
            
            nickNameLabel.text = anchor.nickname
            if anchor.online >= 10000 {
                onlineButton.setTitle("\(Int(anchor.online/10000))万人在线", for: .normal)
            } else {
                onlineButton.setTitle("\(anchor.online)人在线", for: .normal)
            }
            
            coverImage.kf.setImage(with: URL(string:anchor.vertical_src))
        }
    }
}
