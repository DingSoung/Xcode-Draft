//
//  ViewController.swift
//  DEMO-GIF
//
//  Created by Alex D. on 2/22/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let webView = UIWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.yellowColor()
        self.webView.backgroundColor = UIColor.clearColor()
        self.webView.userInteractionEnabled = false
        self.webView.userInteractionEnabled = false
        self.webView.scalesPageToFit = true
        self.view.addSubview(self.webView)
        
        let filePath = NSBundle.mainBundle().pathForResource("railway", ofType: "gif")
        let gif = NSData(contentsOfFile: filePath!)
        self.webView.loadData(gif!, MIMEType: "image/gif", textEncodingName: String(), baseURL: NSURL())
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.webView.frame = CGRectMake(100, 100, 200, 300)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

