//
//  RecommendCycleView.swift
//  douyuTV
//
//  Created by Jefferson on 2016/10/25.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

import UIKit

let KCycleCellIdentify = "KCycleCellIdentify"

class RecommendCycleView: UIView {

    var slideModels: [SlideModel]? {
        didSet {
            collectionView.reloadData()
            
            pageControl.numberOfPages = slideModels?.count ?? 0
        }
    }
    
    fileprivate lazy var collectionView: UICollectionView = {
    
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        let collectionView: UICollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CycleViewCell.self, forCellWithReuseIdentifier: KCycleCellIdentify)
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    fileprivate lazy var pageControl: UIPageControl = {
    
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.orange
        pageControl.tintColor = UIColor.darkGray
        pageControl.numberOfPages = 3
        return pageControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        autoresizingMask = []
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = collectionView.bounds.size
    }
    
}

extension RecommendCycleView {
    
    func setupSubviews() {
     
        addSubview(collectionView)
        addSubview(pageControl)
        
        collectionView.snp.makeConstraints { (make) in
//            make.top.left.right.equalToSuperview()
            make.edges.equalToSuperview()
        }
        
        pageControl.snp.makeConstraints { (make) in
            make.bottom.right.equalToSuperview().offset(-5)
            make.height.equalTo(20)
            make.width.lessThanOrEqualTo(100)
        }
        
    }
}

extension RecommendCycleView : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slideModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KCycleCellIdentify, for: indexPath) as! CycleViewCell
        
        let slidemodel = slideModels?[indexPath.item]
        cell.slideModel = slidemodel
        
        return cell
    }
 
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        pageControl.currentPage = Int(offset / scrollView.bounds.width)
    }
}
