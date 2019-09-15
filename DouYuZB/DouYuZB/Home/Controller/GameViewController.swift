//
//  GameViewController.swift
//  DouYuZB
//
//  Created by RandyWei on 2019/9/15.
//  Copyright © 2019 RandyWei. All rights reserved.
//

import UIKit

private let kEdgeMargin:CGFloat = 10
private let kGameItemW:CGFloat = (kScreenWidth - 2 * kEdgeMargin) / 3
private let kGameItemH:CGFloat = kGameItemW
private let kHeaderH:CGFloat = 50
private let kNormalGameViewH:CGFloat = 90
private let kGameCellId = "kGameCellId"
private let kHeaderId = "kHeaderId"

class GameViewController: UIViewController {
    
    fileprivate lazy var gameVM:GameViewModel = GameViewModel()
    
    fileprivate lazy var topHeaderView:CollectionHeaderView = {
        let collectionHeaderView = CollectionHeaderView.collectionHeaderView()
        collectionHeaderView.frame = CGRect(x: 0, y: -(kHeaderH + kNormalGameViewH), width: kScreenWidth, height: kHeaderH)
        collectionHeaderView.moreButton.isHidden = true
        collectionHeaderView.titleLabel.text = "常用"
        collectionHeaderView.iconView.image = UIImage(named: "Img_orange")
        return collectionHeaderView
    }()
    
    fileprivate lazy var topGameView:RecommendGameView = {
        let topGameView = RecommendGameView.recommendGameView()
        topGameView.frame = CGRect(x: 0, y: -kNormalGameViewH, width: kScreenWidth, height: kNormalGameViewH)
        
        return topGameView
    }()

    fileprivate lazy var collectionView:UICollectionView = { [unowned self] in
        //创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kGameItemW, height: kGameItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        
        layout.headerReferenceSize = CGSize(width: kScreenWidth, height: kHeaderH)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.register(UINib(nibName: "CollectionGameViewCell", bundle: nil), forCellWithReuseIdentifier: kGameCellId)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderId)
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
        collectionView.addSubview(topHeaderView)
        collectionView.addSubview(topGameView)
        collectionView.contentInset = UIEdgeInsets(top: kHeaderH + kNormalGameViewH, left: 0, bottom: 0, right: 0)
    }
    
    fileprivate func loadData(){
        self.gameVM.requestData {
            self.collectionView.reloadData()
            self.topGameView.anchorGroups = Array(self.gameVM.gameModels.prefix(10))
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderId, for: indexPath) as! CollectionHeaderView
        header.titleLabel.text = "全部"
        header.iconView.image = UIImage(named: "Img_orange")
        header.moreButton.isHidden = true
        return header
    }
}
