//
//  DYNavigationController.swift
//  douyuTV
//
//  Created by Jefferson on 2016/11/5.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

import UIKit

class DYNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let systemGesture = interactivePopGestureRecognizer else { return }
        
        guard let gestureView = systemGesture.view else { return }
        
        /**
        var count: UInt32 = 0
        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
        for i in 0..<count {
            let ivar = ivars[Int(i)]
            let name = ivar_getName(ivar)
            print(String(cString: name!))
        }
        */
        
        let targets = systemGesture.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else { return }
        
        // get target
        guard let target = targetObjc.value(forKey: "target") else { return }

        // get action
        let action = Selector(("handleNavigationTransition:"))
        
        // set gesture
        let panGesture = UIPanGestureRecognizer(target: target, action: action)
        gestureView.addGestureRecognizer(panGesture)
        
        
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        viewController.hidesBottomBarWhenPushed = true
        
        super.pushViewController(viewController, animated: animated)
    }
    
}
