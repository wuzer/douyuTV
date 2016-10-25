//
//  PrettyCollectionCell.swift
//  douyuTV
//
//  Created by Jefferson on 2016/10/21.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class PrettyCollectionCell: UICollectionViewCell {
    
    fileprivate lazy var locationButton: UIButton = {
    
        let button = UIButton()
        button.setImage(UIImage.init(named: "ico_location"), for: .normal)
        button.setTitle("杭州市", for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        return button
    }()
    
    fileprivate lazy var nameLabel: UILabel = {
    
        let label = UILabel()
        label.text = "邓紫祺"
        label.textColor = UIColor.darkText
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    fileprivate lazy var prettyView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "live_cell_default_phone")
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    fileprivate lazy var onlineButton: UIButton = {
        let button = UIButton()
        button.setTitle("9999在线", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button.titleLabel?.backgroundColor =  UIColor.darkText.withAlphaComponent(0.5)
        button.setTitleColor( UIColor.white, for: .normal)
        return button
    }()
    
    var anchor: AnchorModel? {
        didSet {
            guard anchor != nil else { return }
            
            // online
            var onlineString: String = ""
            if (anchor?.online)! >= 10000 {
                onlineString = "\(Int((anchor?.online)! / 10000))在线"
            } else {
                onlineString = "\((anchor?.online)!)在线"
            }
            onlineButton.setTitle(onlineString, for: .normal)
            
            // nickname
            nameLabel.text = anchor?.nickname
            
            // loction
            locationButton.setTitle(anchor?.anchor_city, for: .normal)
            
            // icon
            guard let iconUrl = URL.init(string: (anchor?.vertical_src)!) else { return }
            prettyView.kf.setImage(with: iconUrl)
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

extension PrettyCollectionCell {
    
    func setupSubviews() {
    
        addSubview(locationButton)
        addSubview(nameLabel)
        addSubview(prettyView)
        prettyView.addSubview(onlineButton)
        
        locationButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-5)
            make.left.equalToSuperview()
            make.height.equalTo(14)
            make.width.lessThanOrEqualTo(100)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.bottom.equalTo(locationButton.snp.top).offset(-5)
            make.height.equalTo(14)
            make.width.lessThanOrEqualTo(100)
        }
        
        prettyView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(nameLabel.snp.top).offset(-5)
//            make.height.equalTo(self.bounds.height * 3 / 4)
        }
        
        onlineButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.height.equalTo(14)
            make.width.lessThanOrEqualTo(100)
        }
        
    }

}
