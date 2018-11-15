//
//  ViewController.swift
//  DEMO
//
//  Created by Songwen on 2018/9/10.
//  Copyright © 2018 Songwen. All rights reserved.
//

import UIKit
import Network
import SystemConfiguration

class ViewController: UIViewController {

    let reach = SCNetworkReachability.reachabilityForInternetConnection
    override func viewDidLoad() {
        super.viewDidLoad()
        reach?.updateCallBack = { (r) in
            self.view.backgroundColor = (self.reach?.currentReachabilityStatus == .notReachable ? UIColor.red : UIColor.green)
        }
        reach?.start()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

