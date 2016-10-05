//
//  DYTabbarController.swift
//  douyuTV
//
//  Created by Jefferson on 2016/10/4.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

import UIKit

class DYTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        let imageItems = ["btn_home_normal", "btn_column_normal", "btn_live_normal", "btn_user_normal"]
//        let titleItems = ["首页", "直播", "关注", "我的"]

        
        addChildViewController(childController: HomeViewController(), imageName: "btn_home_normal", tiltle: "首页")
        addChildViewController(childController: LiveViewController(), imageName: "btn_column_normal", tiltle: "直播")
        addChildViewController(childController: FollowViewController(), imageName: "btn_live_normal", tiltle: "关注")
        addChildViewController(childController: ProfileViewController(), imageName: "btn_user_normal", tiltle: "我的")
        
    }

    private func addChildViewController(childController: UIViewController, imageName: String, tiltle: String) {
        
        // 设置标题
        childController.title = title
        childController.tabBarItem.title = title
        childController.tabBarItem.selectedImage = UIImage.init(named: imageName + "_highlighted")
        childController.tabBarItem.image = UIImage.init(named: imageName)
        
        // 创建子控制器
        let childNavigation = UINavigationController(rootViewController: childController)
        
        // 添加到tabbarContoller
        addChildViewController(childNavigation)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
