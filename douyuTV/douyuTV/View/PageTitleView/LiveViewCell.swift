//
//  LiveViewCell.swift
//  douyuTV
//
//  Created by Jefferson on 2016/10/21.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

import UIKit

class LiveViewCell: UICollectionViewCell {
    
    fileprivate lazy var iconView : UIImageView = {
    
        let iconview = UIImageView()
        iconview.image = UIImage.init(named: "home_live_cate_normal")
        return iconview
    }()
    
    fileprivate lazy var titleView : UILabel = {
    
        let titleLabel = UILabel()
        titleLabel.text = "中国女孩成都海选"
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        return titleLabel
    }()
    
    fileprivate lazy var userLabel : UILabel = {
    
        let titleLabel = UILabel()
        titleLabel.text = "jefferson"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        return titleLabel
        
    }()
    
    fileprivate lazy var onlineButton : UIButton = {
        
        let onlineButton = UIButton()
        onlineButton.setTitle("10000人在线", for: .normal)
        onlineButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        onlineButton.titleLabel?.textColor = UIColor.white
        return onlineButton
        
    }()

    fileprivate lazy var liveImage : UIImageView = {
        
        let liveImage = UIImageView()
        liveImage.image = UIImage.init(named: "Img_default")
        liveImage.layer.cornerRadius = 5
        liveImage.layer.masksToBounds = true

        return liveImage
        
    }()

    // model
    var anchor: AnchorModel? {
        didSet {
            
            guard anchor != nil else { return }
            var onlineString: String = ""
            if (anchor?.online)! >= 10000 {
                onlineString = "\(Int((anchor?.online)! / 10000))在线"
            } else {
                onlineString = "\((anchor?.online)!)在线"
            }
            onlineButton.setTitle(onlineString, for: .normal)
            
            // nickname
            userLabel.text = anchor?.nickname
            
            // icon
            guard let iconUrl = URL.init(string: (anchor?.vertical_src)!) else { return }
            liveImage.kf.setImage(with: iconUrl, placeholder: UIImage.init(named: "Img_default"))

            titleView.text = anchor?.room_name
            
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

extension LiveViewCell {
    
    func setupSubviews()  {
        
        addSubview(liveImage)
        addSubview(iconView)
        addSubview(titleView)
        liveImage.addSubview(userLabel)
        liveImage.addSubview(onlineButton)
        
        iconView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.bottom.equalToSuperview().offset(-5)
            make.size.equalTo(CGSize(width: 14, height: 14))
        }
        
        titleView.snp.makeConstraints { (make) in
            make.left.equalTo(iconView.snp.right).offset(5)
            make.centerY.equalTo(iconView.snp.centerY)
            make.height.equalTo(21)
            make.right.equalToSuperview().offset(-10)
        }
        
        liveImage.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(iconView.snp.top).offset(-5)
        }
        
        userLabel.snp.makeConstraints { (make) in
            
            make.left.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-3)
            make.height.equalTo(20)
            make.width.lessThanOrEqualTo(100)
        }
        
        onlineButton.snp.makeConstraints { (make) in
            
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-3)
            make.height.equalTo(20)
            make.width.lessThanOrEqualTo(100)
        }
        
    }
    
}
