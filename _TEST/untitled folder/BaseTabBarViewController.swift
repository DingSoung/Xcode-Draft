//
//  BaseTabBarViewController.swift
//  niuniu
//
//  Created by Alex on 15/10/17.
//  Copyright © 2015年 Alex. All rights reserved.
//

import UIKit

class BaseTabBarViewController: UITabBarController {

    override func loadView() {
        super.loadView()
        
        let test = UIStoryboard(name: "Test", bundle: nil).instantiateViewControllerWithIdentifier("TestViewController") as! TestViewController
        var vcs = [test]
        for vc in vcs {
            let nav = UINavigationController(rootViewController: vc)
            nav.tabBarItem.image = UIImage(named: "")
            nav.tabBarItem.selectedImage = UIImage(named: "")
            self.viewControllers?.append(nav)
        }
    }
}
