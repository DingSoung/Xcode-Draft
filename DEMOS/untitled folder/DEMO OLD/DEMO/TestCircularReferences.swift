//
//  TestCircularReferences.swift
//  DEMO
//
//  Created by Alex D. on 12/25/15.
//  Copyright © 2015 Alex. All rights reserved.
//

import Foundation

class CircularReferencesYES: NSObject {
    var name:String
    var block:(()->Void)?
    init(name:String) {
        self.name = name
        super.init()
        self.block = {()->Void in   //<--- 这里  self --> block --> self 循环引用自己了, 导致无法自动释放 deinit 没有执行
            print("this is  \(self.name)")
        }
    }
    
    deinit {
        print("release  \(self.name)")
    }
}

class CircularReferencesNO: NSObject {
    var name:String
    var block:(()->Void)?
    init(name:String) {
        self.name = name
        super.init()
        self.block = {[weak self]()->Void in
            print("this is  \(self?.name)")
        }
    }
    
    deinit {
        print("release  \(self.name)")
    }
}

class TestCircularReferences: NSObject {
    override init() {
        super.init()
        
        print("---->test YES")
        var test1 = CircularReferencesYES(name: "YES one")
        test1.block?()
        test1 = CircularReferencesYES(name: "YES two")
        test1.block?()
        
        
        print("---->test NO")
        var test2 = CircularReferencesNO(name: "NO one")
        test2.block?()
        test2 = CircularReferencesNO(name: "NO two")
        test2.block?()
    }

}