//
//  GameViewController.swift
//  douyuTV
//
//  Created by Jefferson on 2016/10/25.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

import UIKit

private let KItemMargin: CGFloat   = 10
private let KItemWidth: CGFloat    = (KScreenWidth - 2 * KItemMargin) / 3
private let KItemHeight: CGFloat   = KItemWidth * 6 / 5
private let KHeaderHeight: CGFloat = 49
private let KGameViewH: CGFloat   = 90
private let KGameCellIdentify      = "KGameCellIdentify"
private let KHeaderIdentify        = "KHeaderIdentify"

class GameViewController: UIViewController {

    // MARK: lazy load
    fileprivate lazy var gameViewModel: GameViewModel = GameViewModel()
    
    fileprivate lazy var collectionView: UICollectionView = {[weak self] in
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: KItemWidth, height: KItemHeight)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: KItemMargin, bottom: 0, right: KItemMargin)
        flowLayout.headerReferenceSize = CGSize(width: KScreenWidth, height: KHeaderHeight)
        
        let collectionView: UICollectionView = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(GameViewCell.self, forCellWithReuseIdentifier: KGameCellIdentify)
        collectionView.register(CollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KHeaderIdentify)
        return collectionView
    }()
    
    fileprivate lazy var topHeaderView: CollectionHeaderView = {
    
        let rect = CGRect(x: 0, y: -(KHeaderHeight + KGameViewH), width: KScreenWidth, height: KHeaderHeight)
        let headerView = CollectionHeaderView(frame: rect)
        headerView.iconView.image = UIImage.init(named: "Img_orange")
        headerView.titleView.text = "常见"
        headerView.moreButton.isHidden = true
        return headerView
    }()
    
    fileprivate lazy var gameView: RecommendGameView = {
    
        let rect = CGRect(x: 0, y: -KGameViewH, width: KScreenWidth, height: KGameViewH)
        let gameView = RecommendGameView(frame: rect)
        return gameView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubViews()
        loadData()

    }

}

// MARK: set UI
extension GameViewController {
    
    func setupSubViews() {
    
        view.addSubview(collectionView)
        collectionView.addSubview(topHeaderView)
        collectionView.addSubview(gameView)
        collectionView.contentInset = UIEdgeInsetsMake(KHeaderHeight + KGameHeight, 0, 0, 0)
    }
    
}

// MARK: get data
extension GameViewController {
    
    func loadData() {
    
        gameViewModel.loadGameData {
            self.collectionView.reloadData()
            
//            var tempArray = [BaseModel]()
//            for i in 0..<10 {
//                tempArray.append(self.gameViewModel.gameModels[i])
//            }

            self.gameView.anchorGroups = Array(self.gameViewModel.gameModels[0..<10])
        }
    }
}

// MARK: set UI
extension GameViewController : UICollectionViewDataSource{
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameViewModel.gameModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KGameCellIdentify, for: indexPath) as! GameViewCell
//        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.orange : UIColor.red
        let gameModel = gameViewModel.gameModels[indexPath.item]
        cell.anchor = gameModel
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KHeaderIdentify, for: indexPath) as! CollectionHeaderView
        headerView.titleView.text = "全部"
        headerView.iconView.image = UIImage.init(named: "Img_orange")
        headerView.moreButton.isHidden = true
        return headerView
    }
    
}

