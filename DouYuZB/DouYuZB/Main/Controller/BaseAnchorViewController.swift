//
//  BaseAnchorViewController.swift
//  DouYuZB
//
//  Created by RandyWei on 2019/9/15.
//  Copyright © 2019 RandyWei. All rights reserved.
//

import UIKit

private let kItemMargin:CGFloat = 10
let kAnchorItemW:CGFloat = (kScreenWidth - 3 * kItemMargin) / 2
let kNormalItemH:CGFloat = kAnchorItemW * 3 / 4
let kPrettyItemH:CGFloat = kAnchorItemW * 4 / 3
private let kHeaderH:CGFloat = 44

let kNormalCellID = "kNormalCellID"
let kPrettyCellID = "kPrettyCellID"
let kHeaderID = "kHeaderID"

class BaseAnchorViewController: UIViewController {
    var baseVm:BaseViewModel!
    lazy var collectionView:UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:kAnchorItemW,height:kNormalItemH)
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
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        return collectionView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    
}

extension BaseAnchorViewController{
    @objc func setupUI(){
        view.addSubview(collectionView)
    }
    @objc func loadData(){}
}

extension BaseAnchorViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.baseVm.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.baseVm.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let group = baseVm.anchorGroups[indexPath.section]
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
        header.group = self.baseVm.anchorGroups[indexPath.section]
        return header
    }
}

