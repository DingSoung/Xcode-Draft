//
//  ViewController.swift
//  ThumbsOnTheRun
//
//  Created by 丁松 on 14-8-27.
//  Copyright (c) 2014年 丁松. All rights reserved.
//

import UIKit

class ViewController: UIViewController, LTMorphingLabelDelegate {
    
    var i = 0
    var textArray = ["Design", "Design is not just", "what it looks like", "and feels like.", "Design", "is how it works.", "- Steve Jobs", "Older people", "sit down and ask,", "'What is it?'", "but the boy asks,", "'What can I do with it?'.", "- Steve Jobs", "", "Swift", "Objective-C", "iPhone", "iPad", "Mac Mini", "MacBook Pro", "Mac Pro", "老婆 & 女儿"]
    var text:String {
        get {
            if i >= countElements(textArray) {
                i = 0
            }
            return textArray[i++]
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.welcomeLabel.delegate = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var welcomeLabel: LTMorphingLabel!
    @IBAction func welcomeButtom(sender: AnyObject) {
        welcomeLabel.text = text
    }
    
    @IBAction func welcomeStyle(sender: AnyObject) {
        let seg = sender as UISegmentedControl
        switch seg.selectedSegmentIndex {
        case 1:
            self.welcomeLabel.morphingEffect = .Evaporate
        case 2:
            self.welcomeLabel.morphingEffect = .Fall
        case 3:
            self.welcomeLabel.morphingEffect = .Pixelate
        case 4:
            self.welcomeLabel.morphingEffect = .Sparkle
        case 5:
            self.welcomeLabel.morphingEffect = .Burn
        case 6:
            self.welcomeLabel.morphingEffect = .Anvil
        default:
            self.welcomeLabel.morphingEffect = .Scale
        }
    }
    
    
    
    
    
    
}

