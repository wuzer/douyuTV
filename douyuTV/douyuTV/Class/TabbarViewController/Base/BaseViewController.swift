//
//  BaseViewController.swift
//  douyuTV
//
//  Created by Jefferson on 2016/11/5.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var contentView: UIView?
    
    fileprivate lazy var animationImageView: UIImageView = { [unowned self] in
        let imageView = UIImageView(image: UIImage.init(named: "img_loading_1"))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage.init(named: "img_loading_1")!, UIImage.init(named: "img_loading_2")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension BaseViewController {
    
    func setupUI() {
    
        contentView?.isHidden = true
        
        view.addSubview(animationImageView)
        
        animationImageView.startAnimating()
        
        view.backgroundColor = UIColor.white
    }
    
    func showHaveDataView() {
    
        animationImageView.stopAnimating()
        
        animationImageView.isHidden = true
        
        contentView?.isHidden = false
    }
}
