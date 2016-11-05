//
//  AmuseMenuViewCell.swift
//  douyuTV
//
//  Created by Jefferson on 2016/11/5.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

import UIKit

private let KCellReuseIdentify   = "KCellReuseIdentify"

class AmuseMenuViewCell: UICollectionViewCell {
    
    var anchors: [AnchorGroup]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    fileprivate lazy var collectionView: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.itemSize = CGSize(width: self.bounds.width / 4, height: self.bounds.height * 0.5)
        
        let collectionView: UICollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.register(GameViewCell.self, forCellWithReuseIdentifier: KCellReuseIdentify)
        
        return collectionView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension AmuseMenuViewCell {
    
    func setupSubViews() {
    
        addSubview(collectionView)
    }
}

extension AmuseMenuViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return anchors?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KCellReuseIdentify, for: indexPath) as! GameViewCell
//        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.orange
        cell.anchor = anchors![indexPath.item]
        cell.clipsToBounds = true
        return cell
    }
    
}
