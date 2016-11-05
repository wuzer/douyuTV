//
//  BaseAnchorViewController.swift
//  douyuTV
//
//  Created by Jefferson on 2016/11/3.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

import UIKit

private let KHeaderHeight: CGFloat = 49
private let KItemMargin: CGFloat   = 10
private let KCellIdentify          = "KCellIdentify"
private let KHeaderIdentify        = "KHeaderIdentify"

let KPrettyCell                    = "KPrettyCell"
let KNormalCell                    = "recommendCell"
let KNormalItemWidth: CGFloat      = (KScreenWidth - KItemMargin * 3) / 2
let KNormalItemHeight: CGFloat     = KNormalItemWidth * 3 / 4
let KPrettyItemHeight: CGFloat     = KNormalItemWidth * 4 / 3
let KCycleHeight: CGFloat          = KScreenWidth * 3 / 8
let KGameHeight: CGFloat           = 90

class BaseAnchorViewController: BaseViewController {

    var baseViewModel: BaseViewModel!
    
     lazy var collectionView: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: KNormalItemWidth, height: KNormalItemHeight)
        flowLayout.minimumLineSpacing = KItemMargin
        flowLayout.minimumInteritemSpacing = KItemMargin
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: KItemMargin, bottom: 0, right: KItemMargin)
        flowLayout.headerReferenceSize = CGSize(width: KScreenWidth, height: KHeaderHeight)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.contentInset = UIEdgeInsetsMake(KCycleHeight + KGameHeight, 0, 0, 0)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(LiveViewCell.self, forCellWithReuseIdentifier: KCellIdentify)
        collectionView.register(PrettyCollectionCell.self, forCellWithReuseIdentifier: KPrettyCell)
        collectionView.register(CollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KHeaderIdentify)
        return collectionView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
        // Do any additional setup after loading the view.
    }
}

// MARK: set UI
extension BaseAnchorViewController {
    
    override func setupUI() {
        
        contentView = collectionView
        
        view.addSubview(collectionView)
        
        super.setupUI()
    }
    
}

// MARK: loadData
extension BaseAnchorViewController {
    
    func loadData() {
    
    }
}

extension BaseAnchorViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.baseViewModel.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseViewModel.anchorGroups[section].room_list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KCellIdentify, for: indexPath) as! LiveViewCell
        let anchorGroup = baseViewModel.anchorGroups[indexPath.section]
        cell.anchor = anchorGroup.room_list[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KHeaderIdentify, for: indexPath) as! CollectionHeaderView
        headerView.anchor = baseViewModel.anchorGroups[indexPath.section]
        
        return headerView
    }
    
}

