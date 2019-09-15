//
//  GameViewController.swift
//  DouYuZB
//
//  Created by RandyWei on 2019/9/15.
//  Copyright © 2019 RandyWei. All rights reserved.
//

import UIKit

private let kEdgeMargin:CGFloat = 10
private let kItemW:CGFloat = (kScreenWidth - 2 * kEdgeMargin) / 3
private let kItemH:CGFloat = kItemW

private let kGameCellId = "kGameCellId"

class GameViewController: UIViewController {
    
    fileprivate lazy var gameVM:GameViewModel = GameViewModel()

    fileprivate lazy var collectionView:UICollectionView = { [unowned self] in
        //创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.register(UINib(nibName: "CollectionGameViewCell", bundle: nil), forCellWithReuseIdentifier: kGameCellId)
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        loadData()
    }
}

extension GameViewController{
    fileprivate func setupUI(){
        view.addSubview(collectionView)
    }
    
    fileprivate func loadData(){
        self.gameVM.requestData {
            self.collectionView.reloadData()
        }
    }
    
}


extension GameViewController :UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.gameModels.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellId, for: indexPath) as! CollectionGameViewCell
        cell.anchorGroup = gameVM.gameModels[indexPath.item]
        return cell
    }
}
