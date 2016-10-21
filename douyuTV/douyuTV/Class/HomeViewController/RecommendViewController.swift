//
//  RecommendViewController.swift
//  douyuTV
//
//  Created by Jefferson on 2016/10/21.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

import UIKit

private let KItemMargin : CGFloat   = 10
private let KItemWidth  : CGFloat   = (KScreenWidth - KItemMargin * 3) / 2
private let KNormalItemH : CGFloat  = KItemWidth * 3 / 4
private let KPrettyItemH : CGFloat  = KItemWidth * 4 / 3
private let KHeaderHeight : CGFloat = 50
private let KNormalCell             = "recommendCell"
private let KPrettyCell             = "KPrettyCell"
private let KHeaderView             = "KHeaderView"

class RecommendViewController: UIViewController {

    fileprivate lazy var collectionView : UICollectionView = { [unowned self] in
    
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: KItemWidth, height: KNormalItemH)
        flowLayout.minimumLineSpacing = KItemMargin
        flowLayout.minimumInteritemSpacing = KItemMargin
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: KItemMargin, bottom: 0, right: KItemMargin)
        flowLayout.headerReferenceSize = CGSize(width: KScreenWidth, height: KHeaderHeight)
        
        let collectionView : UICollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(LiveViewCell.self, forCellWithReuseIdentifier: KNormalCell)
        collectionView.register(PrettyCollectionCell.self, forCellWithReuseIdentifier: KPrettyCell)
        collectionView.register(CollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KHeaderView)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.red
        setupUI()
    }

}

extension RecommendViewController {
    
    func setupUI() {
        
        // add collectionview
        view.addSubview(collectionView)
        
    }
}

// MARK: UICollectionViewDataSource
extension RecommendViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 8
        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: UICollectionViewCell!
        
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: KPrettyCell, for: indexPath)
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: KNormalCell, for: indexPath)
        }
        
        cell.backgroundColor = UIColor.white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KHeaderView, for: indexPath)
        
        headerView.backgroundColor = UIColor.white
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



