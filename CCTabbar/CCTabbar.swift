//
//  CCTabbar.swift
//  DEMO
//
//  Created by Alex D. on 3/25/16.
//  Copyright © 2016 ifnil. All rights reserved.
//

import UIKit

public class CCTabbar: UIView {
    
    public var tabs:[String] = [] {
        didSet {
            
            self.tabObjects.removeAll()
            for tab in self.tabs {
                let tabObject = UIButton()
                tabObject.titleLabel?.text = tab
            }
            
            
        }
    }
    private var tabObjects:[UIButton] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
    }
}