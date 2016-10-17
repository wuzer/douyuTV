//
//  PageContentView.swift
//  douyuTV
//
//  Created by Jefferson on 2016/10/6.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

import UIKit

private let reuseID = "livecell"


class PageContentView: UIView {

    fileprivate var childViewContollers : [UIViewController]
    fileprivate var parentViewController : UIViewController
    
    // MARK: lazyload
    fileprivate lazy var collectionView : UICollectionView = {
    
        // 创建layout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = self.bounds.size
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        
        // 创建collectionview
        let collectionView : UICollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseID)
        
        return collectionView
    }()

    init(frame: CGRect, childViewContollers: [UIViewController], parentViewController: UIViewController) {
        
        self.childViewContollers = childViewContollers
        self.parentViewController = parentViewController
        
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}


extension PageContentView {

    fileprivate func setupSubviews() {
        
        // 添加所有子控制器
        for childViewController in childViewContollers {
            parentViewController.addChildViewController(childViewController)
        }
    
        // 添加collectionview
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}


// MARK: 遵守协议
extension PageContentView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return childViewContollers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        // 创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseID, for: indexPath)
        
        // 设置cell
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childViewController = childViewContollers[indexPath.item]
        childViewController.view.frame = cell.contentView.frame
        cell.addSubview(childViewController.view)
        
        return cell
    }
    
}




