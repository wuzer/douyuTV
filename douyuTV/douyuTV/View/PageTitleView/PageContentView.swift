//
//  PageContentView.swift
//  douyuTV
//
//  Created by Jefferson on 2016/10/6.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

import UIKit

private let reuseID = "livecell"

// MARK: protocol
protocol PageContentViewDelegate : NSObjectProtocol {
    func pageContentView(contentView : PageContentView, progress : CGFloat, targetIndex : Int, sourceIndex : Int)
}

class PageContentView: UIView {

    fileprivate var childViewContollers : [UIViewController]
    fileprivate weak var parentViewController : UIViewController?
    fileprivate var startOffSetX : CGFloat = 0
    fileprivate var isForbidScrollDelegate : Bool = false
    weak var delegate : PageContentViewDelegate?
    
    // MARK: lazyload
    fileprivate lazy var collectionView : UICollectionView = { [weak self] in
    
        // 创建layout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = (self?.bounds.size)!
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        
        // 创建collectionview
        let collectionView : UICollectionView = UICollectionView(frame: self!.bounds, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
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
            parentViewController?.addChildViewController(childViewController)
        }
    
        // 添加collectionview
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}


// MARK: UICollectionViewDataSource
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

// MARK: UICollectionViewDelegate

extension PageContentView : UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScrollDelegate = false
        
        startOffSetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // judge whether click
        if isForbidScrollDelegate { return }
        
        // define value
        var progress    : CGFloat = 0
        var sourceIndex : Int     = 0
        var targetIndex : Int     = 0
        
        // judge left or right
        let currentOffSetX = scrollView.contentOffset.x
        let scrollViewWidth = scrollView.bounds.width
        
        if currentOffSetX > startOffSetX { // left
//            print("left")
            progress = currentOffSetX / scrollViewWidth - floor(currentOffSetX / scrollViewWidth)
            sourceIndex = Int(currentOffSetX / scrollViewWidth)
            targetIndex = sourceIndex + 1
            if targetIndex >= childViewContollers.count {
                targetIndex = childViewContollers.count - 1
            }
            
            if currentOffSetX - startOffSetX == scrollViewWidth {
                progress = 1
                targetIndex = sourceIndex
            }
            
        } else { // right
//            print("right")
            progress = 1 - (currentOffSetX / scrollViewWidth - floor(currentOffSetX / scrollViewWidth))
            targetIndex = Int(currentOffSetX / scrollViewWidth)
            sourceIndex = targetIndex + 1
            if sourceIndex >= childViewContollers.count {
                sourceIndex = childViewContollers.count - 1
            }
        }
        
//        print("progress:\(progress),targetIndex:\(targetIndex), sourceIndex:\(sourceIndex)")
        delegate?.pageContentView(contentView: self, progress: progress, targetIndex: targetIndex, sourceIndex: sourceIndex)
    }
    
}


extension PageContentView {

    func setcurrentIndex(currentIndex : Int) {
        
        isForbidScrollDelegate = true
        
        let indexPath  = IndexPath(item: currentIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
    }
}


