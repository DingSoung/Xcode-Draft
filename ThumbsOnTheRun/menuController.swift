//
//  menuController.swift
//  ThumbsOnTheRun
//
//  Created by 丁松 on 14-8-27.
//  Copyright (c) 2014年 丁松. All rights reserved.
//

import UIKit

class menuController: UIViewController, SideMenuDelegate {
    
    var sideMenu : SideMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        sideMenu = SideMenu(sourceView: self.view, menuData: ["节奏模式", "3D模式", "设置"])
        sideMenu!.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sideMenuDidSelectItemAtIndex(index: Int) {
        sideMenu?.toggleMenu()
    }
    
    @IBAction func menuToggle(sender: AnyObject) {
        sideMenu?.toggleMenu()
    }
}
