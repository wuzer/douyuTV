//
//  HomeViewController.swift
//  douyuTV
//
//  Created by Jefferson on 2016/10/4.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

import UIKit

private let KTitleHeight: CGFloat = 40
private let reuseIdentifier = "Cell"

class HomeViewController: UIViewController {

    // mark - lazyLoad
    private lazy var pageTitleView: PageTitleView = {
        let frame: CGRect = CGRect(x: 0, y: KNavigationBarHeight + KStatusBarHeight, width: KScreenWidth, height: KTitleHeight)
        let titles: [String] = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = PageTitleView(frame: frame, titles: titles)
//        titleView.backgroundColor = UIColor.red
        return titleView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = ""
        view.backgroundColor = UIColor.white
        
        setupUI()
    }

    func setupUI() {
        
        automaticallyAdjustsScrollViewInsets = false
        
        // 设置导航栏
        setupNavigation()
        
        // 添加titleView
        view.addSubview(pageTitleView)
    }
    
    
    func setupNavigation() {

        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", selectedImageName: "Image_my_history_click", size: size)
        
        let QRCodeItem = UIBarButtonItem(imageName: "Image_scan", selectedImageName: "Image_scan_click", size: size)
        
        let searchItem = UIBarButtonItem(imageName: "btn_search", selectedImageName: "btn_search_clicked", size: size)
        
        
        navigationItem.rightBarButtonItems = [searchItem, QRCodeItem, historyItem]
    }
    
    
}
