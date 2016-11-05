//
//  AmuseViewController.swift
//  douyuTV
//
//  Created by Jefferson on 2016/11/2.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

import UIKit

private let KMenuViewHeight: CGFloat = 200

class AmuseViewController: BaseAnchorViewController {

    fileprivate lazy var amuseViewModel = AmuseViewModel()
    
    fileprivate lazy var menuView: AmuseMenuView = {
        let rect = CGRect(x: 0, y: -KMenuViewHeight, width: KScreenWidth, height: KMenuViewHeight)
        let menuView = AmuseMenuView(frame: rect)
        return menuView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension AmuseViewController {
    
    override func setupUI() {
        super.setupUI()
        
        collectionView.addSubview(menuView)
        collectionView.contentInset = UIEdgeInsets(top: KMenuViewHeight, left: 0, bottom: 0, right: 0)
    }
    
}

// MARK: loadData
extension AmuseViewController {

    override func loadData() {
        //
        baseViewModel = amuseViewModel
        
        amuseViewModel.loadAmuseData {
            self.collectionView.reloadData()
            
            var tempAnchors = self.amuseViewModel.anchorGroups
            tempAnchors.removeFirst()
            // assignment
            self.menuView.anchors = tempAnchors
        }
    }
}


