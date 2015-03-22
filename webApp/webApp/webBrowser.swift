//
//  File.swift
//  ThumbsOnTheRun
//
//  Created by 丁松 on 14/12/29.
//  Copyright (c) 2014年 丁松. All rights reserved.
//

import UIKit

class webBrowser: UIViewController {
    
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var webPage: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        address.text = "https://github.com/DingSoung"
        updateWeb(NSURL(string: address.text)!)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func checkAddress(addr: String){

    }
    func updateWeb(url: NSURL){
        var request:NSURLRequest = NSURLRequest(URL: url)
        webPage.loadRequest(request)
    }
    
    
    @IBAction func go(sender: AnyObject) {
        self.view.endEditing(true)
        if !address.text.hasPrefix("http://") && !address.text.hasPrefix("https://") {
            address.text = "http://" + address.text
        }
        updateWeb(NSURL(string: address.text)!)
    }
    
    
    
}