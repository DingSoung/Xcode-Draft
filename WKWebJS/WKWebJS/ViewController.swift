//
//  ViewController.swift
//  WKWebJS
//
//  Created by Songwen Ding on 2017/11/24.
//  Copyright © 2017年 Songwen Ding. All rights reserved.
//

import UIKit
import WebKit

class ViewController: BaseWebViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem?.title = "返回"
        
        self.webView.configuration.userContentController = WKUserContentController()
        
        self.webView.configuration.userContentController.add(self, name: "Pay")
        guard let  urlStr = Bundle.main.path(forResource: "index", ofType: "html") else { return }
        let url = URL(fileURLWithPath: urlStr)
        self.webView.loadFileURL(url, allowingReadAccessTo: url)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: WKScriptMessageHandler  {
    // js call swift
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.name, message.body)
    }
}

