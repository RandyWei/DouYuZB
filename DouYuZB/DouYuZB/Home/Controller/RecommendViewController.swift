//
//  RecommendViewController.swift
//  DouYuZB
//
//  Created by RandyWei on 2019/9/7.
//  Copyright © 2019 RandyWei. All rights reserved.
//

import UIKit

private let kItemMargin:CGFloat = 10
private let kItemW:CGFloat = (kScreenWidth-3*kItemMargin)/2
private let kNormalItemH:CGFloat = kItemW * 3 / 4
private let kPrettyItemH:CGFloat = kItemW * 4 / 3
private let kHeaderH:CGFloat = 44
private let kCycleViewH = kScreenWidth * 3 / 8
private let kRGameViewH:CGFloat = 90

private let kNormalCellID = "kNormalCellID"
private let kPrettyCellID = "kPrettyCellID"
private let kHeaderID = "kHeaderID"

class RecommendViewController: UIViewController {
    
    private lazy var collectionView:UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width:kItemW,height:kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenWidth, height: kHeaderH)
        //设置collection view的边距
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds,collectionViewLayout:layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderID)
        collectionView.backgroundColor = UIColor.white
        return collectionView
        }()
    private lazy var recommendCycleView:RecommendCycleView = {
        let recommendCycleView = RecommendCycleView.recommendCycleView()
        recommendCycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kRGameViewH), width: kScreenWidth, height: kCycleViewH)
        return recommendCycleView
    }()
    private lazy var recommendGameView:RecommendGameView = {
        let recommendGameView = RecommendGameView.recommendGameView()
        recommendGameView.frame = CGRect(x: 0, y: -kRGameViewH, width: kScreenWidth, height: kRGameViewH)
        return recommendGameView
    }()
    private lazy var recommendVM:RecommendViewModel = RecommendViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        
        loadData()
    }
    
}

extension RecommendViewController{
    func setupUI(){
        view.addSubview(collectionView)
        
        collectionView.addSubview(recommendCycleView)
        
        collectionView.addSubview(recommendGameView)
        //设置collection view的内边距，以达到默认显示顶部view
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kRGameViewH, left: 0, bottom: 0, right: 0)
    }
}

extension RecommendViewController{
    func loadData(){
        recommendVM.requestData {
            self.collectionView.reloadData()
            self.recommendGameView.anchorGroups = self.recommendVM.anchorGroups
        }
        recommendVM.requestCycleData {
            self.recommendCycleView.cycleModels = self.recommendVM.cycleModels
        }
        
    }
}

extension RecommendViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendVM.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let group = recommendVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        var cell:CollectionViewBaseCell!
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        }
        cell.anchor = anchor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderID, for: indexPath) as! CollectionHeaderView
        
        header.group = recommendVM.anchorGroups[indexPath.section]
        
        return header
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width:kItemW,height:kPrettyItemH)
        }
        return CGSize(width:kItemW,height:kNormalItemH)
    }
    
}
