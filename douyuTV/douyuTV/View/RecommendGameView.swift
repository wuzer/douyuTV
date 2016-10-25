//
//  RecommendGameView.swift
//  douyuTV
//
//  Created by Jefferson on 2016/10/25.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

import UIKit

private let KItemEdgeInset: CGFloat = 10
private let KGameCellIdentify = "KGameCellIdentify"

class RecommendGameView: UIView {

    var anchorGroups: [AnchorGroup]? {
        didSet {
            anchorGroups?.removeFirst()
            anchorGroups?.removeFirst()
            
            let anchor = AnchorGroup()
            anchor.tag_name = "更多"
            
            anchorGroups?.append(anchor)
            collectionView.reloadData()
        }
    }
    
    fileprivate lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 80, height: 90)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        
        let collectionView: UICollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.register(GameViewCell.self, forCellWithReuseIdentifier: KGameCellIdentify)
        collectionView.backgroundColor = UIColor.white
        collectionView.contentInset = UIEdgeInsets(top: 0, left: KItemEdgeInset, bottom: 0, right: KItemEdgeInset)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubViews()
        self.backgroundColor = UIColor.orange
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: set UI
extension RecommendGameView {
    
    fileprivate func setupSubViews() {
        
        addSubview(collectionView)
        
    }
}

// MARK: UICollectionViewDataSource
extension RecommendGameView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return anchorGroups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KGameCellIdentify, for: indexPath) as! GameViewCell
//        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.orange : UIColor.red
        
        let anchor = anchorGroups?[indexPath.item]
        cell.anchor = anchor
        return cell
    }
}
