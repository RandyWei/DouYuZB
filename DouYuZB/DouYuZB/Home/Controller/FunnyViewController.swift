//
//  FunnyViewController.swift
//  DouYuZB
//
//  Created by RandyWei on 2019/9/15.
//  Copyright © 2019 RandyWei. All rights reserved.
//

import UIKit

class FunnyViewController: BaseAnchorViewController {
    
    private lazy var funnyVM:FunnyViewModel=FunnyViewModel()
    
    override func setupUI() {
        super.setupUI()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
    }
    
    override func loadData() {
//        super.loadData()
        baseVm = funnyVM
        funnyVM.requestFunnyData {
            self.collectionView.reloadData()
            self.loadDataFinished()
        }
    }
}
