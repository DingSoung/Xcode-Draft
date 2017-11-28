//
//  ViewController.swift
//  tow
//
//  Created by Songwen Ding on 2017/11/24.
//  Copyright © 2017年 Songwen Ding. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func action(_ sender: Any) {
        // TODO: Bare临时授权代码
        var dict = Dictionary<String, Any>()
        guard let params = (url.query as? NSString)?.components(separatedBy: "&") else { return }
        params.forEach { (param) in
            let strs = (param as NSString).components(separatedBy: "=")
            guard let key = strs.first, let value = strs.last else { return }
            dict[key] = value
        }
        guard let client = dict["client"], let secret = dict["secret"], client == "bare", secret == "i7B$FJhBDv$!7d!r*!Wg!hwmVa$8a3Mi" else { return }
        //读取token
        guard let url = URL(string: client + "://authorized/?token=" + "xxxxxx") else { return }
        UIApplication.shared.openURL(url)
        // TODO: Bare临时授权代码结束
        guard let url = URL(string: "one://") else {
            print("two call one:// fail")
            return
        }
        print(UIApplication.shared.canOpenURL(url))
        UIApplication.shared.open(url, options: ["key": "form two"], completionHandler: { (complete) in
            print(complete)
        })
    }
    

}

