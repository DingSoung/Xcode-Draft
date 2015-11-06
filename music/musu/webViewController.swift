//
//  webViewController.swift
//  musu
//
//  Created by 丁松 on 15/3/20.
//  Copyright (c) 2015年 丁松. All rights reserved.
//

import UIKit

class webViewController: UIViewController {
    
    var url:String = "https://dingsoung.ml/"
    @IBOutlet weak var webPage: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webPage.loadRequest(NSURLRequest(URL: NSURL(string: url)!))
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
