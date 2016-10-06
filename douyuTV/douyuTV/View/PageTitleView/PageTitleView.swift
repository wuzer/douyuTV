//
//  PageTitleView.swift
//  douyuTV
//
//  Created by Jefferson on 2016/10/6.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

import UIKit

private let KScrollViewLineHeight: CGFloat = 2

class PageTitleView: UIView {

    // title 数组
    var titles: [String]
    lazy var titleLabels: [UILabel] = [UILabel]()
    
    // scrollView
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        
        return scrollView
    }()
    
    lazy var scrollBar: UIView = {
        let scrollBar = UIView()
        scrollBar.backgroundColor = UIColor.orange
        
        return scrollBar
    }()
    
    init(frame: CGRect, titles: [String]) {
        
        self.titles = titles
        
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension PageTitleView {
    
    func setupSubviews() {
        addSubview(scrollView)
        scrollView.frame = bounds
        
        layoutTitleViews()
        layoutBottomBar()
    }
    
    private func layoutTitleViews() {
    
        let labelY: CGFloat = 0
        let labelH: CGFloat = frame.height - KScrollViewLineHeight
        let labelW: CGFloat = frame.width / CGFloat(titles.count)

        for (index, title) in titles.enumerated() {
            print("Item \(index): \(title)")
            // 创建label
            let label = UILabel()
            
            // 设置常用属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
            // 设置frame
            let labelX: CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            // 添加label到scrollview
            scrollView.addSubview(label)
            titleLabels.append(label)
        }
    }
    
    private func layoutBottomBar() {
        
        // 添加底线
        let bottomLine = UIView()
        
        bottomLine.backgroundColor = UIColor.darkGray
        bottomLine.frame = CGRect(x: 0, y: frame.height - kSingleLineHeight, width: frame.width, height: kSingleLineHeight)
        addSubview(bottomLine)
        
        // 添加滑动条
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor.orange
        
        scrollView.addSubview(scrollBar)
        scrollBar.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - KScrollViewLineHeight, width: firstLabel.frame.width, height: KScrollViewLineHeight)
        
    }
}



