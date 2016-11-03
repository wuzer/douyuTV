//
//  AmuseViewController.swift
//  douyuTV
//
//  Created by Jefferson on 2016/11/2.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

import UIKit

private let KItemMargin: CGFloat    = 10
private let KItemWidth: CGFloat     = (KScreenWidth - KItemMargin * 3) / 2
private let KNormalItemH: CGFloat   = KItemWidth * 3 / 4
private let KCellIdentify           = "KCellIdentify"

class AmuseViewController: UIViewController {

    fileprivate lazy var amuseViewModel = AmuseViewModel()
    fileprivate lazy var collectionView: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: KItemWidth, height: KNormalItemH)
        flowLayout.minimumLineSpacing = KItemMargin
        flowLayout.minimumInteritemSpacing = KItemMargin
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: KItemMargin, bottom: 0, right: KItemMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//        collectionView.contentInset = UIEdgeInsetsMake(KCycleHeight + KGameHeight, 0, 0, 0)
        collectionView.dataSource = self
//        collectionView.delegate = self
        collectionView.register(LiveViewCell.self, forCellWithReuseIdentifier: KCellIdentify)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }

}

// MARK: set UI
extension AmuseViewController {
    
    fileprivate func setupUI() {
    
        view.addSubview(collectionView)
    }

}

// MARK: loadData
extension AmuseViewController {

    fileprivate func loadData() {
        amuseViewModel.loadAmuseData { 
         
            self.collectionView.reloadData()
        }
    }
}

extension AmuseViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.amuseViewModel.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return amuseViewModel.anchorGroups[section].room_list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KCellIdentify, for: indexPath) as! LiveViewCell
        let anchorGroup = amuseViewModel.anchorGroups[indexPath.section]
        cell.anchor = anchorGroup.room_list[indexPath.item]
        return cell
    }
    
}

