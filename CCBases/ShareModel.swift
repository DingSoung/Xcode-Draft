//
//  ShareModel.swift
//  summer
//
//  Created by Alex D. on 15/8/13.
//  Copyright (c) 2015年 Alex D. All rights reserved.
//

import Foundation
class ShareModel: NSObject {
    static let instance = ShareModel()
    
    
    var index:String!
    
    private override init() {
        super.init()
        
        index = "hello shareModel"
    }
    
    func function(){
        print(index)
    }
}