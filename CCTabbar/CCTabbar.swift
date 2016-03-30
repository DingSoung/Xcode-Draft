//
//  CCTabbar.swift
//  DEMO
//
//  Created by Alex D. on 3/25/16.
//  Copyright © 2016 ifnil. All rights reserved.
//

import UIKit

@objc public protocol CCTabbarDelegate {
    optional func tabbar(tabbar: CCTabbar, didSelectAtIndex index: Int)
}

@IBDesignable public class CCTabbar: UIView {
    
    public var delegate:CCTabbarDelegate?
    
    public var models:[UIButton] = [] {
        willSet {
            for model in self.models {
                model.removeFromSuperview()
            }
            self.models.removeAll()
        }
        didSet {
            for index in (0..<self.models.count)  {
                self.models[index].addTarget(self, action: #selector(self.setObjectAtButton), forControlEvents: UIControlEvents.TouchUpInside)
                self.addSubview(self.models[index])
            }
            self.layoutIfNeeded()
        }
        
        
        
    }
    private var selectedIndex:Int?
    private var objectBack = UIView()
    
    //MARK: override UIView
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.objectBack.backgroundColor = UIColor.yellowColor()
        self.addSubview(self.objectBack)
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        for index in (0..<self.models.count) {
            self.models[index].sizeToFit()
            self.models[index].frame.size = CGSizeMake(self.bounds.size.width / CGFloat(self.models.count + 1), self.bounds.size.height)
            self.models[index].center = CGPointMake(self.bounds.size.width * CGFloat(index + 1) / CGFloat(self.models.count + 1), self.bounds.size.height * 0.5)
        }
        
        if let index = self.selectedIndex {
            if let size = self.models[index].titleLabel?.frame.size {
            self.objectBack.frame.size = CGSizeMake(size.width + self.models[index].frame.size.height, self.models[index].frame.size.height)
            self.objectBack.center =  self.models[index].center
            self.objectBack.layer.cornerRadius = self.objectBack.bounds.size.height * 0.5
            self.objectBack.layer.masksToBounds = true
            }
        }
    }
    
    deinit {
    }
    
    func setObjectAtButton(sender:UIButton) {
        for index in (0..<self.models.count) {
            if self.models[index] == sender {
                self.selectedIndex = index
                break
            }
        }
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 15, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            [weak self] in
            if let index = self?.selectedIndex, button = self?.models[index] {
                self?.objectBack.frame = button.frame
            }
        }) { [weak self] (complete) in
            if let strongSelf = self, index = self?.selectedIndex {
                self?.delegate?.tabbar?(strongSelf, didSelectAtIndex: index)
            }
        }
    }
}
