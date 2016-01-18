//
//  WordCloudView.swift
//  DEMO-IB
//
//  Created by Alex D. on 1/15/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class WordCloudModel: NSObject {
    var text:String = ""
    var value:Double = 0.0
    var color = UIColor.whiteColor()
    
    convenience init(text:String, value: Double, color: UIColor) {
        self.init()
        self.text = text
        self.value = value
        self.color = color
    }
}

class WordCloudView: UIView {

    var models:[WordCloudModel] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()
        
        self.models = [
            WordCloudModel(text:"111", value: 121, color: UIColor.redColor()),
            WordCloudModel(text:"222", value: 222, color: UIColor.greenColor()),
            WordCloudModel(text:"333", value: 333, color: UIColor.blueColor()),
        ]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setNeedsDisplay()
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        // 绘图算法
        for _ in models {
            //prepare word....
            let unitLenght:CGFloat = 20 //<-- min lenght of word
            var drawed = false
            
            //radius < view size * 0.5
            for (var latitude = 0; drawed == false && CGFloat(latitude) * unitLenght < 0.5 * min(self.frame.size.width, self.frame.size.height); latitude++) {
                
                //2 * M_PI * radius = perimeter
                //radian = unitLenght/radius = unitLenght / (latitude * unitLenght) = 1/latitude
                for (var radian = 0.0; drawed == false && radian < 2 * M_PI; radian = radian + 1.0 / Double(latitude)) {
                    
                    // preset 45
                    for (var angle = 0.0; drawed == false && angle < M_PI; angle = angle + 0.25 * M_PI) {
                        if (checkSpace() == true) {
                            drawed = true
                            asyncDrawWord()
                        }
                    }
                }
            }
        }
        
        
        
        WordCloudView.test()
        
    }
    
    class func test() {
    }
}

private func checkSpace() -> Bool {
    return true
}

private func asyncDrawWord() {
    
}




