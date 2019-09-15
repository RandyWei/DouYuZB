//
//  AmuseViewController.swift
//  DouYuZB
//
//  Created by RandyWei on 2019/9/15.
//  Copyright © 2019 RandyWei. All rights reserved.
//

import UIKit



class AmuseViewController: BaseAnchorViewController {
    fileprivate lazy var amuseVM:AmuseViewModel = AmuseViewModel()
}

extension AmuseViewController{
    override func loadData(){
        baseVm = amuseVM
        amuseVM.requestData {
            self.collectionView.reloadData()
        }
    }
}
