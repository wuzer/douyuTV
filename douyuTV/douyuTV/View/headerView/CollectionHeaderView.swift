//
//  CollectionHeaderView.swift
//  douyuTV
//
//  Created by Jefferson on 2016/10/21.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

import UIKit
import SnapKit

class CollectionHeaderView: UICollectionReusableView {
    
    lazy var iconView : UIImageView = {
    
        let iconView = UIImageView()
        iconView.image = UIImage.init(named: "home_header_hot")
        
        return iconView
    }()
    
    lazy var titleView : UILabel = {
    
        let label = UILabel()
        label.textColor = UIColor.darkText
        label.text = "最热"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    lazy var moreButton : UIButton = {
    
        let button = UIButton()
        
        button.set(image: UIImage.init(named: "homeMoreIcon"), title: "更多", titlePosition: .left, additionalSpacing: 10, state: .normal)
        button.setTitleColor(UIColor.darkText, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    var anchor: AnchorGroup? {
        didSet {
            titleView.text = anchor?.tag_name
            iconView.image = UIImage.init(named: (anchor?.icon_name)!)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension CollectionHeaderView {
    
    func setupSubviews() {
        
        // add separate
        let separateView = UIView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: 10))
        separateView.backgroundColor = UIColor(r: 234.0, g: 234.0, b: 234.0)
        
        addSubview(separateView)
        addSubview(iconView)
        addSubview(titleView)
        addSubview(moreButton)
        
        iconView.snp.makeConstraints { (make) in
            make.top.equalTo(separateView.snp.bottom).offset(10)
            make.left.equalTo(separateView.snp.left).offset(10)
            make.height.equalTo(20)
            make.width.lessThanOrEqualTo(self)
        }
        
        titleView.snp.makeConstraints { (make) in
//            make.top.equalTo(separateView.snp.bottom).offset(10)
            make.centerY.equalTo(iconView.snp.centerY)
            make.left.equalTo(iconView.snp.right).offset(5)
            make.size.equalTo(CGSize(width: 100, height: 20))
        }
        
        moreButton.snp.makeConstraints { (make) in
            make.top.equalTo(separateView.snp.bottom).offset(10)
            make.right.equalTo(separateView.snp.right).offset(-10)
            make.size.equalTo(CGSize(width: 80, height: 20))
        }

    }
}
