//
//  GameViewCell.swift
//  douyuTV
//
//  Created by Jefferson on 2016/10/25.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

import UIKit

private let KCellHeightAndWidth: CGFloat = 44

class GameViewCell: UICollectionViewCell {
    
    var anchor: AnchorGroup? {
        didSet {
            titleLabel.text = anchor?.tag_name
            
            if anchor?.icon_url == nil {
                imageView.image = UIImage.init(named: "home_more_btn")
            } else {
                let url = URL.init(string: (anchor?.icon_url)!)
                imageView.kf.setImage(with: url)
            }
        }
    }
    
    fileprivate lazy var imageView: UIImageView = {
    
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "live_cell_default_phone")
        imageView.layer.cornerRadius = KCellHeightAndWidth * 0.5
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    fileprivate lazy var titleLabel: UILabel = {
    
        let label = UILabel()
        label.text = "英雄联盟"
        label.font = UIFont.systemFont(ofSize: 11)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MAKR: layout subviews
extension GameViewCell {
    
    func setupSubviews() {
        
        addSubview(imageView)
        addSubview(titleLabel)
        
        imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(KCellHeightAndWidth)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-10)
            make.centerX.equalToSuperview()
            make.height.equalTo(15)
            make.width.lessThanOrEqualToSuperview()
        }
    }
}
