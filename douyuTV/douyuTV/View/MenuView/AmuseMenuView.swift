//
//  AmuseMenuView.swift
//  douyuTV
//
//  Created by Jefferson on 2016/11/3.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

import UIKit
import SnapKit

private let KMenuCellIdentify    = "KMenuCellIdentify"
private let KItemMargin: CGFloat = 10
private let KItemWidth           = (KScreenWidth - 5 * KItemMargin) / 4

class AmuseMenuView: UIView {

    var anchors: [AnchorGroup]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    fileprivate lazy var collectionView: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        let collectionView: UICollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(AmuseMenuViewCell.self, forCellWithReuseIdentifier: KMenuCellIdentify)
        
        return collectionView
    }()
    
    fileprivate lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.currentPageIndicatorTintColor = UIColor.orange
        pageControl.pageIndicatorTintColor = UIColor.darkGray
//        pageControl.backgroundColor = UIColor.purple
        return pageControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }
    
}

extension AmuseMenuView {
    
    func setupSubViews() {
        addSubview(collectionView)
        addSubview(pageControl)
        
        pageControl.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.lessThanOrEqualTo(100)
            make.height.equalTo(20)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(pageControl.snp.top)
        }
    }
}

extension AmuseMenuView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if anchors == nil { return 0 }
        let pageNum = (anchors!.count - 1) / 8 + 1
        pageControl.numberOfPages = pageNum
        
        return pageNum
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KMenuCellIdentify, for: indexPath) as! AmuseMenuViewCell
        getCurrentPageData(cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    private func getCurrentPageData(cell: AmuseMenuViewCell, indexPath: IndexPath) {
        
        // get start and end Index
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        
        // Dealing with transboundary
        if endIndex > anchors!.count - 1 {
            endIndex = anchors!.count - 1
        } 
        
        // assignment
        cell.anchors = Array(anchors![startIndex...endIndex])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
    
}
