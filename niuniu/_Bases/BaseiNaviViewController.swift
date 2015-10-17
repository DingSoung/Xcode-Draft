//
//  BaseViewController.swift
//  summer
//
//  Created by Alex D. on 15/8/7.
//  Copyright (c) 2015年 Alex D. All rights reserved.
//

import UIKit
import ReactiveCocoa

class BaseiNaviViewController: BaseViewController {
    
    internal var srcVC:UIViewController?
    internal var rightBarButtonAction:(() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        
        self.navigationItem.leftBarButtonItem?.rac_command = RACCommand(signalBlock: { (signal) -> RACSignal! in
            if self.navigationController == nil || self.navigationController?.viewControllers.count <= 1 {
                self.dismissViewControllerAnimated(true, completion: nil)
            }else{
                if let v = self.srcVC {
                    self.navigationController?.popToViewController(v, animated: true)
                }else{
                    self.navigationController?.popViewControllerAnimated(true)
                }
            }
            return RACSignal.empty()
        })
        self.navigationItem.rightBarButtonItem?.rac_command = RACCommand(signalBlock: { (signal) -> RACSignal! in
            self.rightBarButtonAction?()
            return RACSignal.empty()
        })
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.hidden = true
        self.navigationController?.navigationBarHidden = false
    }
}


