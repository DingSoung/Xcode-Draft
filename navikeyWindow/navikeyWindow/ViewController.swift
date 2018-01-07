//
//  ViewController.swift
//  navikeyWindow
//
//  Created by Songwen Ding on 2017/12/22.
//  Copyright © 2017年 DingSoung. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    let web = WKWebView()
    let cover = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.orange
        self.view.addSubview(web)
        self.cover.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //self.web.frame = CGRect(x: 0, y: 0, width: 300, height: 500)
        self.cover.frame = self.cover.superview?.bounds ?? CGRect.zero
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIApplication.shared.keyWindow?.addSubview(self.cover)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

