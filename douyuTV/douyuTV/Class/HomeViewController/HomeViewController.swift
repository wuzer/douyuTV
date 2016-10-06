//
//  HomeViewController.swift
//  douyuTV
//
//  Created by Jefferson on 2016/10/4.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        title = "首页"
        view.backgroundColor = UIColor.white
        
        setupUI()
    }

    func setupUI() {
        
        setupNavigation()
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
