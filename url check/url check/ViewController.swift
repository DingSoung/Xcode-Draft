//
//  ViewController.swift
//  url check
//
//  Created by Songwen Ding on 2017/12/18.
//  Copyright © 2017年 Songwen Ding. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let str = "https://docs.bytedance.net/doc/oQFvgPZwtjm8vmCTrACzhb"
        print(self.validateURL(url: str))
    }

    func validateURL(url: String) -> Bool {
        let urlRegex = "(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]"
        let urlPredicate = NSPredicate(format: "SELF MATCHES %@", urlRegex)
        return urlPredicate.evaluate(with: url)
    }
    func validateDocsURL(url: String) -> Bool {
        let urlRegex = "(https?)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+/(doc|sheet|folder)/+[A-Za-z0-9]{1,100}"
        let urlPredicate = NSPredicate(format: "SELF MATCHES %@", urlRegex)
        return urlPredicate.evaluate(with: url)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

