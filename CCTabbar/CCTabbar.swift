//
//  CCTabbar.swift
//  DEMO
//
//  Created by Alex D. on 3/25/16.
//  Copyright © 2016 ifnil. All rights reserved.
//

import UIKit
protocol CCTabbarDelegate {
    func tabbar(tabbar: CCTabbar?, didselected button: UIButton)
}

@IBDesignable public class CCTabbar: UIView {
    
    public var tabs:[String] = [] {
        didSet {
            for tabObject in self.tabObjects {
                tabObject.removeFromSuperview()
            }
            self.tabObjects.removeAll()
            
            for index in (0..<self.tabs.count)  {
                let tabObject = UIButton()
                tabObject.setTitle(self.tabs[index], forState: UIControlState.Normal)
                tabObject.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
                tabObject.sizeToFit()
                tabObject.addTarget(self, action: #selector(self.setObjectAtButton), forControlEvents: UIControlEvents.TouchUpInside)
                self.addSubview(tabObject)
                self.tabObjects.append(tabObject)
            }
            self.layoutIfNeeded()
        }
    }
    internal var delegate:CCTabbarDelegate?
    
    private var tabObjects:[UIButton] = []
    private var selectedObject:UIButton?
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
        for index in (0..<self.tabObjects.count) {
            tabObjects[index].center = CGPointMake(self.bounds.size.width * CGFloat(index + 1) / CGFloat(self.tabObjects.count + 1), self.bounds.size.height * 0.5)
        }
        if let rect = self.selectedObject?.frame {
            self.objectBack.frame = CGRectMake(rect.origin.x - rect.size.height * 0.3, rect.origin.y, rect.size.width + rect.size.height * 0.6, rect.size.height)
            self.objectBack.layer.cornerRadius = self.objectBack.bounds.size.height * 0.5
            self.objectBack.layer.masksToBounds = true
        }
    }
    
    deinit {
    }
    
    func setObjectAtButton(sender:UIButton) {
        self.selectedObject = sender
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 15, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            [weak self] in
            if let button = self?.selectedObject {
                self?.objectBack.frame = button.frame
            }
            }) { [weak self] (complete) in
                self?.delegate?.tabbar(self, didselected: sender)
        }
    }
    
}