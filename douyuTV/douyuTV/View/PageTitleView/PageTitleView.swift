//
//  PageTitleView.swift
//  douyuTV
//
//  Created by Jefferson on 2016/10/6.
//  Copyright © 2016年 Jefferson. All rights reserved.
//

import UIKit

private let KScrollViewLineHeight: CGFloat = 2
private let KNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let KSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

protocol PageTitleViewDelegate : NSObjectProtocol {
    func pageTitleView(titleView: PageTitleView, selectedIndex index : Int)
}

class PageTitleView: UIView {

    // title 数组
    fileprivate var currentIndex : Int = 0
    fileprivate var titles: [String]
    fileprivate lazy var titleLabels: [UILabel] = [UILabel]()
    weak var delegate : PageTitleViewDelegate?
    
    // scrollView
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        
        return scrollView
    }()
    
    fileprivate lazy var scrollBar: UIView = {
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
    
    fileprivate func setupSubviews() {
        addSubview(scrollView)
        scrollView.frame = bounds
        
        layoutTitleViews()
        layoutBottomBar()
    }
    
    fileprivate func layoutTitleViews() {
    
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
            
            // label add gesture
            label.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelAction(tap:)))
            label.addGestureRecognizer(tap)
        }
    }
    
    fileprivate func layoutBottomBar() {
        
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

// MARK: label click function
extension PageTitleView {
    
    @objc fileprivate func titleLabelAction(tap : UITapGestureRecognizer) {
        
        // get current label
        guard let currentLabel = tap.view as? UILabel else {  return }
        
        if currentLabel.tag == currentIndex { return }
        
        // get early label
        let earlyLabel = titleLabels[currentIndex]
        
        // change label color
        currentLabel.textColor = UIColor.orange
        earlyLabel.textColor = UIColor.darkGray
        
        // save new label tag
        currentIndex = currentLabel.tag
        
        // change scrollline position
        let scrollLinePosition = CGFloat(currentLabel.tag) * scrollBar.frame.width
        UIView.animate(withDuration: 0.1) {
            self.scrollBar.frame.origin.x = scrollLinePosition
        }
        
        // call notification do something
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
        
    }

}

// MARK:
extension PageTitleView {

    func setTitleWithProgress(progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
        
        // get label
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
//        print(sourceLabel,targetLabel)
        
        // label scroll
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollBar.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        // color change
        let colorDelta = (KSelectColor.0 - KNormalColor.0, KSelectColor.1 - KNormalColor.1, KSelectColor.2 - KNormalColor.2)
        
        sourceLabel.textColor = UIColor(r: KSelectColor.0 - colorDelta.0 * progress, g: KSelectColor.1 - colorDelta.1 * progress, b: KSelectColor.2 - colorDelta.2 * progress)
        
        targetLabel.textColor = UIColor(r: KNormalColor.0 + colorDelta.0 * progress, g: KNormalColor.1 + colorDelta.1 * progress, b: KNormalColor.2 + colorDelta.2 * progress)
        
        // remeber new index
        currentIndex = targetIndex
    }
    
}

