//
//  RecommendViewController.swift
//  douyuTV
//
//  Created by Jefferson on 2016/10/21.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

import UIKit

private let KItemMargin : CGFloat = 10
private let KItemWidth  : CGFloat = (KScreenWidth - KItemMargin * 3) / 2
private let KItemHeight : CGFloat = KItemWidth * 3 / 4
private let KHeaderHeight : CGFloat     = 50
private let KNormalCell           = "recommendCell"
private let KHeaderView           = "KHeaderView"

class RecommendViewController: UIViewController {

    fileprivate lazy var collectionView : UICollectionView = { [unowned self] in
    
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: KItemWidth, height: KItemHeight)
        flowLayout.minimumLineSpacing = KItemMargin
        flowLayout.minimumInteritemSpacing = KItemMargin
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: KItemMargin, bottom: 0, right: KItemMargin)
        flowLayout.headerReferenceSize = CGSize(width: KScreenWidth, height: KHeaderHeight)
        
        let collectionView : UICollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.purple
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: KNormalCell)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KHeaderView)
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
extension RecommendViewController : UICollectionViewDataSource {

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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KNormalCell, for: indexPath)
        
        cell.backgroundColor = UIColor.blue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KHeaderView, for: indexPath)
        
        headerView.backgroundColor = UIColor.cyan
        return headerView
    }
    
}



