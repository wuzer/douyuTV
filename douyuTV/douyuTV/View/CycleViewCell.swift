//
//  CycleViewCell.swift
//  douyuTV
//
//  Created by Jefferson on 2016/10/25.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

import UIKit

class CycleViewCell: UICollectionViewCell {
 
    var slideModel: SlideModel? {
        didSet {
            
            let imageUrl = URL.init(string: (slideModel?.pic_url)!)
            imageView.kf.setImage(with: imageUrl)
            
            titleLabel.text = slideModel?.title
        }
    }
    
    fileprivate lazy var imageView: UIImageView = {
    
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "Img_default")
        
        return imageView
    }()
    
    fileprivate lazy var titleLabel: UILabel = {
    
        let label = UILabel()
        label.text = "jefferson"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14)
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

extension CycleViewCell {
    
    func setupSubviews() {
        addSubview(imageView)
        
        let continerView = UIView()
        continerView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        addSubview(continerView)
        continerView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(30)
        }
        continerView.addSubview(titleLabel)
        
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.right.lessThanOrEqualToSuperview().offset(-15)
        }
    }
    
}

