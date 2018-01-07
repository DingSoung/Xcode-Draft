//
//  ViewController.swift
//  menuController
//
//  Created by Songwen Ding on 2017/11/22.
//  Copyright © 2017年 Songwen Ding. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    let webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.addSubview(self.webView)
        self.webView.
        let menucontroller = UIMenuController.shared
        let heiheiheiItem = UIMenuItem(title: "嘿嘿嘿", action: #selector(ViewController.heiheiheiAction(sender:)))
        print(menucontroller.menuItems ?? "")
        //menucontroller.menuItems = [heiheiheiItem]
        menucontroller.menuItems?.append(heiheiheiItem)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let url = URL(string: "https://www.baidu.com") else {return}
        let request = URLRequest(url: url)
        self.webView.load(request)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.webView.frame = self.view.bounds
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func heiheiheiAction(sender: UIMenuItem) {
        print(sender)
    }
}
