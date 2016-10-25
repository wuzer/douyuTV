//
//  RecommendViewController.swift
//  douyuTV
//
//  Created by Jefferson on 2016/10/21.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

import UIKit

private let KItemMargin: CGFloat    = 10
private let KItemWidth: CGFloat     = (KScreenWidth - KItemMargin * 3) / 2
private let KNormalItemH: CGFloat   = KItemWidth * 3 / 4
private let KPrettyItemH: CGFloat   = KItemWidth * 4 / 3
private let KHeaderHeight: CGFloat  = 50
private let KCycleHeight: CGFloat   = KScreenWidth * 3 / 8
private let KNormalCell             = "recommendCell"
private let KPrettyCell             = "KPrettyCell"
private let KHeaderView             = "KHeaderView"

class RecommendViewController: UIViewController {

    fileprivate lazy var cycleView: RecommendCycleView = {
    
        let cycleView = RecommendCycleView(frame: CGRect(x: 0, y: -KCycleHeight, width: KScreenWidth, height: KCycleHeight))
        return cycleView
    }()
    
    
    fileprivate lazy var collectionView : UICollectionView = { [unowned self] in
    
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: KItemWidth, height: KNormalItemH)
        flowLayout.minimumLineSpacing = KItemMargin
        flowLayout.minimumInteritemSpacing = KItemMargin
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: KItemMargin, bottom: 0, right: KItemMargin)
        flowLayout.headerReferenceSize = CGSize(width: KScreenWidth, height: KHeaderHeight)
        
        let collectionView : UICollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.contentInset = UIEdgeInsetsMake(KCycleHeight, 0, 0, 0)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(LiveViewCell.self, forCellWithReuseIdentifier: KNormalCell)
        collectionView.register(PrettyCollectionCell.self, forCellWithReuseIdentifier: KPrettyCell)
        collectionView.register(CollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KHeaderView)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        return collectionView
    }()
    
    fileprivate lazy var recommendViewModel : RecommendViewModel = RecommendViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.red
        setupUI()
        loadData()
    }

}

// MARK: layout UI
extension RecommendViewController {
    
    func setupUI() {
        
        // add collectionview
        view.addSubview(collectionView)
        collectionView.addSubview(cycleView)
        cycleView.backgroundColor = UIColor.purple
    }
}

// MARK: get data
extension RecommendViewController {

    func loadData() {
     
        recommendViewModel.requestData { 
            
            self.collectionView.reloadData()
        }
        
        recommendViewModel.requestCycleData {
            self.cycleView.slideModels = self.recommendViewModel.SlideModels
        }
        
    }
}


// MARK: UICollectionViewDataSource
extension RecommendViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendViewModel.AnchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let group = recommendViewModel.AnchorGroups[section]
        return group.room_list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get model
        let group = recommendViewModel.AnchorGroups[indexPath.section]
        let anchor = group.room_list[indexPath.item]
        
        // creat cell
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KPrettyCell, for: indexPath) as! PrettyCollectionCell
            cell.anchor = anchor
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KNormalCell, for: indexPath) as! LiveViewCell
             cell.anchor = anchor
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView: CollectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KHeaderView, for: indexPath) as! CollectionHeaderView
        headerView.backgroundColor = UIColor.white
        let anchor = recommendViewModel.AnchorGroups[indexPath.section]
        headerView.anchor = anchor
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 1 {
            return CGSize(width: KItemWidth, height: KPrettyItemH)
        } else {
            return CGSize(width: KItemWidth, height: KNormalItemH)
        }
    }
    
}



