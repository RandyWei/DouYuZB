//
//  AmuseViewController.swift
//  DouYuZB
//
//  Created by RandyWei on 2019/9/15.
//  Copyright © 2019 RandyWei. All rights reserved.
//

import UIKit

private let kMenuViewH:CGFloat = 200

class AmuseViewController: BaseAnchorViewController {
    fileprivate lazy var amuseVM:AmuseViewModel = AmuseViewModel()
    fileprivate lazy var amuseMenuView:AmuseMenuView = {
        let amuseMenuView = AmuseMenuView.amuseMenuView()
        amuseMenuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenWidth, height: kMenuViewH)
        return amuseMenuView
    }()
}

extension AmuseViewController{
    override func setupUI() {
        super.setupUI()
        
        collectionView.addSubview(amuseMenuView)
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
    }
    override func loadData(){
        baseVm = amuseVM
        amuseVM.requestData {
            self.collectionView.reloadData()
        }
    }
    
}
