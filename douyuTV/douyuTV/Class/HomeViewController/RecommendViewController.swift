//
//  RecommendViewController.swift
//  douyuTV
//
//  Created by Jefferson on 2016/10/21.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

import UIKit

private let KHeaderHeight: CGFloat  = 50
private let KHeaderView             = "KHeaderView"

class RecommendViewController: BaseAnchorViewController {

    fileprivate lazy var cycleView: RecommendCycleView = {
    
        let cycleView = RecommendCycleView(frame: CGRect(x: 0, y: -(KCycleHeight + KGameHeight), width: KScreenWidth, height: KCycleHeight))
        return cycleView
    }()
    
    fileprivate lazy var gameView: RecommendGameView = {
    
        let gameView = RecommendGameView(frame: CGRect(x: 0, y: -KGameHeight, width: KScreenWidth, height: KGameHeight))
        return gameView
    }()
    
    fileprivate lazy var recommendViewModel : RecommendViewModel = RecommendViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

// MARK: layout UI
extension RecommendViewController {
    
    override func setupUI() {
        super.setupUI()
        // add collectionview
        collectionView.addSubview(cycleView)
        collectionView.addSubview(gameView)
    }
}

// MARK: get data
extension RecommendViewController {

    override func loadData() {
      
        baseViewModel = recommendViewModel
        
        recommendViewModel.requestData { 
            
            self.collectionView.reloadData()
            
            var anchors = self.recommendViewModel.anchorGroups
            
            anchors.removeFirst()
            anchors.removeFirst()
            
            let moreAnchor = AnchorGroup()
            moreAnchor.tag_name = "更多"
            anchors.append(moreAnchor)
            
            self.gameView.anchorGroups = anchors
        }
        
        recommendViewModel.requestCycleData {
            self.cycleView.slideModels = self.recommendViewModel.SlideModels
        }
        
    }
}

//// MARK: UICollectionViewDataSource
extension RecommendViewController : UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KPrettyCell, for: indexPath) as! PrettyCollectionCell
            cell.anchor = recommendViewModel.anchorGroups[indexPath.section].room_list[indexPath.item]
            return cell
        } else {
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 1 {
            return CGSize(width: KNormalItemWidth, height: KPrettyItemHeight)
        } else {
            return CGSize(width: KNormalItemWidth, height: KNormalItemHeight)
        }
    }
}



