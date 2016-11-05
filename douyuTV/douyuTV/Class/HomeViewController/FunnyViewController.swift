//
//  FunnyViewController.swift
//  douyuTV
//
//  Created by Jefferson on 2016/11/5.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

import UIKit

private let KTopMargin: CGFloat = 8

class FunnyViewController: BaseAnchorViewController {

    fileprivate lazy var funnyViewModel: FunnyViewModel = FunnyViewModel()
    
}

extension FunnyViewController {

    override func setupUI() {
        super.setupUI()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsets(top: KTopMargin, left: 0, bottom: 0, right: 0)
    }
}

// MARK: load data
extension FunnyViewController {
    
    override func loadData() {
        
        baseViewModel = funnyViewModel
        
        funnyViewModel.loadFunnyData {
            self.collectionView.reloadData()
            self.showHaveDataView()
        }
    }
}
