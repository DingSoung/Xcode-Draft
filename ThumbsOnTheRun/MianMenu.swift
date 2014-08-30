//
//  mianMenu.swift
//  ThumbsOnTheRun
//
//  Created by 丁松 on 14-8-30.
//  Copyright (c) 2014年 丁松. All rights reserved.
//

import UIKit

class MainMenu: UIViewController, SideMenuDelegate {
    
    var sideMenu : SideMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        sideMenu = SideMenu(sourceView: self.view, menuData: ["UIDynamics", "UIGestures", "UIBlurEffect"])
        sideMenu!.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sideMenuDidSelectItemAtIndex(index: Int) {
        sideMenu?.toggleMenu()
    }
    
    @IBAction func toggleSideMenu(sender: AnyObject) {
        sideMenu?.toggleMenu()
    }
    
    
}