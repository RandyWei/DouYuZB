//
//  RecommendViewController.swift
//  DouYuZB
//
//  Created by RandyWei on 2019/9/7.
//  Copyright © 2019 RandyWei. All rights reserved.
//

import UIKit


private let kCycleViewH = kScreenWidth * 3 / 8
private let kRGameViewH:CGFloat = 90

class RecommendViewController: BaseAnchorViewController {
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
    
}

extension RecommendViewController{
    override func setupUI(){
        super.setupUI()
        
        collectionView.addSubview(recommendCycleView)
        
        collectionView.addSubview(recommendGameView)
        //设置collection view的内边距，以达到默认显示顶部view
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kRGameViewH, left: 0, bottom: 0, right: 0)
    }
}

extension RecommendViewController{
    override func loadData(){
        baseVm = recommendVM
        recommendVM.requestData {
            self.collectionView.reloadData()
            
            var groups = self.recommendVM.anchorGroups
            groups.removeFirst()
            groups.removeFirst()
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            self.recommendGameView.anchorGroups = groups
        }
        recommendVM.requestCycleData {
            self.recommendCycleView.cycleModels = self.recommendVM.cycleModels
        }
        
    }
}

extension RecommendViewController:UICollectionViewDelegateFlowLayout{
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let group = recommendVM.anchorGroups[indexPath.section]
            let anchor = group.anchors[indexPath.item]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
            cell.anchor = anchor
            return cell
        } else {
           return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width:kAnchorItemW,height:kPrettyItemH)
        }
        return CGSize(width:kAnchorItemW,height:kNormalItemH)
    }
    
}
