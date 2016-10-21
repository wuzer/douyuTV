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
    fileprivate lazy var pageTitleView: PageTitleView = { [weak self] in
        let frame: CGRect = CGRect(x: 0, y: KNavigationBarHeight + KStatusBarHeight, width: KScreenWidth, height: KTitleHeight)
        let titles: [String] = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = PageTitleView(frame: frame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    fileprivate lazy var pageContentView : PageContentView = {
    
        // 确定frame
        let height = KScreenHeigth - kNavigationAndStatusBarHeight - KTitleHeight - kTabBarHeight
        let contentFrame = CGRect(x: 0, y: kNavigationAndStatusBarHeight + KTitleHeight, width: KScreenWidth, height: height)
        
        // 确定子控制器
        var childViewControllers = [UIViewController]()
        childViewControllers.append(RecommendViewController())
        for _ in 0..<3 {
            let viewController = UIViewController()
            viewController.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childViewControllers.append(viewController)
        }
        
        
        let contentView = PageContentView(frame: contentFrame, childViewContollers: childViewControllers, parentViewController: self)
        contentView.delegate = self
        return contentView
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
        
        // 添加Contentview
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.red
        
    }
    
    
    fileprivate func setupNavigation() {

        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", selectedImageName: "Image_my_history_click", size: size)
        
        let QRCodeItem = UIBarButtonItem(imageName: "Image_scan", selectedImageName: "Image_scan_click", size: size)
        
        let searchItem = UIBarButtonItem(imageName: "btn_search", selectedImageName: "btn_search_clicked", size: size)
        
        
        navigationItem.rightBarButtonItems = [searchItem, QRCodeItem, historyItem]
    }
    
    
}

// MARK: PageTitleViewDelegate
extension HomeViewController : PageTitleViewDelegate {
    
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setcurrentIndex(currentIndex: index)
    }

}

// MARK: PageContentViewDelegate
extension HomeViewController : PageContentViewDelegate {
    
    func pageContentView(contentView: PageContentView, progress: CGFloat, targetIndex: Int, sourceIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
}


